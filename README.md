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

```sh
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
