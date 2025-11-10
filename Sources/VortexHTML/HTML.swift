#if !hasFeature(Embedded)
  public protocol AsyncHTML {
    /// The type of the HTML content this body represents.
    associatedtype Body: AsyncHTML

    /// The HTML body of this component.
    @HTMLBuilder var body: Self.Body { get }

    @_spi(Internals)
    static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws
  }

  extension AsyncHTML {
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws {
      try await Body._render(html.body, into: &output, context: context)
    }
  }

  public protocol HTML: AsyncHTML where Self.Body: HTML {
    @_spi(Internals)
    static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    )
  }
#else
  public protocol HTML {
    associatedtype Body: HTML

    @HTMLBuilder var body: Self.Body { get }

    @_spi(Internals)
    static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    )

    #if canImport(JavaScriptKit)
    #endif
  }
#endif

extension HTML {
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output,
    context: HTMLContext

  ) {
    Body._render(html.body, into: &output, context: context)
  }
}

extension Never: HTML {
  public var body: Never { fatalError() }

  #if !hasFeature(Embedded)
    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws {
    }
  #endif

  @_spi(Internals)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output,
    context: HTMLContext
  ) {
  }
}
