#if !hasFeature(Embedded)
  public struct AnyAsyncHTML: AsyncHTML {
    @usableFromInline
    let base: any AsyncHTML

    public var body: Never { fatalError() }

    @inlinable @inline(__always)
    public init(_ base: some AsyncHTML) {
      if let base = base as? Self {
        self = base
      } else {
        self.base = base
      }
    }

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      func _render<T: AsyncHTML>(_ html: T) async throws {
        try await T._render(html, into: &output)
      }
      try await _render(html.base)
    }
  }

  public struct AnyHTML: HTML {
    @usableFromInline
    let base: any HTML

    public var body: Never { fatalError() }

    @inlinable @inline(__always)
    public init(_ base: some HTML) {
      if let base = base as? Self {
        self = base
      } else {
        self.base = base
      }
    }

    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) {
      func _render<T: HTML>(_ html: T) {
        T._render(html, into: &output)
      }
      _render(html.base)
    }

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      try await AnyAsyncHTML._render(html.eraseToAnyAsyncHTML(), into: &output)
    }

    public consuming func eraseToAnyAsyncHTML() -> AnyAsyncHTML {
      AnyAsyncHTML(self.base)
    }
  }

  public struct AnySendableAsyncHTML: AsyncHTML, Sendable {
    @usableFromInline
    var base: any AsyncHTML & Sendable

    public var body: Never { fatalError() }

    @inlinable @inline(__always)
    public init(_ base: some AsyncHTML & Sendable) {
      if let base = base as? Self {
        self = base
      } else {
        self.base = base
      }
    }

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      func _render<T: AsyncHTML>(_ html: T) async throws {
        try await T._render(html, into: &output)
      }
      try await _render(html.base)
    }
  }

  public struct AnySendableHTML: HTML, Sendable {
    @usableFromInline
    var base: any HTML & Sendable

    public var body: Never { fatalError() }

    @inlinable @inline(__always)
    public init(_ base: some HTML & Sendable) {
      if let base = base as? Self {
        self = base
      } else {
        self.base = base
      }
    }

    @_spi(Render)
    public static func _render<Output: HTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) {
      func _render<T: HTML>(_ html: T) {
        T._render(html, into: &output)
      }
      _render(html.base)
    }

    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      func _render<T: HTML>(_ html: T) async throws {
        try await T._render(html, into: &output)
      }
      try await _render(html.base)
    }
  }
#endif
