#if !hasFeature(Embedded)
  public struct HTMLAttributes<Content: AsyncHTML>: AsyncHTML {
    var attributes: OrderedSet<HTMLAttribute>
    let content: Content

    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws {
      var context = context
      html.resolveAttributes(&context.attributes)
      try await Content._render(html.content, into: &output, context: context)
    }
  }

  extension HTMLAttributes: HTML where Content: HTML {
    @_spi(Internals)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) {
      var context = context
      html.resolveAttributes(&context.attributes)
      Content._render(html.content, into: &output, context: context)
    }
  }

  extension AsyncHTML {
    public func attribute(
      _ name: String,
      value: String? = "",
      mergeMode: HTMLAttribute.MergeMode = .replaceValue
    ) -> HTMLAttributes<Self> {
      HTMLAttributes(
        attributes: [HTMLAttribute(name: name, value: value, mergeMode: mergeMode)],
        content: self
      )
    }

    public func attribute(_ attribute: HTMLAttribute) -> HTMLAttributes<Self> {
      HTMLAttributes(
        attributes: [attribute],
        content: self
      )
    }
  }
#else
  public struct HTMLAttributes<Content: HTML>: HTML {
    var attributes: OrderedSet<HTMLAttribute>
    let content: Content

    @_spi(Internals)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) {
      var context = context
      html.resolveAttributes(&context.attributes)
      Content._render(html.content, into: &output, context: context)
    }
  }

  extension HTML {
    public func attribute(
      _ name: String,
      value: String? = "",
      mergeMode: HTMLAttribute.MergeMode = .replaceValue
    ) -> HTMLAttributes<Self> {
      HTMLAttributes(
        attributes: [HTMLAttribute(name: name, value: value, mergeMode: mergeMode)],
        content: self
      )
    }

    public func attribute(_ attribute: HTMLAttribute) -> HTMLAttributes<Self> {
      HTMLAttributes(
        attributes: [attribute],
        content: self
      )
    }
  }
#endif

extension HTMLAttributes {
  public var body: Never { fatalError() }

  public func attribute(
    _ name: String,
    value: String? = "",
    mergeMode: HTMLAttribute.MergeMode = .replaceValue
  ) -> Self {
    var copy = self
    copy.attributes.append(HTMLAttribute(name: name, value: value, mergeMode: mergeMode))
    return copy
  }

  public func attribute(_ attribute: HTMLAttribute) -> Self {
    var copy = self
    copy.attributes.append(attribute)
    return copy
  }

  private func resolveAttributes(_ storedAttributes: inout [String: String]) {
    for attr in self.attributes {
      storedAttributes[attr.name] =
        switch (storedAttributes[attr.name], attr.value, attr.mergeMode) {
        case (.none, let newValue, .ignoreIfSet):
          newValue
        case (_, let newValue, .replaceValue):
          newValue
        case (.none, .some(let newValue), .mergeValue):
          newValue
        case (.some(let oldValue), .some(let newValue), .mergeValue):
          oldValue.isEmpty ? newValue : "\(oldValue) \(newValue)"
        case (let oldValue, _, _): oldValue
        }
    }
  }
}

extension HTMLAttributes: Sendable where Content: Sendable {}
