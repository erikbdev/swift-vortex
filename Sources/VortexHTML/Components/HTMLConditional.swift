public struct ConditionalHTML<Value, IfContent: HTML, ElseContent: HTML>: HTML {
  public var body: Never { fatalError() }
  let condition: () -> Value
  let ifContent: (Value) -> IfContent
  let elseContent: () -> ElseContent

  public init(
    _ condition: @escaping @autoclosure () -> Value,
    @HTMLBuilder if ifContent: @escaping () -> IfContent,
    @HTMLBuilder else elseContent: @escaping () -> ElseContent = EmptyHTML.init
  ) where Value == Bool {
    self.condition = condition
    self.ifContent = { _ in ifContent() }
    self.elseContent = elseContent
  }

  public init<Wrapped>(
    _ condition: @escaping @autoclosure () -> Value,
    @HTMLBuilder if ifContent: @escaping (Wrapped) -> IfContent,
    @HTMLBuilder else elseContent: @escaping () -> ElseContent = EmptyHTML.init
  ) where Value == Wrapped? {
    self.condition = condition
    self.ifContent = { ifContent(unsafeBitCast($0, to: Wrapped.self)) }
    self.elseContent = elseContent
  }
}
