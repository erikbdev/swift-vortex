import VortexHTML

struct DemoOne: HTML {
  var count = 0
  var text: String?

  var body: some HTML {
    ConditionalHTML(count < 5) {
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
    } else: {
      p { "Finished counter: \(count)" }
    }

    ConditionalHTML(text) { text in
      p { "Hello, \(text)" } 
    }
  }
}
