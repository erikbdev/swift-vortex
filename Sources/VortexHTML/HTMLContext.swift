public struct HTMLContext: Sendable {
  public let configuration: Configuration
  public var attributes: [String: String] = [:]

  var depth = 0
  var currentIndentation: String { String(repeating: configuration.indentation, count: depth) }

  public init(_ configuration: Configuration) {
    self.configuration = configuration
  }

  public struct Configuration: Sendable {
    let indentation: String
    let newLine: String

    public init(indentation: String, newLine: String) {
      self.indentation = indentation
      self.newLine = newLine
    }

    public static let minified = Self(indentation: "", newLine: "")
    public static let pretty = Self(indentation: "  ", newLine: "\n")
  }
}
