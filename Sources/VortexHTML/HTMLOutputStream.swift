#if !hasFeature(Embedded)
  public protocol AsyncHTMLOutputStream {
    mutating func write<S: Sequence<UInt8>>(_ bytes: consuming S) async throws
  }

  extension AsyncHTMLOutputStream {
    mutating func write(_ byte: consuming UInt8) async throws {
      try await self.write([byte])
    }
  }

  extension AsyncHTML {
    @inline(__always)
    public consuming func render(_ config: HTMLContext.Configuration = .minified) async throws -> String {
      let context = HTMLContext(config)
      var bytes = _HTMLBuffer()
      try await Self._render(self, into: &bytes, context: context)
      return String(decoding: bytes.bytes, as: UTF8.self)
    }

    @inline(__always)
    public consuming func render<Output: AsyncHTMLOutputStream>(_ config: HTMLContext.Configuration = .minified, into output: inout Output)
      async throws
    {
      let context = HTMLContext(config)
      try await Self._render(self, into: &output, context: context)
    }
  }
#endif

public protocol HTMLOutputStream {
  mutating func write<S: Sequence<UInt8>>(_ bytes: consuming S)
}

extension HTMLOutputStream {
  mutating func write(_ byte: consuming UInt8) {
    self.write([byte])
  }
}

extension HTML {
  @inline(__always)
  public consuming func render(_ config: HTMLContext.Configuration = .minified) -> String {
    let context = HTMLContext(config)
    var bytes = _HTMLBuffer()
    Self._render(self, into: &bytes, context: context)
    return String(decoding: bytes.bytes, as: UTF8.self)
  }

  @inline(__always)
  public consuming func render<Output: HTMLOutputStream>(_ config: HTMLContext.Configuration = .minified, into output: inout Output) {
    let context = HTMLContext(config)
    Self._render(self, into: &output, context: context)
  }
}
