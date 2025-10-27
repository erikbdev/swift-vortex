struct _HTMLBuffer: HTML, Sendable {
  var bytes: [UInt8] = []

  var body: Never { fatalError() }

  mutating func write(_ bytes: consuming some Sequence<UInt8>) {
    self.bytes.append(contentsOf: bytes)
  }
}

#if !hasFeature(Embedded)
  extension _HTMLBuffer: AsyncHTMLOutputStream {
  mutating func write(_ bytes: consuming some Sequence<UInt8>) async throws {
    self.bytes.append(contentsOf: bytes)
  }

    static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output
    ) async throws {
      try await output.write(html.bytes)
    }
  }
#endif

extension _HTMLBuffer: HTMLOutputStream {
  static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output
  ) {
    output.write(html.bytes)
  }
}
