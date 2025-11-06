import VortexHTML

struct CounterDemo: HTML {
  @Signal var count = 0

  var body: some HTML {
    div {
      button { "+" }
        .on(.click) {
          count += 1
        } 
      p { count.description }
    }
  }
}

struct FactDemo: AsyncHTML {
  var body: some AsyncHTML {
    AsyncHTMLContent {
      let data = try await fetch()
      p { data.description }
    }
  }

  func fetch() async throws -> Int {
    try await Task.sleep(for: .seconds(3))
    return Int.random(in: 0..<10_000)
  }
}

private func test3() {
  let count = Signal(0)
  let app = div {
    button { "+" }
      .on(.click, count += 1) 
  }

  // app.mount()
}