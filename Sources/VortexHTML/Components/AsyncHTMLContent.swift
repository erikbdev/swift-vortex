#if !hasFeature(Embedded)
  public struct AsyncHTMLContent<Content: AsyncHTML>: AsyncHTML {
    @usableFromInline
    let content: @Sendable () async throws -> Content

    @inlinable @inline(__always)
    public var body: Never { fatalError() }

    @inlinable @inline(__always)
    public init(@HTMLBuilder content: @escaping @Sendable () async throws -> Content) {
      self.content = content
    }

    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {
      try await Content._render(html.content(), into: &output, context: context)
    }
  }

  @available(*, unavailable, message: "'AsyncHTMLContent' cannot run in synchronous context.")
  extension AsyncHTMLContent: HTML where Content: HTML {}

  extension AsyncHTMLContent: Sendable where Content: Sendable {}
#endif
