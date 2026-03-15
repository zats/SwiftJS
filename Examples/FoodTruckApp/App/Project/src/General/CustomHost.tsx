import { createElement } from "../swiftjs"

function normalizeChildren(children: unknown): unknown[] {
  if (!Array.isArray(children)) {
    return children === undefined || children === null || children === false ? [] : [children]
  }

  return children.flatMap((child) => normalizeChildren(child))
}

export function CustomHost(
  props: {
    id?: string
    name: string
    values?: Record<string, string | number | boolean>
    slots?: Record<string, unknown>
    children?: unknown
  } & Record<string, unknown>
) {
  const { id, name, values, slots, children, ...rest } = props

  return createElement(
    "Custom",
    {
      ...rest,
      id,
      name,
      values,
      slots,
    },
    ...normalizeChildren(children)
  )
}
