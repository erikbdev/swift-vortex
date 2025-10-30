import VortexHTML

struct DemoOne: HTML {
  var count = 0
  var text: String?

  var body: some HTML {
    if count < 5 {
      button {
        "Increment"
      }
      // .on(.click) {
      //   count += 1
      // }
      button {
        "Decrement"
      }
      // .on(.click) {
      //   count += 1
      // }
    } else {
      p { "Finished counter: \(count)" }
    }

    if let text {
      p { "Hello, \(text)" }
    }
  }

  mutating func _$reactiveBody() {
    var count = self.count
    var text = self.text

    var root_0 = p {
      var root_0_1 = "Finished counter: \(count)"
      root_0_1
    }

    var root_1 = {
      var root_1_0 = button {
        var root_1_0_0 = "Increment"
      }
      root_1_0
      var root_1_1 = button {
        var root_1_1_0 = "Decrement"
        root_1_1_0
      }
      root_1_1
    }()
  }
}
