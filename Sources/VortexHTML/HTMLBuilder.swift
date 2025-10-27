@resultBuilder
public struct HTMLBuilder {
  @inlinable @inline(__always)
  public static func buildBlock() -> EmptyHTML {
    EmptyHTML()
  }
}

#if !hasFeature(Embedded)
  extension HTMLBuilder {
    // @inlinable @inline(__always)
    public static func buildBlock<Content: AsyncHTML>(_ component: Content) -> Content {
      component
    }

    // @inlinable @inline(__always)
    public static func buildOptional<Content: AsyncHTML>(_ component: Content?) -> Content? {
      component
    }

    // @inlinable @inline(__always)
    public static func buildBlock<each Content: AsyncHTML>(_ components: repeat each Content) -> HTMLTuple<repeat each Content> {
      HTMLTuple(repeat each components)
    }

    // @inlinable @inline(__always)
    public static func buildEither<TrueContent: AsyncHTML, FalseContent: AsyncHTML>(first component: TrueContent) -> _HTMLConditional<
      TrueContent, FalseContent
    > {
      _HTMLConditional.trueContent(component)
    }

    // @inlinable @inline(__always)
    public static func buildEither<TrueContent: AsyncHTML, FalseContent: AsyncHTML>(second component: FalseContent) -> _HTMLConditional<
      TrueContent, FalseContent
    > {
      _HTMLConditional.falseContent(component)
    }

    // @inlinable @inline(__always)
    public static func buildArray<Element: AsyncHTML>(_ components: [Element]) -> _HTMLArray<Element> {
      _HTMLArray(elements: components)
    }
  }

  extension HTMLBuilder {
    // @inlinable @inline(__always) 
    public static func buildExpression<Content: AsyncHTML>(_ component: Content) -> Content {
      component
    }

    // @inlinable @inline(__always)
    // public static func buildExpression(_ component: HTMLString) -> HTMLString {
    //   component
    // }

    // @_disfavoredOverload
    // // @inlinable @inline(__always)
    // public static func buildExpression(_ component: String) -> HTMLString {
    //   HTMLString(component)
    // }

    // @inlinable @inline(__always)
    public static func buildFinalResult<Content: AsyncHTML>(_ component: Content) -> Content {
      component
    }
  }
#else
  extension HTMLBuilder {
    // @inlinable @inline(__always)
    public static func buildBlock<Content: HTML>(_ component: Content) -> Content {
      component
    }

    // @inlinable @inline(__always)
    public static func buildOptional<Content: HTML>(_ component: Content?) -> Content? {
      component
    }

    public static func buildBlock<H0: HTML, H1: HTML>(_ h0: H0, _ h1: H1) -> HTMLTuple<(H0, H1)> {
      HTMLTuple((h0, h1))
    }

    // @inlinable @inline(__always)
    public static func buildEither<TrueContent: HTML, FalseContent: HTML>(first component: TrueContent) -> _HTMLConditional<
      TrueContent, FalseContent
    > {
      _HTMLConditional.trueContent(component)
    }

    // @inlinable @inline(__always)
    public static func buildEither<TrueContent: HTML, FalseContent: HTML>(second component: FalseContent) -> _HTMLConditional<
      TrueContent, FalseContent
    > {
      _HTMLConditional.falseContent(component)
    }

    // @inlinable @inline(__always)
    public static func buildArray<Element: HTML>(_ components: [Element]) -> _HTMLArray<Element> {
      _HTMLArray(elements: components)
    }
  }

  extension HTMLBuilder {
    // @inlinable @inline(__always)
    public static func buildExpression<Content: HTML>(_ component: Content) -> Content {
      component
    }

    // @inlinable @inline(__always)
    // public static func buildExpression(_ component: HTMLString) -> HTMLString {
    //   component
    // }

    // @_disfavoredOverload
    // // @inlinable @inline(__always)
    // public static func buildExpression(_ component: String) -> HTMLString {
    //   HTMLString(component)
    // }

    // @inlinable @inline(__always)
    public static func buildFinalResult<Content: HTML>(_ component: Content) -> Content {
      component
    }
  }
#endif
