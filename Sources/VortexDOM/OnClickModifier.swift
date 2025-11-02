@_spi(Render) import VortexHTML

public struct Event: Sendable {
  public static let click = Event()
  public static let hover = Event()
}

extension HTML {
  public func on(_ event: Event, _ operation: @escaping () -> Void) -> some HTML {
    OnEventModifier(content: self, event: event, operation: operation)
  }
}

struct OnEventModifier<Content> {
  var content: Content
  var event: Event
  var operation: () -> Void

  var body: Never { fatalError() }
}

#if !hasFeature(Embedded)
  extension OnEventModifier: AsyncHTML where Content: AsyncHTML {
    static func _render<Output>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws where Output: AsyncHTMLOutputStream {
      try await Content._render(html.content, into: &output, context: context)
    }
  }
#endif

extension OnEventModifier: HTML where Content: HTML {
  static func _render<Output>(
    _ html: consuming Self,
    into output: inout Output,
    context: HTMLContext
  ) where Output: HTMLOutputStream {
    Content._render(html.content, into: &output, context: context)
  }
}
