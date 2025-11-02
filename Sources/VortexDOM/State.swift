@propertyWrapper
public struct State<Value> {
  private var initialValue: Value
  public var wrappedValue: Value {
    get { fatalError() }
    nonmutating set {}
  }

  public init(wrappedValue: Value) {
    self.initialValue = wrappedValue
  }
}
