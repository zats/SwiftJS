#!/usr/bin/env node
import { spawnSync } from "node:child_process"
import { access, mkdir, readdir, rm, writeFile } from "node:fs/promises"
import path from "node:path"
import { pathToFileURL } from "node:url"

const [jsRootArg, projectRootArg, bundleRootArg, bundleFileNameArg] = process.argv.slice(2)

if (!jsRootArg || !projectRootArg || !bundleRootArg) {
  throw new Error("usage: build-swiftjs-app <js-root> <project-root> <bundle-root> [bundle-file-name]")
}

const jsRoot = path.resolve(jsRootArg)
const projectRoot = path.resolve(jsRoot, projectRootArg)
const bundleRoot = path.resolve(jsRoot, bundleRootArg)
const bundleFileName = bundleFileNameArg ?? "app.bundle.js"
const requestedNodeModulesRoot = process.env.WEBAPP_NODE_MODULES
  ?? (process.env.DERIVED_FILE_DIR ? path.join(process.env.DERIVED_FILE_DIR, "swiftjs-node-modules") : path.join(jsRoot, "node_modules"))
const nodeModulesRoot = path.resolve(jsRoot, requestedNodeModulesRoot)
const pnpmModulesDir = path.relative(jsRoot, nodeModulesRoot) || "node_modules"

function run(command, args) {
  const result = spawnSync(command, args, {
    cwd: jsRoot,
    stdio: "inherit",
    env: process.env,
  })
  if (result.error) {
    throw result.error
  }
  if (result.status !== 0) {
    throw new Error(`${command} ${args.join(" ")} failed with exit ${result.status}`)
  }
}

async function pathExists(filePath) {
  try {
    await access(filePath)
    return true
  } catch {
    return false
  }
}

const rootNodeModules = path.join(jsRoot, "node_modules")
const hadRootNodeModules = await pathExists(rootNodeModules)

run("pnpm", ["install", "--frozen-lockfile", "--modules-dir", pnpmModulesDir])

async function packageRoot(packageName) {
  const flatRoot = path.join(nodeModulesRoot, packageName)
  if (await pathExists(flatRoot)) {
    return flatRoot
  }

  const storeRoot = path.join(nodeModulesRoot, ".pnpm")
  const storeEntries = await readdir(storeRoot)
  const prefix = `${packageName.replace("/", "+")}@`
  const entry = storeEntries.find((candidate) => candidate.startsWith(prefix))
  if (!entry) {
    throw new Error(`Could not find ${packageName} in ${nodeModulesRoot}`)
  }
  return path.join(storeRoot, entry, "node_modules", packageName)
}

const esbuildRoot = await packageRoot("esbuild")
const swiftJSRoot = await packageRoot("swiftjs")
const esbuildURL = pathToFileURL(path.join(esbuildRoot, "lib", "main.js")).href
const esbuild = await import(esbuildURL)

await mkdir(bundleRoot, { recursive: true })

const outputFile = path.join(bundleRoot, bundleFileName)
const result = await esbuild.build({
  entryPoints: [path.join(projectRoot, "main.tsx")],
  bundle: true,
  outfile: outputFile,
  write: false,
  nodePaths: [nodeModulesRoot, path.dirname(swiftJSRoot)],
  format: "iife",
  platform: "browser",
  target: "es2020",
})

const bundledScript = result.outputFiles[0].text.replace(/^ {2}\/\/ .*\r?\n/gm, "")
await writeFile(outputFile, bundledScript)

if (!hadRootNodeModules && rootNodeModules !== nodeModulesRoot) {
  await rm(rootNodeModules, { recursive: true, force: true })
}

const manifest = {
  bundleCreatedAt: new Date().toISOString(),
  entryScript: bundleFileName,
  projectDirectory: path.relative(path.dirname(bundleRoot), projectRoot) || ".",
  scriptFiles: [bundleFileName],
}

await writeFile(path.join(bundleRoot, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`)
