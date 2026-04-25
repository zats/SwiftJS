# Project Learnings

- When rebuilding a Swift sample app in SwiftJS/TSX, preserve the structure and intent of the original sample code. If Swift and TSX inputs are conceptually the same, fix missing behavior in the framework layer instead of changing the sample app just to make it work.
- Only framework-type code belongs in `SwiftJS`. Sample-app-specific code belongs in the sample app or an extension layer outside the core framework.
- Keep `SwiftJS` focused on reusable primitives. Custom TSX components, sample-specific layouts, and app-level composition should be defined outside the core framework and consume those primitives.
- When app-specific native behavior is needed, add it through a generic extension mechanism from the app target instead of putting that behavior directly into `SwiftJS`.
- Minimum supported iOS target is 26.1. Do not add `#available` / `@available` compatibility branches or fallbacks for older iOS versions in `SwiftJS`; call the 26.1+ APIs directly.
