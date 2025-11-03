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

  func _$reactive() {
    var count = Signal(wrappedValue: self.count)

    div { 
      button { "+" }
      .on(.click) {
        count += 1
      }
      p { count.description }
    }
  }
}
