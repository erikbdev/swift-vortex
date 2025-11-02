import VortexDOM

struct DemoOne: HTML {
  @State var count = 0
  @State var text: String?

  var body: some HTML {
    if count < 5 {
      p {
        "Value: " 
        count.description 
      }
      button {
        "Increment"
      }
      .on(.click) { count += 1 }
      button {
        "Decrement"
      }
      .on(.click) { count -= 1 }
    } else {
      p { "Finished counter: \(count)" }
    }

    if let text {
      p { "Hello, \(text)" }
    }
  }

  mutating func _$reactiveBody() {
  }
}
