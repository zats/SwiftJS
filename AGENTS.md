# Project Learnings

- When rebuilding a Swift sample app in SwiftJS/TSX, preserve the structure and intent of the original sample code. If Swift and TSX inputs are conceptually the same, fix missing behavior in the framework layer instead of changing the sample app just to make it work.
- Only framework-type code belongs in `SwiftJS`. Sample-app-specific code belongs in the sample app or an extension layer outside the core framework.
- Keep `SwiftJS` focused on reusable primitives. Custom TSX components, sample-specific layouts, and app-level composition should be defined outside the core framework and consume those primitives.
