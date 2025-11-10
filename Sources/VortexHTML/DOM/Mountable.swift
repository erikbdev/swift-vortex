#if canImport(JavaScriptKit) && os(WASI)
extension HTML {
  func mount() { }

  func onMounted(_ operation: @escaping () -> Void) -> some HTML {
    self
  }

  func onUnmounted(_ operation: @escaping () -> Void) -> some HTML {
    self
  }

  func effect(_ operation: @escaping () -> Void) -> some HTML {
    self
  }
}
#endif