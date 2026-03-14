import path from "node:path"
import { fileURLToPath } from "node:url"
import esbuild from "esbuild"

const root = path.dirname(fileURLToPath(import.meta.url))
const projectRoot = path.join(root, "../FoodTruckApp/App/Project")

await esbuild.build({
  entryPoints: [path.join(projectRoot, "src/main.tsx")],
  bundle: true,
  outfile: path.join(root, "../FoodTruckApp/App/Resources/food-truck.bundle.js"),
  format: "iife",
  platform: "browser",
  target: "es2020",
  sourcemap: true
})
