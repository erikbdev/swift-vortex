#if !hasFeature(Embedded)
  public struct HTMLGroup<Content: AsyncHTML>: AsyncHTML {
    @usableFromInline
    let content: Content

    @inlinable @inline(__always)
    public var body: Content { content }

    @inlinable @inline(__always)
    public init(@HTMLBuilder content: () -> Content) {
      self.content = content()
    }

    @inlinable @inline(__always)
    public init<Awaitable: AsyncHTML>(@HTMLBuilder content: @escaping @Sendable () async throws -> Awaitable)
    where Content == AsyncHTMLContent<Awaitable> {
      self.content = AsyncHTMLContent(content: content)
    }

  }

  extension HTMLGroup: HTML where Content: HTML {}
  extension HTMLGroup: Sendable where Content: Sendable {}
#else
  public struct HTMLGroup<Content: HTML>: HTML {
    @usableFromInline
    let content: Content

    @inlinable @inline(__always)
    public var body: Content { content }

    @inlinable @inline(__always)
    public init(@HTMLBuilder content: () -> Content) {
      self.content = content()
    }
  }
#endif

extension HTMLGroup: Sendable where Content: Sendable {}
