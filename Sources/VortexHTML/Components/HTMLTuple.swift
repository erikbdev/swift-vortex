#if !hasFeature(Embedded)
  public struct HTMLTuple<each Content: AsyncHTML>: AsyncHTML {
    @usableFromInline
    let content: (repeat each Content)

    @inlinable @inline(__always)
    public var body: Never { fatalError() }

    @inlinable @inline(__always)
    public init(_ content: repeat each Content) {
      self.content = (repeat each content)
    }

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {
      func render<T: AsyncHTML>(_ html: T) async throws {
        try await T._render(html, into: &output, context: context)
      }

      repeat try await render(each html.content)
    }
  }

  extension HTMLTuple: HTML where repeat each Content: HTML {
    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) {
      func render<T: HTML>(_ html: T) {
        T._render(html, into: &output, context: context)
      }

      repeat render(each html.content)
    }
  }

  extension HTMLTuple: Sendable where repeat each Content: Sendable {}
#else
  public struct HTMLTuple2<H0: HTML, H1: HTML>: HTML {
    let content: (H0, H1)

    public var body: Never { fatalError() }

    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) {
      H0._render(html.content.0, into: &output, context: context)
      H1._render(html.content.1, into: &output, context: context)
    }
  }

  public struct HTMLTuple3<H0: HTML, H1: HTML, H2: HTML>: HTML {
    let content: (H0, H1, H2)

    public var body: Never { fatalError() }

    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) {
      H0._render(html.content.0, into: &output, context: context)
      H1._render(html.content.1, into: &output, context: context)
      H2._render(html.content.2, into: &output, context: context)
    }
  }
#endif
