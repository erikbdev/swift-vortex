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
#else
  public struct HTMLTuple<T>: HTML {
    let content: T

    public var body: Never { fatalError() }

    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) {
      // func render<T: HTML>(_ html: T) {
      // T._render(html, into: &output, context: context)
      // }

      // repeat render(each html.content)
    }

    public init(_ content: T) {
      self.content = content
    }
  }
#endif

// extension HTMLTuple: Sendable where repeat each Content: Sendable {}
