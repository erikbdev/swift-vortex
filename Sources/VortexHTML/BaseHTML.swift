#if !hasFeature(Embedded)
  typealias BaseHTML = AsyncHTML
#else
  typealias BaseHTML = HTML
#endif
