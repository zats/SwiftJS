# Project Learnings

- When rebuilding a Swift sample app in SwiftJS/TSX, preserve the structure and intent of the original sample code. If Swift and TSX inputs are conceptually the same, fix missing behavior in the framework layer instead of changing the sample app just to make it work.
- Only framework-type code belongs in `SwiftJS`. Sample-app-specific code belongs in the sample app or an extension layer outside the core framework.
- Keep `SwiftJS` focused on reusable primitives. Custom TSX components, sample-specific layouts, and app-level composition should be defined outside the core framework and consume those primitives.
- When app-specific native behavior is needed, add it through a generic extension mechanism from the app target instead of putting that behavior directly into `SwiftJS`.
- Minimum supported iOS target is 26.1. Do not add `#available` / `@available` compatibility branches or fallbacks for older iOS versions in `SwiftJS`; call the 26.1+ APIs directly.
- `Sources/SwiftJS/Package` is the npm package root for the `swiftjs` JS dependency. Keep it self-contained and publishable: no `"private": true`, include `version`, `types`, `exports`, and `files`.
- Optional native modules such as `SwiftJSLocation` and `SwiftJSCalendar` may live in separate SwiftPM targets, but their public TS facades must live under `Sources/SwiftJS/Package` and be exported as `swiftjs/<module>`. Do not make app build scripts copy TS files from sibling SwiftPM targets into `swiftjs`.
- Keep app-side build integration small. Shared JS install/bundle behavior belongs in `Sources/SwiftJS/Package/build-swiftjs-app.mjs`; app Xcode build phases should invoke that package helper instead of carrying custom esbuild logic.
