// import OrderedCollections

public struct HTMLTag: Hashable, Sendable {
  public let rawValue: String

  #if !hasFeature(Embedded)
    public typealias Closure<Content: AsyncHTML> = () -> Content
    public typealias AsyncClosure<Content: AsyncHTML> = @Sendable () async throws -> Content
  #else
    public typealias Closure<Content: HTML> = () -> Content
  #endif

  // @inlinable @inline(__always)
  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }

  // @inlinable @inline(__always)
  @_disfavoredOverload
  public func callAsFunction() -> HTMLElement<EmptyHTML> {
    HTMLElement(tag: rawValue, content: EmptyHTML.init)
  }

  // @inlinable @inline(__always)
  // @_disfavoredOverload
  // public func callAsFunction(_ attributes: HTMLAttribute...) -> HTMLAttributes<HTMLElement<EmptyHTML>> {
  //   self.callAsFunction(attributes: attributes)
  // }

  // // @inlinable @inline(__always)
  // public func callAsFunction(attributes: [HTMLAttribute]) -> HTMLAttributes<HTMLElement<EmptyHTML>> {
  //   HTMLAttributes(
  //     attributes: .init(attributes),
  //     content: HTMLElement(tag: rawValue, content: EmptyHTML.init)
  //   )
  // }

  // @inlinable @inline(__always)
  public func callAsFunction<Content: HTML>(@HTMLBuilder content: Closure<Content>) -> HTMLElement<Content> {
    HTMLElement(tag: rawValue, content: content)
  }

  // @inlinable @inline(__always)
  // @_disfavoredOverload
  // public func callAsFunction<Content: HTML>(
  //   _ attributes: HTMLAttribute...,
  //   @HTMLBuilder content: Closure<Content>
  // ) -> HTMLAttributes<HTMLElement<Content>> {
  //   self.callAsFunction(attributes: attributes, content: content)
  // }

  // @inlinable @inline(__always)
  // public func callAsFunction<Content: HTML>(
  //   attributes: [HTMLAttribute],
  //   @HTMLBuilder content: Closure<Content>
  // ) -> HTMLAttributes<HTMLElement<Content>> {
  //   HTMLAttributes(
  //     attributes: .init(attributes),
  //     content: HTMLElement(tag: rawValue, content: content)
  //   )
  // }

  #if !hasFeature(Embedded)
    // @inlinable @inline(__always)
    public func callAsFunction<Content: AsyncHTML>(@HTMLBuilder content: @escaping AsyncClosure<Content>) -> HTMLElement<AsyncHTMLContent<Content>> {
      HTMLElement(tag: rawValue, content: content)
    }

    // @inlinable @inline(__always)
    // @_disfavoredOverload
    // public func callAsFunction<Content: AsyncHTML>(
    //   _ attributes: HTMLAttribute...,
    //   @HTMLBuilder content: @escaping AsyncClosure<Content>
    // ) -> HTMLAttributes<HTMLElement<AsyncHTMLContent<Content>>> {
    //   self.callAsFunction(attributes: attributes, content: content)
    // }

    // // @inlinable @inline(__always)
    // public func callAsFunction<Content: AsyncHTML>(
    //   attributes: [HTMLAttribute],
    //   @HTMLBuilder content: @escaping AsyncClosure<Content>
    // ) -> HTMLAttributes<HTMLElement<AsyncHTMLContent<Content>>> {
    //   HTMLAttributes(
    //     attributes: .init(attributes),
    //     content: HTMLElement(tag: rawValue, content: content)
    //   )
    // }
  #endif
}

public struct HTMLVoidTag: Hashable, Sendable {
  public let rawValue: String

  // @inlinable @inline(__always)
  public init(_ tag: String) {
    rawValue = tag
  }

  // @inlinable @inline(__always)
  public func callAsFunction() -> HTMLVoidElement {
    HTMLVoidElement(tag: rawValue)
  }

  // @inlinable @inline(__always)
  // @_disfavoredOverload
  // public func callAsFunction(_ attributes: HTMLAttribute...) -> HTMLAttributes<HTMLVoidElement> {
  //   self.callAsFunction(attributes: attributes)
  // }

  // // @inlinable @inline(__always)
  // public func callAsFunction(attributes: [HTMLAttribute]) -> HTMLAttributes<HTMLVoidElement> {
  //   HTMLAttributes(
  //     attributes: .init(attributes),
  //     content: HTMLVoidElement(tag: rawValue)
  //   )
  // }
}

public typealias tag = HTMLTag

public var a: HTMLTag { HTMLTag("a") }
public var abbr: HTMLTag { HTMLTag("abbr") }
public var acronym: HTMLTag { HTMLTag("acronym") }
public var address: HTMLTag { HTMLTag("address") }
public var area: HTMLVoidTag { HTMLVoidTag("area") }
public var article: HTMLTag { HTMLTag("article") }
public var aside: HTMLTag { HTMLTag("aside") }
public var audio: HTMLTag { HTMLTag("audio") }
public var b: HTMLTag { HTMLTag("b") }
public var base: HTMLVoidTag { HTMLVoidTag("base") }
public var bdi: HTMLTag { HTMLTag("bdi") }
public var bdo: HTMLTag { HTMLTag("bdo") }
public var blockquote: HTMLTag { HTMLTag("blockquote") }
@available(*, deprecated, message: "Use `HTMLDocument.body` instead")
public var body: HTMLTag { HTMLTag("body") }
public var br: HTMLVoidTag { HTMLVoidTag("br") }
public var button: HTMLTag { HTMLTag("button") }
public var canvas: HTMLTag { HTMLTag("canvas") }
public var caption: HTMLTag { HTMLTag("caption") }
public var cite: HTMLTag { HTMLTag("cite") }
public var code: HTMLTag { HTMLTag("code") }
public var col: HTMLVoidTag { HTMLVoidTag("col") }
public var colgroup: HTMLTag { HTMLTag("colgroup") }
public var data: HTMLTag { HTMLTag("data") }
public var datalist: HTMLTag { HTMLTag("datalist") }
public var dd: HTMLTag { HTMLTag("dd") }
public var del: HTMLTag { HTMLTag("del") }
public var details: HTMLTag { HTMLTag("details") }
public var dfn: HTMLTag { HTMLTag("dfn") }
public var dialog: HTMLTag { HTMLTag("dialog") }
public var div: HTMLTag { HTMLTag("div") }
public var dl: HTMLTag { HTMLTag("dl") }
public var dt: HTMLTag { HTMLTag("dt") }
public var em: HTMLTag { HTMLTag("em") }
public var embed: HTMLVoidTag { HTMLVoidTag("embed") }
public var fieldset: HTMLTag { HTMLTag("fieldset") }
public var figcaption: HTMLTag { HTMLTag("figcaption") }
public var figure: HTMLTag { HTMLTag("figure") }
public var footer: HTMLTag { HTMLTag("footer") }
public var form: HTMLTag { HTMLTag("form") }
public var h1: HTMLTag { HTMLTag("h1") }
public var h2: HTMLTag { HTMLTag("h2") }
public var h3: HTMLTag { HTMLTag("h3") }
public var h4: HTMLTag { HTMLTag("h4") }
public var h5: HTMLTag { HTMLTag("h5") }
public var h6: HTMLTag { HTMLTag("h6") }
@available(*, deprecated, message: "Use `HTMLDocument.head` instead")
public var head: HTMLTag { HTMLTag("head") }
public var header: HTMLTag { HTMLTag("header") }
public var hgroup: HTMLTag { HTMLTag("hgroup") }
public var hr: HTMLVoidTag { HTMLVoidTag("hr") }
public var html: HTMLTag { HTMLTag("html") }
public var i: HTMLTag { HTMLTag("i") }
public var iframe: HTMLTag { HTMLTag("iframe") }
public var img: HTMLVoidTag { HTMLVoidTag("img") }
public var input: HTMLVoidTag { HTMLVoidTag("input") }
public var ins: HTMLTag { HTMLTag("ins") }
public var kbd: HTMLTag { HTMLTag("kbd") }
public var label: HTMLTag { HTMLTag("label") }
public var legend: HTMLTag { HTMLTag("legend") }
public var li: HTMLTag { HTMLTag("li") }
public var link: HTMLVoidTag { HTMLVoidTag("link") }
public var main: HTMLTag { HTMLTag("main") }
public var map: HTMLTag { HTMLTag("map") }
public var mark: HTMLTag { HTMLTag("mark") }
public var meta: HTMLVoidTag { HTMLVoidTag("meta") }
public var meter: HTMLTag { HTMLTag("meter") }
public var nav: HTMLTag { HTMLTag("nav") }
public var noscript: HTMLTag { HTMLTag("noscript") }
public var object: HTMLTag { HTMLTag("object") }
public var ol: HTMLTag { HTMLTag("ol") }
public var optgroup: HTMLTag { HTMLTag("optgroup") }
public var option: HTMLTag { HTMLTag("option") }
public var output: HTMLTag { HTMLTag("output") }
public var p: HTMLTag { HTMLTag("p") }
public var param: HTMLVoidTag { HTMLVoidTag("param") }
public var picture: HTMLTag { HTMLTag("picture") }
public var pre: HTMLTag { HTMLTag("pre") }
public var progress: HTMLTag { HTMLTag("progress") }
public var q: HTMLTag { HTMLTag("q") }
public var rp: HTMLTag { HTMLTag("rp") }
public var rt: HTMLTag { HTMLTag("rt") }
public var ruby: HTMLTag { HTMLTag("ruby") }
public var s: HTMLTag { HTMLTag("s") }
public var samp: HTMLTag { HTMLTag("samp") }
// public func script(
//   _ attributes: HTMLAttribute...,
//   stript text: () -> String = { "" }
// ) -> HTMLAttributes<HTMLElement<HTMLString>> {
//   let text = text()
//   var escaped = ""
//   escaped.unicodeScalars.reserveCapacity(text.unicodeScalars.count)
//   for index in text.unicodeScalars.indices {
//     let scalar = text.unicodeScalars[index]
//     if scalar == "<",
//       text.unicodeScalars[index...].starts(with: "<!--".unicodeScalars)
//         || text.unicodeScalars[index...].starts(with: "<script".unicodeScalars)
//         || text.unicodeScalars[index...].starts(with: "</script".unicodeScalars)
//     {
//       escaped.unicodeScalars.append(contentsOf: #"\x3C"#.unicodeScalars)
//     } else {
//       escaped.unicodeScalars.append(scalar)
//     }
//   }
//   return HTMLAttributes(
//     attributes: .init(attributes),
//     content: tag("script") {
//       // HTMLRaw(text)
//     }
//   )
// }
public var section: HTMLTag { HTMLTag("section") }
public var select: HTMLTag { HTMLTag("select") }
public var small: HTMLTag { HTMLTag("small") }
public var source: HTMLVoidTag { HTMLVoidTag("source") }
public var span: HTMLTag { HTMLTag("span") }
public var strong: HTMLTag { HTMLTag("strong") }
public var style: HTMLTag { HTMLTag("style") }
// public func style(
//   _ attributes: HTMLAttribute...,
//   style stringValue: () -> String = { "" }
// ) -> HTMLAttributes<HTMLElement<HTMLString>> {
//   HTMLAttributes(
//     attributes: .init(attributes),
//     content: HTMLElement(tag: "style") {
//       // HTMLString(raw: stringValue())
//     }
//   )
// }
public var sub: HTMLTag { HTMLTag("sub") }
public var summary: HTMLTag { HTMLTag("summary") }
public var sup: HTMLTag { HTMLTag("sup") }
public var svg: HTMLTag { HTMLTag("svg") }
public var table: HTMLTag { HTMLTag("table") }
public var tbody: HTMLTag { HTMLTag("tbody") }
public var td: HTMLTag { HTMLTag("td") }
public var template: HTMLTag { HTMLTag("template") }
public var textarea: HTMLTag { HTMLTag("textarea") }
public var tfoot: HTMLTag { HTMLTag("tfoot") }
public var th: HTMLTag { HTMLTag("th") }
public var thead: HTMLTag { HTMLTag("thead") }
public var time: HTMLTag { HTMLTag("time") }
public var title: HTMLTag { HTMLTag("title") }
public var tr: HTMLTag { HTMLTag("tr") }
public var track: HTMLVoidTag { HTMLVoidTag("track") }
public var u: HTMLTag { HTMLTag("u") }
public var ul: HTMLTag { HTMLTag("ul") }
public var `var`: HTMLTag { HTMLTag("`var`") }
public var video: HTMLTag { HTMLTag("video") }
public var wbr: HTMLVoidTag { HTMLVoidTag("wbr") }
