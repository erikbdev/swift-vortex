public struct EmptyHTML: HTML, Sendable {
  public var body: Never { fatalError() }

  @inlinable @inline(__always)
  public init() {}

  @_spi(Internals)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output,
    context: HTMLContext

  ) {}

  #if !hasFeature(Embedded)
    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {}
  #endif
}
