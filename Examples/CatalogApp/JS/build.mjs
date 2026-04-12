import path from "node:path"
import os from "node:os"
import { fileURLToPath } from "node:url"
import esbuild from "esbuild"

const root = path.dirname(fileURLToPath(import.meta.url))
const projectRoot = path.join(root, "../App/Project")
const outfile = process.env.SWIFTJS_BUNDLE_OUTFILE || path.join(os.tmpdir(), "swiftjs-catalog.bundle.js")

await esbuild.build({
  entryPoints: [path.join(projectRoot, "src/main.tsx")],
  bundle: true,
  outfile,
  format: "iife",
  platform: "browser",
  target: "es2020",
  sourcemap: true
})
