#if !hasFeature(Embedded)
  public protocol HTMLDocument: AsyncHTML {
    associatedtype Head: AsyncHTML

    @HTMLBuilder var head: Head { get }
  }
#else
  public protocol HTMLDocument: HTML {
    associatedtype Head: HTML

    @HTMLBuilder var head: Head { get }
  }
#endif

#if !hasFeature(Embedded)
  extension HTMLDocument {
    @_spi(Render)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ document: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws {
      //
      //   let documentBody: _HTMLConditional<_HTMLBuffer, Body>
      //   let stylesheet: String
      //
      //   if let ssg = context.styles {
      //     var bodyBytes = _HTMLBuffer()
      //     try await Body._render(document.body, into: &bodyBytes, context: context)
      //     stylesheet = ssg.stylesheet()
      //     documentBody = .trueContent(bodyBytes)
      //   } else {
      //     stylesheet = ""
      //     documentBody = .falseContent(document.body)
      //   }
      //
      //   try await HTMLGroup._render(
      //     HTMLGroup {
      //       HTMLDoctype()
      //       tag("html") {
      //         tag("head") {
      //           document.head
      //
      //           if !stylesheet.isEmpty {
      //             style {
      //               HTMLRaw(stylesheet)
      //             }
      //           }
      //         }
      //         tag("body") {
      //           documentBody
      //         }
      //       }
      //     },
      //     into: &output
      //   )
    }
  }
#endif

extension HTMLDocument where Head: HTML, Body: HTML {
  @_spi(Render)
  public static func _render<Output: HTMLOutputStream>(
    _ document: consuming Self,
    into output: inout Output,
    context: HTMLContext

  ) {
    // @Dependency(\.htmlContext) var context
    //
    // let documentBody: _HTMLConditional<_HTMLBuffer, Body>
    // let stylesheet: String
    //
    // if let ssg = context.styles {
    //   var bodyBytes = _HTMLBuffer()
    //   Body._render(document.body, into: &bodyBytes, context: context)
    //   stylesheet = ssg.stylesheet()
    //   documentBody = .trueContent(bodyBytes)
    // } else {
    //   stylesheet = ""
    //   documentBody = .falseContent(document.body)
    // }
    //
    // HTMLGroup._render(
    //   HTMLGroup {
    //     HTMLDoctype()
    //     tag("html") {
    //       tag("head") {
    //         document.head
    //
    //         if !stylesheet.isEmpty {
    //           style {
    //             HTMLRaw(stylesheet)
    //           }
    //         }
    //       }
    //
    //       tag("body") {
    //         documentBody
    //       }
    //     }
    //   },
    //   into: &output
    // )
  }
}
