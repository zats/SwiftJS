import { cp, mkdir } from "node:fs/promises"
import path from "node:path"
import { fileURLToPath } from "node:url"

const root = path.dirname(fileURLToPath(import.meta.url))
const destinationRoot = process.argv[2]

if (!destinationRoot) {
  throw new Error("expected destination path")
}

const files = [
  [path.join(root, "package.json"), "package.json"],
  [path.join(root, "build-swiftjs-app.mjs"), "build-swiftjs-app.mjs"],
  [path.join(root, "index.ts"), "index.ts"],
  [path.join(root, "jsx-runtime.ts"), "jsx-runtime.ts"],
  [path.join(root, "types.ts"), "types.ts"],
  [path.join(root, "location.ts"), "location.ts"],
  [path.join(root, "calendar.ts"), "calendar.ts"],
]

await mkdir(destinationRoot, { recursive: true })

for (const [source, name] of files) {
  await cp(source, path.join(destinationRoot, name), { force: true })
}
