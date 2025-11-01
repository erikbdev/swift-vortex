struct OrderedSet<Element: Hashable>: Equatable, Collection {
  typealias Index = Int
  typealias Indices = Range<Int>

  private var array: [Element]
  private var set: Set<Element>

  var count: Int { array.count }
  var isEmpty: Bool { array.isEmpty }
  var contents: [Element] { array }

  init() {
    self.array = []
    self.set = []
  }

  init<S: Sequence>(_ sequence: S) where S.Element == Element {
    self.init()
    for element in sequence {
      append(element)
    }
  }

  func contains(_ member: Element) -> Bool { set.contains(member) }

  @discardableResult
  mutating func append(_ element: Element) -> Bool {
    let inserted = set.insert(element)
    if inserted.inserted {
      array.append(element)
    }
    return inserted.inserted
  }
}

extension OrderedSet: Sendable where Element: Sendable {}

extension OrderedSet: ExpressibleByArrayLiteral {
  init(arrayLiteral elements: Element...) {
    self.init(elements)
  }

  typealias ArrayLiteralElement = Element
}

extension OrderedSet: RandomAccessCollection {
  var startIndex: Int { contents.startIndex }
  var endIndex: Int { contents.endIndex }

  subscript(index: Int) -> Element {
    contents[index]
  }
}
