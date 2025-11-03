public protocol HTMLEvent: Sendable, Hashable, RawRepresentable where RawValue == String {}

extension HTMLAttribute {
  public struct HTMLMouseEvent: HTMLEvent {
    public var rawValue: String

    public init(stringLiteral value: String) {
      self.rawValue = value
    }

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  public struct HTMLKeyboardEvent: HTMLEvent {
    public var rawValue: String

    public init(stringLiteral value: String) {
      self.rawValue = value
    }

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  public struct HTMLFormEvent: HTMLEvent {
    public var rawValue: String

    public init(stringLiteral value: String) {
      self.rawValue = value
    }

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  public static func on<Event: HTMLEvent>(_ event: Event, _ script: String) -> Self {
    Self(name: "on\(event.rawValue)", value: script)
  }
}

extension HTMLEvent where Self == HTMLAttribute.HTMLMouseEvent {
  public static var click: Self { Self(rawValue: "click") }
  public static var doubleClick: Self { Self(rawValue: "dblclick") }
  public static var mouseDown: Self { Self(rawValue: "mousedown") }
  public static var mouseMove: Self { Self(rawValue: "mousemove") }
  public static var mouseOut: Self { Self(rawValue: "mouseout") }
  public static var mouseOver: Self { Self(rawValue: "mouseover") }
  public static var mouseUp: Self { Self(rawValue: "mouseup") }
  public static var wheel: Self { Self(rawValue: "wheel") }
}

extension HTMLEvent where Self == HTMLAttribute.HTMLKeyboardEvent {
  public static var keyDown: Self { Self(rawValue: "keydown") }
  public static var keyPress: Self { Self(rawValue: "keypress") }
  public static var keyUp: Self { Self(rawValue: "keyup") }
}

extension HTMLEvent where Self == HTMLAttribute.HTMLFormEvent {
  public static var blur: Self { Self(rawValue: "blur") }
  public static var change: Self { Self(rawValue: "change") }
  public static var contextMenu: Self { Self(rawValue: "contextmenu") }
  public static var focus: Self { Self(rawValue: "focus") }
  public static var input: Self { Self(rawValue: "input") }
  public static var invalid: Self { Self(rawValue: "invalid") }
  public static var reset: Self { Self(rawValue: "reset") }
  public static var search: Self { Self(rawValue: "search") }
  public static var select: Self { Self(rawValue: "select") }
  public static var submit: Self { Self(rawValue: "submit") }
}
