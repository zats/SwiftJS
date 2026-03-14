"use strict";
(() => {
  // ../FoodTruckApp/App/Project/src/swiftjs/index.ts
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

  // ../FoodTruckApp/App/Project/src/swiftjs/jsx-runtime.ts
  var Fragment2 = globalThis.__swiftjsRuntime?.Fragment ?? Symbol.for("swiftjs.fragment");
  function jsx(type, props) {
    return createElement(type, props);
  }
  var jsxs = jsx;

  // ../FoodTruckApp/App/Project/src/ContentView.tsx
  var heroHeight = 158;
  var panelSpacing = 18;
  var sections = [
    { id: "truck", title: "Truck", subtitle: "Dashboard cards and entry points" },
    { id: "orders", title: "Orders", subtitle: "Grouped list, search, and detail flow" },
    { id: "donuts", title: "Donuts", subtitle: "Gallery, editor, and layered assets" },
    { id: "city", title: "City", subtitle: "Weather, map placeholder, and recommendations" }
  ];
  function ContentView() {
    const [selectedSection, setSelectedSection] = useState("truck");
    const activeSection = sections.find((section) => section.id === selectedSection) ?? sections[0];
    return /* @__PURE__ */ jsxs(VStack, { id: "food-truck-root", spacing: panelSpacing, padding: 20, children: [
      /* @__PURE__ */ jsx(
        Image,
        {
          id: "food-truck-header",
          name: "header/Static",
          frame: { height: heroHeight }
        }
      ),
      /* @__PURE__ */ jsxs(VStack, { id: "food-truck-copy", spacing: 8, children: [
        /* @__PURE__ */ jsx(Text, { id: "food-truck-title", font: "largeTitle", fontWeight: "bold", children: "Food Truck" }),
        /* @__PURE__ */ jsx(Text, { id: "food-truck-subtitle", font: "body", foregroundColor: "secondary", children: "Separate SwiftJS sample app. First pass is wired to the local package and bundled assets." })
      ] }),
      /* @__PURE__ */ jsxs(HStack, { id: "food-truck-overview", spacing: 12, padding: 14, background: "white", cornerRadius: 18, children: [
        /* @__PURE__ */ jsx(
          Image,
          {
            id: "food-truck-box",
            name: "box/Composed",
            frame: { width: 92, height: 92 }
          }
        ),
        /* @__PURE__ */ jsxs(VStack, { id: "food-truck-overview-copy", spacing: 6, children: [
          /* @__PURE__ */ jsx(Text, { id: "food-truck-overview-title", font: "title", fontWeight: "semibold", children: "Iteration Zero" }),
          /* @__PURE__ */ jsx(Text, { id: "food-truck-overview-body", font: "body", foregroundColor: "secondary", children: "Assets load from the sample bundle. Next iterations will expand the native binding surface and move real Food Truck behavior into JS." })
        ] })
      ] }),
      /* @__PURE__ */ jsx(VStack, { id: "food-truck-section-list", spacing: 10, children: sections.map((section) => /* @__PURE__ */ jsx(
        Button,
        {
          id: `section-${section.id}`,
          action: () => setSelectedSection(section.id),
          buttonStyle: selectedSection === section.id ? "borderedProminent" : "bordered",
          buttonBorderShape: "roundedRectangle",
          padding: 14,
          children: section.title
        }
      )) }),
      /* @__PURE__ */ jsx(Divider, { id: "food-truck-divider" }),
      /* @__PURE__ */ jsxs(VStack, { id: "food-truck-active-section", spacing: 8, padding: 18, background: "white", cornerRadius: 20, children: [
        /* @__PURE__ */ jsx(Text, { id: "food-truck-active-title", font: "title", fontWeight: "bold", children: activeSection.title }),
        /* @__PURE__ */ jsx(Text, { id: "food-truck-active-subtitle", font: "body", foregroundColor: "secondary", children: activeSection.subtitle })
      ] })
    ] });
  }

  // ../FoodTruckApp/App/Project/src/main.tsx
  mount(ContentView);
})();
//# sourceMappingURL=food-truck.bundle.js.map
