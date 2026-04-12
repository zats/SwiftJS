import { cp, mkdir } from "node:fs/promises"
import path from "node:path"
import { fileURLToPath } from "node:url"

const root = path.dirname(fileURLToPath(import.meta.url))
const destinationRoot = process.argv[2]

if (!destinationRoot) {
  throw new Error("expected destination path")
}

const files = ["package.json", "index.ts", "jsx-runtime.ts", "types.ts", "location.ts", "calendar.ts"]

await mkdir(destinationRoot, { recursive: true })

for (const name of files) {
  await cp(path.join(root, name), path.join(destinationRoot, name), { force: true })
}
