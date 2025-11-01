/// Renders HTML text without escaping characters.
/// This is a typealias of ``HTMLString(raw:)``
public let HTMLRaw = HTMLString.init(raw:)

/// Renders HTML text and escapes characters.
/// This is a typealias of ``HTMLString(_:)``
public let HTMLText = HTMLString.init(_:)

// @resultBuilder
public struct HTMLString: HTML, Sendable {
  private var _storage: [StorageValue]

  public var body: Never { fatalError() }

  @inlinable @inline(__always)
  public init(stringLiteral value: consuming String) {
    self.init(value)
  }

  @inlinable @inline(__always)
  public init(raw string: consuming String) {
    self.init(string.utf8, escape: false)
  }

  @inlinable @inline(__always)
  public init(_ string: consuming String) {
    self.init(string.utf8, escape: true)
  }

  @usableFromInline
  init(_ bytes: consuming some Sequence<UInt8>, escape: Bool) {
    self._storage = [StorageValue(bytes, escape: escape)]
  }

  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ html: consuming Self,
    into output: inout Output,
    context: HTMLContext

  ) {
    // var buffer = Data()
    // html.renderBytes(&buffer)
    // output.write(buffer)
  }

  #if !hasFeature(Embedded)
    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ html: consuming Self,
      into output: inout Output,
      context: HTMLContext

    ) async throws {
      // var buffer = Data()
      // html.renderBytes(&buffer)
      // try await output.write(buffer)
    }
  #endif

  private func renderBytes(_ buffer: inout [UInt8]) {
    for value in self._storage {
      switch value.element {
      case .bytes(let bytes):
        for byte in bytes {
          switch byte {
          case 0x26 where value.escape:  // &
            buffer.append(contentsOf: "&amp;".utf8)
          case 0x3C where value.escape:  // <
            buffer.append(contentsOf: "&lt;".utf8)
          default:
            buffer.append(byte)
          }
        }
      // case .html(let html):
      //   withUnsafeMutablePointer(to: &output) { output in
      //     var proxy = _HTMLByteStreamProxy { bytes in
      //       for byte in bytes {
      //         switch byte {
      //         case 0x26 where value.escape:  // &
      //           output.pointee.write("&amp;".utf8)
      //         case 0x3C where value.escape:  // <
      //           output.pointee.write("&lt;".utf8)
      //         default:
      //           output.pointee.write(byte)
      //         }
      //       }
      //     }
      //     AnySendableHTML._render(html, into: &proxy, context: context)
      //   }
      }
    }
  }
}

extension HTMLString {
  fileprivate struct StorageValue: Sendable {
    let element: Element
    let escape: Bool

    init<S: Sequence<UInt8>>(_ bytes: S, escape: Bool) {
      self.element = .bytes(ContiguousArray(bytes))
      self.escape = escape
    }

    enum Element: Sendable {
      case bytes(ContiguousArray<UInt8>)
    }
  }
}

#if !hasFeature(Embedded)
  extension HTMLString: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public struct StringInterpolation: StringInterpolationProtocol {
      fileprivate var _storage: [StorageValue]

      public init(literalCapacity: Int, interpolationCount: Int) {
        self._storage = []
      }

      public mutating func appendLiteral(_ value: consuming String) {
        _storage.append(.init(value.utf8, escape: true))
      }

      public mutating func appendInterpolation(_ value: consuming String) {
        _storage.append(.init(value.utf8, escape: true))
      }

      public mutating func appendInterpolation(raw value: consuming String) {
        _storage.append(.init(value.utf8, escape: false))
      }
    }

    public init(stringInterpolation: consuming StringInterpolation) {
      self._storage = stringInterpolation._storage
    }
  }

// private struct _HTMLByteStreamProxy: HTMLByteStream {
//   let callback: (ContiguousArray<UInt8>) -> Void

//   mutating func write(_ byte: consuming UInt8) {
//     callback(ContiguousArray(arrayLiteral: byte))
//   }

//   mutating func write(_ bytes: consuming some Sequence<UInt8>) {
//     callback(ContiguousArray(bytes))
//   }
// }

// Result builder
// extension HTMLString {
//   @inlinable @inline(__always)
//   public static func buildPartialBlock(first: String) -> String {
//     first
//   }

//   @inlinable @inline(__always)
//   public static func buildPartialBlock(accumulated: String, next: String) -> String {
//     accumulated + "\n" + next
//   }

//   @inlinable @inline(__always)
//   public static func buildEither(first component: String) -> String {
//     component
//   }

//   @inlinable @inline(__always)
//   public static func buildEither(second component: String) -> String {
//     component
//   }

//   @inlinable @inline(__always)
//   public static func buildOptional(_ component: String?) -> String {
//     component ?? ""
//   }

//   @inlinable @inline(__always)
//   public static func buildArray(_ components: [String]) -> String {
//     components.joined(separator: "\n")
//   }
// }
#endif
