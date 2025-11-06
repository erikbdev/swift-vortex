#if !hasFeature(Embedded)
  public struct HTMLGroup<Content: AsyncHTML>: AsyncHTML {
    let content: Content

    public var body: Content { content }

    public init(@HTMLBuilder content: () -> Content) {
      self.content = content()
    }

    public init<Awaitable: AsyncHTML>(@HTMLBuilder content: @escaping @Sendable () async throws -> Awaitable)
    where Content == AsyncHTMLContent<Awaitable> {
      self.content = AsyncHTMLContent(content: content)
    }
  }

  extension HTMLGroup: HTML where Content: HTML {}
#else
  public struct HTMLGroup<Content: HTML>: HTML {
    let content: Content
    public var body: Content { content }

    public init(@HTMLBuilder content: () -> Content) {
      self.content = content()
    }
  }
#endif

extension HTMLGroup: Sendable where Content: Sendable {}
