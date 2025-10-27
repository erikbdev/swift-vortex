#if !hasFeature(Embedded)
  public protocol AsyncHTML {
    /// The type of the HTML content this body represents.
    associatedtype Body: AsyncHTML

    /// The HTML body of this component.
    @HTMLBuilder var body: Self.Body { get }

    @_spi(Render)
    static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws
  }

  public protocol HTML: AsyncHTML where Self.Body: HTML {
    @_spi(Render)
    static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    )
  }

  extension AsyncHTML {
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      try await Body._render(html.body, into: &output)
    }
  }
#else
  public protocol HTML {
    associatedtype Body: HTML

    @HTMLBuilder var body: Self.Body { get }

    @_spi(Render)
    static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    )
  }
#endif

extension HTML {
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    Body._render(html.body, into: &output)
  }
}

extension Never: HTML {
  public var body: Never { fatalError() }

  #if !hasFeature(Embedded)
    @_spi(Render) @inlinable @inline(__always)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
    }
  #endif

  @_spi(Render) @inlinable @inline(__always)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
  }
}
