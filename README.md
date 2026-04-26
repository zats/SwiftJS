# SwiftJS

SwiftJS is an experimental SwiftUI host runtime for building native iOS interfaces from TypeScript/TSX.

The JavaScript layer owns application state and business logic. Swift receives a serialized view tree, maps it to SwiftUI, and lets SwiftUI handle native layout, rendering, and diffing.

## Status

This package targets iOS 26.1 and Swift 6.3. The API surface is still moving.

## Packages

SwiftPM products:

- `SwiftJSCore`
- `SwiftJS`
- `SwiftJSLocation`
- `SwiftJSCalendar`

The TypeScript package lives in `Sources/SwiftJS/Package` and is exported as `swiftjs`.

## Integrating Into An App

1. Add the Swift package:

```text
https://github.com/zats/SwiftJS
```

Link the `SwiftJS` product to the app target. Also link `SwiftJSLocation` and `SwiftJSCalendar` if the JS app imports `swiftjs/location` or `swiftjs/calendar`.

2. Add a JS workspace:

```text
WebApp/
  JS/package.json
  Project/main.tsx
  Bundle/
```

`WebApp/JS/package.json`:

```json
{
  "private": true,
  "scripts": {
    "build": "swiftjs-build-app . ../Project ../Bundle"
  },
  "dependencies": {
    "swiftjs": "github:zats/SwiftJS#path:Sources/SwiftJS/Package"
  },
  "devDependencies": {
    "esbuild": "^0.25.12",
    "typescript": "^5.9.3"
  }
}
```

3. Add an Xcode Run Script phase before resources are copied. Set the phase shell to `/bin/bash`:

```bash
set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
node "$BUILT_PRODUCTS_DIR/SwiftJS_SwiftJS.bundle/Package/build-swiftjs-app.mjs" "$SRCROOT/WebApp/JS" ../Project ../Bundle
```

Add these output paths to the phase:

```text
$(SRCROOT)/WebApp/Bundle/app.bundle.js
$(SRCROOT)/WebApp/Bundle/manifest.json
```

Add `WebApp/Bundle` to the app target resources.

4. Host the bundle from Swift:

```swift
import SwiftUI
import SwiftJS
import SwiftJSCalendar
import SwiftJSLocation

struct ContentView: View {
    @State private var runtime = JSSurfaceRuntime(
        source: .bundleResource(name: "app.bundle", extension: "js", bundle: .main),
        modules: [SwiftJSLocationModule(), SwiftJSCalendarModule()]
    )

    var body: some View {
        JSSurfaceView(runtime: runtime)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
```

5. Create `WebApp/Project/main.tsx`:

```tsx
import { Text, VStack, mount } from "swiftjs"

function App() {
  return (
    <VStack padding={20}>
      <Text font="title">Hello from SwiftJS</Text>
    </VStack>
  )
}

mount(App)
```

## Example

```tsx
import { Button, Text, VStack, mount, useState } from "swiftjs"

function App() {
  const [count, setCount] = useState(0)

  return (
    <VStack spacing={12} padding={20}>
      <Text font="title">Count {count}</Text>
      <Button action={() => setCount(count + 1)}>
        <Text>Increment</Text>
      </Button>
    </VStack>
  )
}

mount(App)
```

## Building The Catalog Example

```bash
cd Examples/CatalogApp/JS
pnpm install
pnpm build

cd ../../..
xcodebuild -project Examples/CatalogApp/CatalogApp.xcodeproj \
  -scheme CatalogApp \
  -destination 'generic/platform=iOS Simulator' \
  build
```

## License

MIT
