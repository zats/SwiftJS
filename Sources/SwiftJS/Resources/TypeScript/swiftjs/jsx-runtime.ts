import { createElement } from "./index"

const runtime = globalThis as { __swiftjsRuntime?: { Fragment: symbol } }

export const Fragment = runtime.__swiftjsRuntime?.Fragment ?? Symbol.for("swiftjs.fragment")

export function jsx(type: unknown, props: Record<string, unknown>) {
  return createElement(type, props)
}

export const jsxs = jsx
export const jsxDEV = jsx
