#if !hasFeature(Embedded)
  extension Optional: AsyncHTML where Wrapped: AsyncHTML {
    public var body: Never { fatalError() }

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      if case .some(let html) = html {
        try await Wrapped._render(html, into: &output)
      }
    }
  }
#endif

extension Optional: HTML where Wrapped: HTML {
    public var body: Never { fatalError() }

  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    if case .some(let html) = html {
      Wrapped._render(html, into: &output)
    }
  }
}
