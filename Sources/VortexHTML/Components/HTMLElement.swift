#if !hasFeature(Embedded)
  public struct HTMLElement<Content: AsyncHTML>: AsyncHTML {
    public let tag: String
    let content: Content

    public init<Awaitable: AsyncHTML>(
      tag: String = #function,
      @HTMLBuilder content: @escaping @Sendable () async throws -> Awaitable
    ) where Content == AsyncHTMLContent<Awaitable> {
      self.tag = tag
      self.content = AsyncHTMLContent(content: content)
    }

    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {
      try await HTMLVoidElement._render(
        HTMLVoidElement(tag: html.tag),
        into: &output,
        context: context
      )
      var context = context
      context.attributes.removeAll()
      context.depth += 1
      try await Content._render(html.content, into: &output, context: context)
      var buffer: [UInt8] = []
      buffer.append(0x3C)  // <
      buffer.append(0x2F)  // /
      buffer.append(contentsOf: html.tag.utf8)  // <tag-name>
      buffer.append(0x3E)  // >
      try await output.write(buffer)
    }
  }

  extension HTMLElement: HTML where Content: HTML {
    @_spi(Internals)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) {
      HTMLVoidElement._render(
        HTMLVoidElement(tag: html.tag),
        into: &output,
        context: context
      )
      var context = context
      context.attributes.removeAll()
      context.depth += 1
      Content._render(html.content, into: &output, context: context)
      var buffer: [UInt8] = []
      buffer.append(0x3C)  // <
      buffer.append(0x2F)  // /
      buffer.append(contentsOf: html.tag.utf8)  // <tag-name>
      buffer.append(0x3E)  // >
      output.write(buffer)
    }
  }
#else
  public struct HTMLElement<Content: HTML>: HTML {
    public let tag: String

    let content: Content

    @_spi(Internals)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) {
      HTMLVoidElement._render(
        HTMLVoidElement(tag: html.tag),
        into: &output,
        context: context
      )
      var context = context
      context.attributes.removeAll()
      context.depth += 1
      Content._render(html.content, into: &output, context: context)
      var buffer: [UInt8] = []
      buffer.append(0x3C)  // <
      buffer.append(0x2F)  // /
      buffer.append(contentsOf: html.tag.utf8)  // <tag-name>
      buffer.append(0x3E)  // >
      output.write(buffer)
    }
  }
#endif

extension HTMLElement {
  public var body: Never { fatalError() }

  public init(
    tag: String = #function,
    @HTMLBuilder content: () -> Content
  ) {
    self.tag = tag
    self.content = content()
  }
}

public struct HTMLVoidElement: HTML, Sendable {
  public let tag: String

  public var body: Never { fatalError() }

  public init(tag: String) {
    self.tag = tag
  }

  @_spi(Internals)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into writer: inout Output,
    context: HTMLContext

  ) {
    var buffer: [UInt8] = []
    html.writeBytes(&buffer, context: context)
    writer.write(buffer)
  }

  private func writeBytes(_ buffer: inout [UInt8], context: HTMLContext) {
    buffer.append(0x3C)  // <
    buffer.append(contentsOf: self.tag.utf8)  // tag-name
    for (name, value) in context.attributes {
      buffer.append(0x20)  // space
      buffer.append(contentsOf: name.utf8)  // <name>
      if !value.isEmpty {
        buffer.append(0x3D)  // =
        buffer.append(0x22)  // "
        for byte in value.utf8 {
          switch byte {
          case 0x26:  // &
            buffer.append(contentsOf: "&amp;".utf8)
          case 0x22:  // "
            buffer.append(contentsOf: "&quot;".utf8)
          case 0x27:  // '
            buffer.append(contentsOf: "&#39;".utf8)
          default:
            buffer.append(byte)
          }
        }
        buffer.append(0x22)  // "
      }
    }
    buffer.append(0x3E)  // >
  }

  #if !hasFeature(Embedded)
    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {
      var buffer: [UInt8] = []
      html.writeBytes(&buffer, context: context)
      try await output.write(buffer)
    }
  #endif
}

extension HTMLElement: Sendable where Content: Sendable {}
