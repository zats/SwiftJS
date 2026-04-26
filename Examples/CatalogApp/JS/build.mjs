import path from "node:path"
import os from "node:os"
import { execFile as execFileCallback } from "node:child_process"
import { cp, mkdir, mkdtemp, stat } from "node:fs/promises"
import { promisify } from "node:util"
import { fileURLToPath } from "node:url"
import esbuild from "esbuild"

const root = path.dirname(fileURLToPath(import.meta.url))
const projectRoot = path.join(root, "../App/Project")
const outfile = process.env.SWIFTJS_BUNDLE_OUTFILE || path.join(os.tmpdir(), "swiftjs-catalog.bundle.js")
const benchmarkOutfile = process.env.SWIFTJS_BENCHMARK_BUNDLE_OUTFILE || path.join(os.tmpdir(), "swiftjs-benchmark.bundle.js")
const stageScript = path.join(root, "../../../Sources/SwiftJS/Package/stage-swiftjs-package.mjs")
const stagedSDKRoot = path.join(projectRoot, "node_modules", "swiftjs")
const execFile = promisify(execFileCallback)

const tempRoot = await mkdtemp(path.join(os.tmpdir(), "swiftjs-catalog-sdk-"))
const stagedTempRoot = path.join(tempRoot, "swiftjs")

try {
  await execFile("node", [stageScript, stagedTempRoot], {
    cwd: root,
  })

  try {
    await stat(stagedSDKRoot)
    await execFile("trash", [stagedSDKRoot])
  } catch {
    // Nothing to remove.
  }

  await mkdir(path.dirname(stagedSDKRoot), { recursive: true })
  await cp(stagedTempRoot, stagedSDKRoot, { recursive: true, force: true })
} finally {
  await execFile("trash", [tempRoot]).catch(() => undefined)
}

async function buildBundle(entryPoint, outputFile) {
  await esbuild.build({
    entryPoints: [path.join(projectRoot, entryPoint)],
    absWorkingDir: projectRoot,
    bundle: true,
    outfile: outputFile,
    format: "iife",
    platform: "browser",
    target: "es2020",
    sourcemap: true
  })
}

await buildBundle("src/main.tsx", outfile)
await buildBundle("src/benchmark.tsx", benchmarkOutfile)
