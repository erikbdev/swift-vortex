@propertyWrapper
public struct Signal<Value> {
  fileprivate var initialValue: Value

  public var wrappedValue: Value {
    get { initialValue }
    nonmutating set {}
  }

  public init(wrappedValue: Value) {
    self.initialValue = wrappedValue
  }

  public init(_ value: Value) {
    self.initialValue = value
  }
}

extension Signal: Equatable where Value: Equatable {}
extension Signal: Hashable where Value: Hashable {}

// extension Signal: ExpressibleByIntegerLiteral where Value: ExpressibleByIntegerLiteral {
//   public init(integerLiteral value: Value.IntegerLiteralType) {
//     self.init(wrappedValue: Value(integerLiteral: value))
//   }
// }

extension Signal: ExpressibleByBooleanLiteral where Value: ExpressibleByBooleanLiteral {
  public init(booleanLiteral value: Value.BooleanLiteralType) {
    self.init(wrappedValue: Value(booleanLiteral: value))
  }
}

// extension Signal: ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {
//   public init(floatLiteral value: Value.FloatLiteralType) {
//     self.init(wrappedValue: Value(floatLiteral: value))
//   }
// }

extension Signal: ExpressibleByExtendedGraphemeClusterLiteral where Value: ExpressibleByExtendedGraphemeClusterLiteral {
  public init(extendedGraphemeClusterLiteral value: Value.ExtendedGraphemeClusterLiteralType) {
    self.init(wrappedValue: Value(extendedGraphemeClusterLiteral: value))
  }
}

extension Signal: ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: Value.UnicodeScalarLiteralType) {
    self.init(wrappedValue: Value(unicodeScalarLiteral: value))
  }
}

extension Signal: ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {
  public init(stringLiteral value: Value.StringLiteralType) {
    self.init(wrappedValue: Value(stringLiteral: value))
  }
}

extension Signal: AdditiveArithmetic where Value: AdditiveArithmetic {
  public static var zero: Self {
    Self(wrappedValue: .zero)
  }

  public static func + (lhs: Self, rhs: Self) -> Self {
    Self(wrappedValue: lhs.wrappedValue + rhs.wrappedValue)
  }

  public static func += (lhs: inout Self, rhs: Self) {
    lhs.wrappedValue += rhs.wrappedValue
  }

  public static func - (lhs: Self, rhs: Self) -> Self {
    Self(wrappedValue: lhs.wrappedValue - rhs.wrappedValue)
  }

  public static func -= (lhs: inout Self, rhs: Self) {
    lhs.wrappedValue -= rhs.wrappedValue
  }

  public static func + (lhs: Self, rhs: Value) -> Self {
    Self(wrappedValue: lhs.wrappedValue + rhs)
  }

  public static func += (lhs: Self, rhs: Value) {
    lhs.wrappedValue += rhs
  }

  public static func - (lhs: Self, rhs: Value) -> Self {
    Self(wrappedValue: lhs.wrappedValue - rhs)
  }

  public static func -= (lhs: Self, rhs: Value) {
    lhs.wrappedValue -= rhs
  }
}
