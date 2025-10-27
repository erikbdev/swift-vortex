#if !hasFeature(Embedded)
  public struct _HTMLArray<Element: AsyncHTML>: AsyncHTML {
    // @usableFromInline
    let elements: [Element]
  }

  extension _HTMLArray {
    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      for element in html.elements {
        try await Element._render(element, into: &output)
      }
    }
  }

extension _HTMLArray: HTML where Element: HTML {
  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    for element in html.elements {
      Element._render(element, into: &output)
    }
  }
}
#else
  public struct _HTMLArray<Element: HTML>: HTML {
    // @usableFromInline
    let elements: [Element]

  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    for element in html.elements {
      Element._render(element, into: &output)
    }
  }
  }
#endif

extension _HTMLArray {
  public var body: Never { fatalError() }

  // @inlinable @inline(__always)
  // public init(elements: [Element]) {
  //   self.elements = elements
  // }

}

// extension _HTMLArray: Sendable where Element: Sendable {}
