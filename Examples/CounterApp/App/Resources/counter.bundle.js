"use strict";
(() => {
  // ../App/Project/src/swiftjs/index.ts
  function runtime() {
    if (!globalThis.__swiftjsRuntime) {
      throw new Error("swiftjs runtime bridge is missing");
    }
    return globalThis.__swiftjsRuntime;
  }
  function hostComponent(name) {
    return function HostComponent(props) {
      return runtime().createElement(name, props);
    };
  }
  var Fragment = runtime().Fragment;
  var createElement = (type, props, ...children) => runtime().createElement(type, props, ...children);
  var useState = (initialValue) => runtime().useState(initialValue);
  var mount = (component) => runtime().mount(component);
  var VStack = hostComponent("VStack");
  var HStack = hostComponent("HStack");
  var Text = hostComponent("Text");
  var Image = hostComponent("Image");
  var Divider = hostComponent("Divider");
  var Button = hostComponent("Button");

  // ../App/Project/src/theme.ts
  var spacing = {
    compact: 8,
    section: 20,
    buttonRow: 20,
    screenPadding: 16,
    resetTop: 20
  };

  // ../App/Project/src/swiftjs/jsx-runtime.ts
  var Fragment2 = globalThis.__swiftjsRuntime?.Fragment ?? Symbol.for("swiftjs.fragment");
  function jsx(type, props) {
    return createElement(type, props);
  }
  var jsxs = jsx;

  // ../App/Project/src/CounterActions.tsx
  function CounterActions(props) {
    return /* @__PURE__ */ jsxs(HStack, { id: "counter-actions", spacing: spacing.buttonRow, children: [
      /* @__PURE__ */ jsx(
        Button,
        {
          id: "decrement-button",
          action: props.onDecrement,
          disabled: props.decrementDisabled,
          font: "largeTitle",
          frame: { width: 80, height: 80 },
          buttonStyle: "glass",
          buttonBorderShape: "circle",
          foregroundColor: "white",
          glassEffect: { tint: "red" },
          children: "-"
        }
      ),
      /* @__PURE__ */ jsx(
        Button,
        {
          id: "increment-button",
          action: props.onIncrement,
          font: "largeTitle",
          frame: { width: 80, height: 80 },
          buttonStyle: "glass",
          buttonBorderShape: "circle",
          foregroundColor: "white",
          glassEffect: { tint: "green" },
          children: "+"
        }
      )
    ] });
  }

  // ../App/Project/src/ContentView.tsx
  function ContentView() {
    const [counter, setCounter] = useState(0);
    return /* @__PURE__ */ jsxs(VStack, { id: "counter-root", spacing: spacing.section, padding: spacing.screenPadding, children: [
      /* @__PURE__ */ jsxs(HStack, { id: "counter-header", spacing: 12, padding: 8, children: [
        /* @__PURE__ */ jsx(
          Image,
          {
            id: "counter-header-symbol",
            systemName: "app.badge.fill",
            font: { system: { size: 34, weight: "semibold" } },
            foregroundColor: "orange",
            symbolRenderingMode: "multicolor"
          }
        ),
        /* @__PURE__ */ jsxs(VStack, { id: "counter-header-copy", spacing: spacing.compact, children: [
          /* @__PURE__ */ jsx(
            Text,
            {
              id: "counter-title",
              font: "largeTitle",
              fontWeight: "bold",
              onAppear: () => {
                console.log("Counter title appeared");
              },
              children: "Counter App"
            }
          ),
          /* @__PURE__ */ jsx(Text, { id: "counter-subtitle", font: "caption", foregroundColor: "secondary", children: "Native SwiftUI views driven by a JS surface" })
        ] })
      ] }),
      /* @__PURE__ */ jsx(
        Text,
        {
          id: "counter-value",
          font: { system: { size: 80, weight: "bold" } },
          padding: 16,
          children: String(counter)
        }
      ),
      /* @__PURE__ */ jsx(
        CounterActions,
        {
          onIncrement: () => setCounter((current) => current + 1),
          onDecrement: () => {
            if (counter > 0) {
              setCounter((current) => current - 1);
            }
          },
          decrementDisabled: counter === 0
        }
      ),
      /* @__PURE__ */ jsx(Divider, { id: "counter-divider" }),
      /* @__PURE__ */ jsxs(HStack, { id: "counter-native-row", spacing: 12, padding: 8, children: [
        /* @__PURE__ */ jsx(
          Image,
          {
            id: "counter-native-icon",
            systemName: "iphone.gen3.radiowaves.left.and.right.circle.fill",
            font: { system: { size: 24, weight: "regular" } },
            foregroundColor: "mint",
            symbolRenderingMode: "hierarchical"
          }
        ),
        /* @__PURE__ */ jsx(Text, { id: "counter-native-copy", font: "body", children: "SF Symbols and native layout are rendered by SwiftUI." })
      ] }),
      /* @__PURE__ */ jsx(
        Button,
        {
          id: "reset-button",
          action: () => setCounter(0),
          disabled: counter === 0,
          font: "title",
          padding: 16,
          paddingTop: spacing.resetTop,
          buttonStyle: "borderedProminent",
          buttonBorderShape: "capsule",
          children: "Reset"
        }
      )
    ] });
  }

  // ../App/Project/src/main.tsx
  mount(ContentView);
})();
//# sourceMappingURL=counter.bundle.js.map
