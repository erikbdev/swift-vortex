#if !hasFeature(Embedded)
  public enum _HTMLConditional<TrueContent: AsyncHTML, FalseContent: AsyncHTML>: AsyncHTML {
    case trueContent(TrueContent)
    case falseContent(FalseContent)

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {
      switch html {
      case .trueContent(let html): try await TrueContent._render(html, into: &output, context: context)
      case .falseContent(let html): try await FalseContent._render(html, into: &output, context: context)
      }
    }
  }

  extension _HTMLConditional: HTML where TrueContent: HTML, FalseContent: HTML {
    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) {
      switch html {
      case .trueContent(let html): TrueContent._render(html, into: &output, context: context)
      case .falseContent(let html): FalseContent._render(html, into: &output, context: context)
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
      into output: inout Output,
      context: HTMLContext

    ) {
      switch html {
      case .trueContent(let html): TrueContent._render(html, into: &output, context: context)
      case .falseContent(let html): FalseContent._render(html, into: &output, context: context)
      }
    }
  }
#endif

extension _HTMLConditional {
  @inlinable @inline(__always)
  public var body: Never { fatalError() }
}

// extension _HTMLConditional: Sendable where TrueContent: Sendable, FalseContent: Sendable {}
