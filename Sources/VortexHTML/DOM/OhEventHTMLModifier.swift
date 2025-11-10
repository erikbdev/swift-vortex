extension HTML {
  public func on<Event: HTMLEvent>(_ event: Event, _ operation: @autoclosure @escaping () -> Void) -> some HTML {
    _OnEventHTMLModifier(content: self, event: event, operation: operation)
  }
 
  public func on<Event: HTMLEvent>(_ event: Event, _ operation: @escaping () -> Void) -> some HTML {
    _OnEventHTMLModifier(content: self, event: event, operation: operation)
  }
}

struct _OnEventHTMLModifier<Event: HTMLEvent, Content> {
  var content: Content
  var event: Event
  var operation: () -> Void

  var body: Never { fatalError() }
}

#if !hasFeature(Embedded)
  extension _OnEventHTMLModifier: AsyncHTML where Content: AsyncHTML {
    static func _render<Output>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws where Output: AsyncHTMLOutputStream {
      try await Content._render(html.content, into: &output, context: context)
    }
  }
#endif

extension _OnEventHTMLModifier: HTML where Content: HTML {
  static func _render<Output>(
    _ html: consuming Self,
    into output: inout Output,
    context: HTMLContext
  ) where Output: HTMLOutputStream {
    Content._render(html.content, into: &output, context: context)
  }
}

#if canImport(JavaScriptKit) && os(WASI)
extension _OnEventHTMLModifier {}
#endif