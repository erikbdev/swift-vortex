#if !hasFeature(Embedded)
  public enum _HTMLConditional<TrueContent: AsyncHTML, FalseContent: AsyncHTML>: AsyncHTML {
    case trueContent(TrueContent)
    case falseContent(FalseContent)

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      switch html {
      case .trueContent(let html): try await TrueContent._render(html, into: &output)
      case .falseContent(let html): try await FalseContent._render(html, into: &output)
      }
    }
  }

extension _HTMLConditional: HTML where TrueContent: HTML, FalseContent: HTML {
  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    switch html {
    case .trueContent(let html): TrueContent._render(html, into: &output)
    case .falseContent(let html): FalseContent._render(html, into: &output)
    }
  }
}

#else
  public enum _HTMLConditional<TrueContent: HTML, FalseContent: HTML>: HTML {
    case trueContent(TrueContent)
    case falseContent(FalseContent)

  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    switch html {
    case .trueContent(let html): TrueContent._render(html, into: &output)
    case .falseContent(let html): FalseContent._render(html, into: &output)
    }
  }
  }
#endif

extension _HTMLConditional {
  @inlinable @inline(__always)
  public var body: Never { fatalError() }
}

// extension _HTMLConditional: Sendable where TrueContent: Sendable, FalseContent: Sendable {}
