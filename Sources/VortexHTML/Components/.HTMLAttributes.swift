// import OrderedCollections

#if !hasFeature(Embedded)
  public struct HTMLAttributes<Content: AsyncHTML>: AsyncHTML {
    // @usableFromInline
    var attributes: Set<HTMLAttribute>

    // @usableFromInline
    let content: Content

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      // try await withDependencies {
      // html.resolveAttributes(&$0.htmlContext.attributes)
      // } operation: {
      // try await Content._render(html.content, into: &output)
      // }
    }
  }

extension HTMLAttributes: HTML where Content: HTML {
  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    // withDependencies {
    //   html.resolveAttributes(&$0.htmlContext.attributes)
    // } operation: {
    //   Content._render(html.content, into: &output)
    // }
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
    // @usableFromInline
    var attributes: Set<HTMLAttribute>

    // @usableFromInline
    let content: Content

  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    // withDependencies {
    //   html.resolveAttributes(&$0.htmlContext.attributes)
    // } operation: {
    //   Content._render(html.content, into: &output)
    // }
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

  // @inlinable @inline(__always)
  // // public init(attributes: OrderedSet<HTMLAttribute>, content: Content) {
  // //   self.content = content
  // //   self.attributes = attributes
  // }

  // @inlinable @inline(__always)
  public func attribute(
    _ name: String,
    value: String? = "",
    mergeMode: HTMLAttribute.MergeMode = .replaceValue
  ) -> Self {
    var copy = self
    copy.attributes.insert(HTMLAttribute(name: name, value: value, mergeMode: mergeMode))
    return copy
  }

  // @inlinable @inline(__always)
  public func attribute(_ attribute: HTMLAttribute) -> Self {
    var copy = self
    copy.attributes.insert(attribute)
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
