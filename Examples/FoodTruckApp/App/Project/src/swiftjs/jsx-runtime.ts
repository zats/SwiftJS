import { createElement } from "./index"

declare global {
  var __swiftjsRuntime:
    | {
        Fragment: symbol
      }
    | undefined
}

export const Fragment = globalThis.__swiftjsRuntime?.Fragment ?? Symbol.for("swiftjs.fragment")

export function jsx(type: unknown, props: Record<string, unknown>) {
  return createElement(type, props)
}

export const jsxs = jsx
export const jsxDEV = jsx
