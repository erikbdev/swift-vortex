public struct HTMLInlineStyle<Content: AsyncHTML>: AsyncHTML {
  let content: Content
  var styles: OrderedSet<InlineStyle>

  public var body: Never { fatalError() }

  public func inlineStyle(
    _ property: String,
    _ value: String?,
    media mediaQuery: InlineStyle.MediaQuery? = nil,
    pre: InlineStyle.Selector = "",
    pseudo: InlineStyle.Pseudo? = nil,
    post: InlineStyle.Selector = ""
  ) -> Self {
    var copy = self
    if let value {
      copy.styles.append(
        InlineStyle(
          property: property,
          value: value,
          media: mediaQuery,
          preSelector: pre,
          pseudoSelector: pseudo,
          postSelector: post
        )
      )
    }
    return copy
  }

  #if !hasFeature(Embedded)
    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      // try await withDependencies {
      //   html.resolveStyles(&$0.htmlContext)
      // } operation: {
      //   try await Content._render(html.content, into: &output)
      // }
    }
  #endif

  private func resolveStyles(_ htmlContext: inout HTMLContext) {
    guard let ssg = htmlContext.styles else {
      for style in self.styles {
        htmlContext.attributes["style", default: ""]
          .append("\(style.property): \(style.value);")
      }
      return
    }

    let classes = ssg.generate(self.styles)

    guard !classes.isEmpty else { return }

    htmlContext.attributes["class", default: ""]
      .append((htmlContext.attributes.keys.contains("class") ? " " : "") + classes.joined(separator: " "))
  }
}

extension HTMLInlineStyle: HTML where Content: HTML {
  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    // withDependencies {
    //   html.resolveStyles(&$0.htmlContext)
    // } operation: {
    //   Content._render(
    //     html.content,
    //     into: &output
    //   )
    // }
  }
}

extension HTMLInlineStyle: Sendable where Content: Sendable {}

extension AsyncHTML {
  public func inlineStyle(
    _ property: String,
    _ value: String?,
    media mediaQuery: InlineStyle.MediaQuery? = nil,
    pre: InlineStyle.Selector = "",
    pseudo: InlineStyle.Pseudo? = nil,
    post: InlineStyle.Selector = ""
  ) -> HTMLInlineStyle<Self> {
    HTMLInlineStyle(
      content: self,
      styles: value.flatMap {
        [
          InlineStyle(
            property: property,
            value: $0,
            media: mediaQuery,
            preSelector: pre,
            pseudoSelector: pseudo,
            postSelector: post
          )
        ]
      } ?? []
    )
  }
}

public struct InlineStyle: Sendable, Hashable {
  let property: String
  let value: String
  let media: MediaQuery?
  let preSelector: Selector
  let pseudoSelector: Pseudo?
  let postSelector: Selector

  public struct Selector: Sendable, Hashable, ExpressibleByStringLiteral {
    public let rawValue: String

    public init(
      leadingSpace: Bool = false,
      _ selector: String,
      trailingSpace: Bool = false
    ) {
      self.rawValue = "\(leadingSpace ? " " : "")\(selector)\(trailingSpace ? " " : "")"
    }

    public init(stringLiteral value: StringLiteralType) {
      self.init(value)
    }
  }

  public struct Pseudo: Sendable, Hashable {
    private var name: String
    private var isElement: Bool

    var rawValue: String { ":\(self.isElement ? ":" : "")\(self.name)" }

    public init(element: Bool, name: String = #function) {
      self.name = name
      self.isElement = element
    }

    public init(class: Bool, name: String = #function) {
      self.name = name
      self.isElement = !`class`
    }

    public static let active = Self(class: true)
    public static let after = Self(element: true)
    public static let before = Self(element: true)
    public static let checked = Self(element: true)
    public static let disabled = Self(element: true)
    public static let empty = Self(class: true)
    public static let firstChild = Self(class: true, name: "first-child")
  }

  public struct MediaQuery: Sendable, Hashable, RawRepresentable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    private var values: [String] = []

    public var rawValue: String { self.values.joined(separator: " ") }

    public init(rawValue: String) {
      self.values = [rawValue]
    }

    public init(stringLiteral value: String) {
      self.init(rawValue: value)
    }

    private init(_ values: [String]) {
      self.values = values
    }

    public func and(_ query: Self) -> Self {
      var copy = self
      copy.values.append("and")
      copy.values.append(contentsOf: query.values)
      return copy
    }

    public func or(_ query: Self) -> Self {
      var copy = self
      copy.values.append(",")
      copy.values.append(contentsOf: query.values)
      return copy
    }

    public func not(_ query: Self) -> Self {
      var copy = self
      copy.values.append("not")
      copy.values.append(contentsOf: query.values)
      return copy
    }

    public static func only(_ query: Self) -> Self {
      Self(["only"] + query.values)
    }

    public static var all: Self { #function }
    public static var print: Self { #function }
    public static var screen: Self { #function }

    public static func minWidth(_ value: Int) -> Self {
      "(min-width: \(value)px)"
    }

    public static func maxWidth(_ value: Int) -> Self {
      "(max-width: \(value)px)"
    }
  }
}
