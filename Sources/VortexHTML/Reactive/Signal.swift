@propertyWrapper
public struct Signal<Value> {
  private var initialValue: Value
  public var wrappedValue: Value {
    get { initialValue }
    nonmutating set {}
  }

  public init(wrappedValue: Value) {
    self.initialValue = wrappedValue
  }
}
