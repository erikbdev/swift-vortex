#if !hasFeature(Embedded)
  public protocol HTMLDocument: AsyncHTML {
    associatedtype Head: AsyncHTML

    @HTMLBuilder var head: Head { get }
  }

  extension HTMLDocument {
    @_spi(Internals)
    public static func _render<Output: AsyncHTMLOutputStream>(
      _ document: consuming Self,
      into output: inout Output,
      context: HTMLContext
    ) async throws {
      try await HTMLGroup._render(
        HTMLGroup {
          HTMLDoctype()
          tag("html") {
            tag("head") {
              // document.head
            }
            tag("body") {
              // document.body
            }
          }
        },
        into: &output,
        context: context
      )
    }
  }

#else
  public protocol HTMLDocument: HTML {
    associatedtype Head: HTML

    @HTMLBuilder var head: Head { get }
  }
#endif

extension HTMLDocument where Head: HTML, Body: HTML {
  @_spi(Internals)
  public static func _render<Output: HTMLOutputStream>(
    _ document: consuming Self,
    into output: inout Output,
    context: HTMLContext
  ) {
    HTMLGroup._render(
      HTMLGroup {
        HTMLDoctype()
        tag("html") {
          tag("head") {
            document.head
          }
          tag("body") {
            document.body
          }
        }
      },
      into: &output,
      context: context
    )
  }
}
