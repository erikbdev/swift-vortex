struct OrderedDictionary<Key: Hashable, Value> {
  private var _dictionary: [Key: Value] = [:]
  private var _indices: [Key: Int] = [:]
}