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
  var ZStack = hostComponent("ZStack");
  var Grid = hostComponent("Grid");
  var GridRow = hostComponent("GridRow");
  var FlowLayout = hostComponent("FlowLayout");
  var ScrollView = hostComponent("ScrollView");
  var List = hostComponent("List");
  var Section = hostComponent("Section");
  var NavigationSplitView = hostComponent("NavigationSplitView");
  var Spacer = hostComponent("Spacer");
  var Text = hostComponent("Text");
  var Label = hostComponent("Label");
  var Image = hostComponent("Image");
  var Divider = hostComponent("Divider");
  var Button = hostComponent("Button");

  // ../App/Project/src/Support/SampleData.ts
  var doughOptions = [
    { id: "plain", name: "Plain", thumb: "dough/plain-thumb", full: "dough/plain-full" },
    { id: "pink", name: "Pink", thumb: "dough/pink-thumb", full: "dough/pink-full" },
    { id: "blue", name: "Blue", thumb: "dough/blue-thumb", full: "dough/blue-full" },
    { id: "yellow", name: "Yellow", thumb: "dough/yellow-thumb", full: "dough/yellow-full" }
  ];
  var glazeOptions = [
    { id: "pink", name: "Strawberry", thumb: "glaze/pink-thumb", full: "glaze/pink-full" },
    { id: "blue", name: "Blueberry", thumb: "glaze/blue-thumb", full: "glaze/blue-full" },
    { id: "brown", name: "Chocolate", thumb: "glaze/brown-thumb", full: "glaze/brown-full" },
    { id: "rainbow", name: "Rainbow", thumb: "glaze/rainbow-thumb", full: "glaze/rainbow-full" }
  ];
  var toppingOptions = [
    { id: "sprinkles", name: "Sprinkles", thumb: "topping/sprinkles-thumb", full: "topping/sprinkles-full" },
    { id: "powdersugar", name: "Powder Sugar", thumb: "topping/powdersugar-thumb", full: "topping/powdersugar-full" },
    { id: "zigzag-white", name: "White Zigzag", thumb: "topping/zigzag-white-thumb", full: "topping/zigzag-white-full" },
    { id: "crisscross-yellow", name: "Yellow Crisscross", thumb: "topping/crisscross-yellow-thumb", full: "topping/crisscross-yellow-full" }
  ];
  var donutCatalog = [
    {
      id: "strawberry-sprinkles",
      name: "Strawberry Sprinkles",
      dough: doughOptions[0],
      glaze: glazeOptions[0],
      topping: toppingOptions[0],
      sales: "$5.4K"
    },
    {
      id: "blue-sky",
      name: "Blue Sky",
      dough: doughOptions[2],
      glaze: glazeOptions[1],
      topping: toppingOptions[2],
      sales: "$4.9K"
    },
    {
      id: "powder-party",
      name: "Powder Party",
      dough: doughOptions[3],
      glaze: glazeOptions[3],
      topping: toppingOptions[1],
      sales: "$4.6K"
    },
    {
      id: "sunrise-grid",
      name: "Sunrise Grid",
      dough: doughOptions[1],
      glaze: glazeOptions[2],
      topping: toppingOptions[3],
      sales: "$4.1K"
    },
    {
      id: "rainbow-rally",
      name: "Rainbow Rally",
      dough: doughOptions[0],
      glaze: glazeOptions[3],
      topping: toppingOptions[0],
      sales: "$3.8K"
    }
  ];
  var orders = [
    { id: "Order #4021", customer: "Mina R.", city: "San Francisco", donuts: 12, total: "$118", status: "New" },
    { id: "Order #4020", customer: "A. Chen", city: "Cupertino", donuts: 8, total: "$72", status: "New" },
    { id: "Order #4017", customer: "Studio Lune", city: "New York", donuts: 18, total: "$164", status: "Preparing" },
    { id: "Order #4015", customer: "River Team", city: "San Francisco", donuts: 6, total: "$54", status: "Preparing" },
    { id: "Order #4012", customer: "Nora W.", city: "Cupertino", donuts: 10, total: "$92", status: "Ready" },
    { id: "Order #4008", customer: "Beacon Labs", city: "New York", donuts: 20, total: "$188", status: "Completed" }
  ];
  var socialPosts = [
    { id: "post-1", title: "Today\u2019s route: Ocean Beach to SoMa", subtitle: "Warm donuts, black raspberry glaze, and a new citrus topping." },
    { id: "post-2", title: "The social feed card is now real SwiftJS UI", subtitle: "Same content model, new reusable host bindings under it." },
    { id: "post-3", title: "Most requested combo this week", subtitle: "Rainbow glaze with powdered sugar and a plain dough base." }
  ];
  var trendingTopics = [
    "Rainbow Sprinkles",
    "Room Temperature",
    "Dairy Free",
    "Cupertino",
    "Warmed Up",
    "Black Raspberry"
  ];
  var cities = [
    {
      id: "san-francisco",
      name: "San Francisco",
      forecast: "Sunny for the lunch rush, cool after 4 PM.",
      temperature: "68\xB0F",
      cloudCover: "12%",
      recommendation: "Keep the truck near Embarcadero. Strong foot traffic and low rain chance through the afternoon."
    },
    {
      id: "cupertino",
      name: "Cupertino",
      forecast: "Clear and warm through the late afternoon.",
      temperature: "74\xB0F",
      cloudCover: "9%",
      recommendation: "Stock bright fruit glazes and cold ingredients. Campus traffic peaks around 3 PM."
    },
    {
      id: "new-york",
      name: "New York",
      forecast: "Patchy clouds with a mild evening cooldown.",
      temperature: "71\xB0F",
      cloudCover: "28%",
      recommendation: "Favor Midtown for the next stop. Office volume is high and rain holds off until tonight."
    }
  ];
  function forecastEntry(hourOffset, degrees, isDaylight) {
    return {
      date: new Date(Date.UTC(2022, 4, 6, 9 + hourOffset)),
      degrees,
      isDaylight
    };
  }
  var truckForecast = {
    entries: [
      forecastEntry(0, 63, true),
      forecastEntry(1, 68, true),
      forecastEntry(2, 72, true),
      forecastEntry(3, 77, true),
      forecastEntry(4, 80, true),
      forecastEntry(5, 82, true),
      forecastEntry(6, 83, true),
      forecastEntry(7, 83, true),
      forecastEntry(8, 81, true),
      forecastEntry(9, 79, true),
      forecastEntry(10, 75, true),
      forecastEntry(11, 70, true),
      forecastEntry(12, 66, false)
    ]
  };
  var truckShowcaseDonuts = [
    donutCatalog[0],
    donutCatalog[1],
    donutCatalog[2],
    donutCatalog[3],
    donutCatalog[4],
    donutCatalog[1],
    donutCatalog[3],
    donutCatalog[0],
    donutCatalog[2],
    donutCatalog[4],
    donutCatalog[0],
    donutCatalog[2],
    donutCatalog[3],
    donutCatalog[1]
  ];
  var donutPanels = [
    { panel: "donuts", title: "Donuts", icon: "donut" },
    { panel: "donutEditor", title: "Donut Editor", icon: "slider.horizontal.3" },
    { panel: "topFive", title: "Top 5", icon: "trophy" }
  ];
  function cityPanel(id) {
    return `city:${id}`;
  }
  function formatForecastHour(date) {
    const hour = date.getUTCHours();
    const normalizedHour = (hour + 11) % 12 + 1;
    const suffix = hour >= 12 ? "PM" : "AM";
    return `${normalizedHour} ${suffix}`;
  }

  // ../App/Project/src/swiftjs/jsx-runtime.ts
  var Fragment2 = globalThis.__swiftjsRuntime?.Fragment ?? Symbol.for("swiftjs.fragment");
  function jsx(type, props) {
    return createElement(type, props);
  }
  var jsxs = jsx;

  // ../App/Project/src/City/CityView.tsx
  function CityView(props) {
    return /* @__PURE__ */ jsx(ScrollView, { id: `city-${props.city.id}`, navigationTitle: props.city.name, background: "systemGroupedBackground", children: /* @__PURE__ */ jsxs(VStack, { id: `city-stack-${props.city.id}`, alignment: "leading", spacing: 16, padding: 16, children: [
      /* @__PURE__ */ jsxs(VStack, { id: `city-hero-${props.city.id}`, alignment: "trailing", spacing: 12, children: [
        /* @__PURE__ */ jsx(
          Image,
          {
            id: `city-hero-image-${props.city.id}`,
            name: "header/Static",
            frame: { height: 240 },
            imageContentMode: "fit",
            cornerRadius: 24
          }
        ),
        /* @__PURE__ */ jsxs(
          VStack,
          {
            id: `city-weather-card-${props.city.id}`,
            alignment: "leading",
            spacing: 4,
            padding: 14,
            background: "secondarySystemBackground",
            cornerRadius: 18,
            children: [
              /* @__PURE__ */ jsx(Text, { id: `city-temp-${props.city.id}`, font: "title2", fontWeight: "bold", children: props.city.temperature }),
              /* @__PURE__ */ jsx(Text, { id: `city-forecast-${props.city.id}`, font: "subheadline", foregroundColor: "secondary", children: props.city.forecast })
            ]
          }
        )
      ] }),
      /* @__PURE__ */ jsxs(VStack, { id: `city-recommendation-card-${props.city.id}`, alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
        /* @__PURE__ */ jsx(Text, { id: `city-rec-title-${props.city.id}`, font: "headline", fontWeight: "semibold", foregroundColor: "indigo", children: "Recommendation" }),
        /* @__PURE__ */ jsx(Text, { id: `city-rec-${props.city.id}`, font: "body", foregroundColor: "secondary", children: props.city.recommendation })
      ] }),
      /* @__PURE__ */ jsxs(VStack, { id: `city-operations-card-${props.city.id}`, alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
        /* @__PURE__ */ jsx(Text, { id: `city-ops-title-${props.city.id}`, font: "headline", fontWeight: "semibold", foregroundColor: "indigo", children: "Operations" }),
        /* @__PURE__ */ jsxs(Text, { id: `city-clouds-${props.city.id}`, font: "subheadline", foregroundColor: "secondary", children: [
          "Cloud cover is currently ",
          props.city.cloudCover,
          "."
        ] }),
        /* @__PURE__ */ jsx(Text, { id: `city-stock-${props.city.id}`, font: "subheadline", foregroundColor: "secondary", children: "Popular donuts this week include Strawberry Sprinkles, Blue Sky, and Rainbow Rally." })
      ] })
    ] }) });
  }

  // ../App/Project/src/Support/DonutComponents.tsx
  function DonutPreview(props) {
    let imageSize = 72;
    if (props.size === "mini") {
      imageSize = 32;
    } else if (props.size === "lattice") {
      imageSize = 40;
    } else if (props.size === "card") {
      imageSize = 48;
    } else if (props.size === "featured") {
      imageSize = 84;
    } else if (props.size === "full") {
      imageSize = 220;
    }
    const dough = props.size === "full" ? props.recipe.dough.full : props.recipe.dough.thumb;
    const glaze = props.size === "full" ? props.recipe.glaze.full : props.recipe.glaze.thumb;
    const topping = props.size === "full" ? props.recipe.topping.full : props.recipe.topping.thumb;
    return /* @__PURE__ */ jsxs(ZStack, { id: `preview-${props.recipe.id}-${props.size}`, frame: { width: imageSize, height: imageSize }, children: [
      /* @__PURE__ */ jsx(Image, { id: `preview-dough-${props.recipe.id}-${props.size}`, name: dough, frame: { width: imageSize, height: imageSize } }),
      /* @__PURE__ */ jsx(Image, { id: `preview-glaze-${props.recipe.id}-${props.size}`, name: glaze, frame: { width: imageSize, height: imageSize } }),
      /* @__PURE__ */ jsx(Image, { id: `preview-topping-${props.recipe.id}-${props.size}`, name: topping, frame: { width: imageSize, height: imageSize } })
    ] });
  }
  function DonutThumbnail(props) {
    return /* @__PURE__ */ jsxs(VStack, { id: `thumb-${props.recipe.id}`, alignment: "center", spacing: 6, children: [
      /* @__PURE__ */ jsx(DonutPreview, { recipe: props.recipe, size: "thumb" }),
      /* @__PURE__ */ jsx(Text, { id: `thumb-title-${props.recipe.id}`, font: "footnote", foregroundColor: "secondary", children: props.recipe.name })
    ] });
  }
  function GalleryTile(props) {
    return /* @__PURE__ */ jsxs(
      VStack,
      {
        id: `gallery-tile-${props.recipe.id}`,
        alignment: "center",
        spacing: 8,
        padding: 12,
        background: "secondarySystemBackground",
        cornerRadius: 18,
        children: [
          /* @__PURE__ */ jsx(DonutPreview, { recipe: props.recipe, size: "thumb" }),
          /* @__PURE__ */ jsx(Text, { id: `gallery-name-${props.recipe.id}`, font: "subheadline", fontWeight: "semibold", children: props.recipe.name }),
          /* @__PURE__ */ jsx(Text, { id: `gallery-sales-${props.recipe.id}`, font: "footnote", foregroundColor: "secondary", children: props.recipe.sales })
        ]
      }
    );
  }
  function EditorSection(props) {
    return /* @__PURE__ */ jsxs(VStack, { id: `editor-section-${props.title}`, alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
      /* @__PURE__ */ jsxs(HStack, { id: `editor-section-header-${props.title}`, spacing: 8, children: [
        /* @__PURE__ */ jsx(Image, { id: `editor-section-icon-${props.title}`, systemName: "slider.horizontal.3", foregroundColor: "indigo" }),
        /* @__PURE__ */ jsx(Text, { id: `editor-section-title-${props.title}`, font: "headline", fontWeight: "semibold", foregroundColor: "indigo", children: props.title })
      ] }),
      /* @__PURE__ */ jsx(HStack, { id: `editor-options-${props.title}`, spacing: 10, compactVertical: true, children: props.options.map((option, index) => /* @__PURE__ */ jsx(
        Button,
        {
          id: `editor-option-${props.title}-${option.id}`,
          action: () => props.onSelect(index),
          buttonStyle: props.selectedIndex === index ? "borderedProminent" : "bordered",
          buttonBorderShape: "roundedRectangle",
          children: option.name
        },
        option.id
      )) })
    ] });
  }

  // ../App/Project/src/Donut/DonutEditor.tsx
  function DonutEditor() {
    const [doughIndex, setDoughIndex] = useState(0);
    const [glazeIndex, setGlazeIndex] = useState(0);
    const [toppingIndex, setToppingIndex] = useState(0);
    const dough = doughOptions[doughIndex];
    const glaze = glazeOptions[glazeIndex];
    const topping = toppingOptions[toppingIndex];
    return /* @__PURE__ */ jsx(ScrollView, { id: "donut-editor-view", navigationTitle: "Donut Editor", background: "systemGroupedBackground", children: /* @__PURE__ */ jsxs(VStack, { id: "donut-editor-stack", alignment: "leading", spacing: 16, padding: 16, children: [
      /* @__PURE__ */ jsxs(VStack, { id: "editor-preview-card", alignment: "center", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
        /* @__PURE__ */ jsx(DonutPreview, { recipe: { id: "editor", name: "Custom", dough, glaze, topping, sales: "" }, size: "full" }),
        /* @__PURE__ */ jsxs(Text, { id: "editor-preview-title", font: "title2", fontWeight: "bold", children: [
          dough.name,
          " / ",
          glaze.name,
          " / ",
          topping.name
        ] }),
        /* @__PURE__ */ jsx(Text, { id: "editor-preview-copy", font: "subheadline", foregroundColor: "secondary", children: "This mirrors the original donut editor\u2019s layered composition using reusable `VStack`, `Image`, and `Button` bindings." })
      ] }),
      /* @__PURE__ */ jsx(EditorSection, { title: "Dough", options: doughOptions, selectedIndex: doughIndex, onSelect: setDoughIndex }),
      /* @__PURE__ */ jsx(EditorSection, { title: "Glaze", options: glazeOptions, selectedIndex: glazeIndex, onSelect: setGlazeIndex }),
      /* @__PURE__ */ jsx(EditorSection, { title: "Topping", options: toppingOptions, selectedIndex: toppingIndex, onSelect: setToppingIndex })
    ] }) });
  }

  // ../App/Project/src/Donut/DonutGallery.tsx
  function DonutGallery(props) {
    return /* @__PURE__ */ jsx(ScrollView, { id: "donut-gallery-view", navigationTitle: "Donuts", background: "systemGroupedBackground", children: /* @__PURE__ */ jsx(VStack, { id: "donut-gallery-stack", alignment: "leading", spacing: 16, padding: 16, children: /* @__PURE__ */ jsxs(VStack, { id: "donut-gallery-card", alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
      /* @__PURE__ */ jsx(HStack, { id: "donut-gallery-header", spacing: 8, children: /* @__PURE__ */ jsx(Text, { id: "donut-gallery-title", font: "headline", fontWeight: "semibold", foregroundColor: "indigo", children: "Gallery" }) }),
      /* @__PURE__ */ jsxs(VStack, { id: "donut-gallery-grid", alignment: "leading", spacing: 12, children: [
        /* @__PURE__ */ jsx(HStack, { id: "gallery-row-1", spacing: 12, compactVertical: true, children: donutCatalog.slice(0, 3).map((donut) => /* @__PURE__ */ jsx(GalleryTile, { recipe: donut }, donut.id)) }),
        /* @__PURE__ */ jsx(HStack, { id: "gallery-row-2", spacing: 12, compactVertical: true, children: donutCatalog.slice(2, 5).map((donut) => /* @__PURE__ */ jsx(GalleryTile, { recipe: donut }, donut.id)) })
      ] })
    ] }) }) });
  }

  // ../App/Project/src/Donut/TopFiveDonutsView.tsx
  function TopFiveDonutsView() {
    return /* @__PURE__ */ jsx(List, { id: "top-five-view", navigationTitle: "Top 5", listStyle: "insetGrouped", children: /* @__PURE__ */ jsx(Section, { id: "top-five-section", title: "Best Sellers", children: donutCatalog.map((donut, index) => /* @__PURE__ */ jsxs(HStack, { id: `top-five-${donut.id}`, spacing: 12, padding: 4, children: [
      /* @__PURE__ */ jsx(Text, { id: `top-five-rank-${donut.id}`, font: "headline", fontWeight: "bold", children: index + 1 }),
      /* @__PURE__ */ jsx(DonutThumbnail, { recipe: donut }),
      /* @__PURE__ */ jsxs(VStack, { id: `top-five-copy-${donut.id}`, alignment: "leading", spacing: 2, children: [
        /* @__PURE__ */ jsx(Text, { id: `top-five-name-${donut.id}`, font: "headline", fontWeight: "semibold", children: donut.name }),
        /* @__PURE__ */ jsx(Text, { id: `top-five-sales-${donut.id}`, font: "subheadline", foregroundColor: "secondary", children: donut.sales })
      ] })
    ] }, donut.id)) }) });
  }

  // ../App/Project/src/Orders/OrdersView.tsx
  function OrdersView() {
    const statuses = ["New", "Preparing", "Ready", "Completed"];
    return /* @__PURE__ */ jsx(List, { id: "orders-view", navigationTitle: "Orders", listStyle: "insetGrouped", children: statuses.map((status) => {
      const sectionOrders = orders.filter((order) => order.status === status);
      if (sectionOrders.length === 0) {
        return null;
      }
      return /* @__PURE__ */ jsx(Section, { id: `orders-section-${status}`, title: status, children: sectionOrders.map((order) => /* @__PURE__ */ jsxs(VStack, { id: `order-${order.id}`, alignment: "leading", spacing: 4, padding: 4, children: [
        /* @__PURE__ */ jsxs(HStack, { id: `order-header-${order.id}`, spacing: 8, children: [
          /* @__PURE__ */ jsx(Text, { id: `order-title-${order.id}`, font: "headline", fontWeight: "semibold", children: order.id }),
          /* @__PURE__ */ jsx(Spacer, { id: `order-spacer-${order.id}` }),
          /* @__PURE__ */ jsx(Text, { id: `order-total-${order.id}`, font: "subheadline", fontWeight: "bold", children: order.total })
        ] }),
        /* @__PURE__ */ jsxs(Text, { id: `order-subtitle-${order.id}`, font: "subheadline", foregroundColor: "secondary", children: [
          order.customer,
          " \xB7 ",
          order.city,
          " \xB7 ",
          order.donuts,
          " donuts"
        ] })
      ] }, order.id)) }, status);
    }) });
  }

  // ../App/Project/src/Truck/SalesHistoryView.tsx
  function SalesHistoryView() {
    return /* @__PURE__ */ jsx(ScrollView, { id: "sales-history-view", navigationTitle: "Sales History", background: "systemGroupedBackground", children: /* @__PURE__ */ jsxs(VStack, { id: "sales-history-stack", alignment: "leading", spacing: 16, padding: 16, children: [
      /* @__PURE__ */ jsxs(HStack, { id: "sales-stats", spacing: 12, compactVertical: true, children: [
        /* @__PURE__ */ jsx(MetricCard, { id: "sales-week", label: "This Week", value: "$18.4K" }),
        /* @__PURE__ */ jsx(MetricCard, { id: "sales-yesterday", label: "Yesterday", value: "$2.7K" }),
        /* @__PURE__ */ jsx(MetricCard, { id: "sales-orders", label: "Orders", value: "148" })
      ] }),
      /* @__PURE__ */ jsxs(VStack, { id: "sales-top-donuts-card", alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
        /* @__PURE__ */ jsx(HStack, { id: "sales-top-donuts-header", spacing: 8, children: /* @__PURE__ */ jsx(Text, { id: "sales-top-donuts-title", font: "headline", fontWeight: "semibold", foregroundColor: "indigo", children: "Top Donuts" }) }),
        /* @__PURE__ */ jsx(VStack, { id: "sales-top-donuts", alignment: "leading", spacing: 10, children: donutCatalog.map((donut, index) => /* @__PURE__ */ jsxs(HStack, { id: `sales-top-${donut.id}`, spacing: 10, children: [
          /* @__PURE__ */ jsxs(Text, { id: `sales-rank-${donut.id}`, font: "headline", fontWeight: "bold", children: [
            index + 1,
            "."
          ] }),
          /* @__PURE__ */ jsx(DonutThumbnail, { recipe: donut }),
          /* @__PURE__ */ jsxs(VStack, { id: `sales-copy-${donut.id}`, alignment: "leading", spacing: 2, children: [
            /* @__PURE__ */ jsx(Text, { id: `sales-name-${donut.id}`, font: "headline", fontWeight: "semibold", children: donut.name }),
            /* @__PURE__ */ jsxs(Text, { id: `sales-value-${donut.id}`, font: "subheadline", foregroundColor: "secondary", children: [
              "Weekly sales ",
              donut.sales
            ] })
          ] })
        ] }, donut.id)) })
      ] })
    ] }) });
  }
  function MetricCard(props) {
    return /* @__PURE__ */ jsxs(VStack, { id: props.id, alignment: "leading", spacing: 6, padding: 14, background: "secondarySystemBackground", cornerRadius: 18, children: [
      /* @__PURE__ */ jsx(Text, { id: `${props.id}-value`, font: "title2", fontWeight: "bold", children: props.value }),
      /* @__PURE__ */ jsx(Text, { id: `${props.id}-label`, font: "subheadline", foregroundColor: "secondary", children: props.label })
    ] });
  }

  // ../App/Project/src/Truck/SocialFeedView.tsx
  function SocialFeedView() {
    return /* @__PURE__ */ jsxs(List, { id: "social-feed-view", navigationTitle: "Social Feed", listStyle: "insetGrouped", children: [
      /* @__PURE__ */ jsx(Section, { id: "social-plus-section", children: /* @__PURE__ */ jsxs(VStack, { id: "social-plus-card", alignment: "center", spacing: 6, padding: 18, background: "indigo", cornerRadius: 18, children: [
        /* @__PURE__ */ jsx(Text, { id: "social-plus-title", font: "title2", fontWeight: "bold", foregroundColor: "white", children: "Get Social Feed+" }),
        /* @__PURE__ */ jsx(Text, { id: "social-plus-copy", font: "subheadline", foregroundColor: "white", children: "The premium social-feed experience from the original sample, recreated as portable SwiftJS UI." }),
        /* @__PURE__ */ jsx(Button, { id: "social-plus-button", action: () => {
        }, buttonStyle: "borderedProminent", buttonBorderShape: "roundedRectangle", children: "Learn More" })
      ] }) }),
      /* @__PURE__ */ jsx(Section, { id: "social-posts", title: "Posts", children: socialPosts.map((post) => /* @__PURE__ */ jsxs(VStack, { id: post.id, alignment: "leading", spacing: 4, padding: 4, children: [
        /* @__PURE__ */ jsx(Text, { id: `${post.id}-title`, font: "headline", fontWeight: "semibold", children: post.title }),
        /* @__PURE__ */ jsx(Text, { id: `${post.id}-subtitle`, font: "subheadline", foregroundColor: "secondary", children: post.subtitle })
      ] }, post.id)) })
    ] });
  }

  // ../App/Project/src/Brand/BrandHeader.tsx
  function BrandHeader(props) {
    const scale = props.size === "reduced" ? 0.5 : 1;
    const visibleHeight = 200 * scale;
    const bleedingHeight = 400 * scale;
    return /* @__PURE__ */ jsx(VStack, { id: "brand-header-root", frame: { height: visibleHeight }, children: /* @__PURE__ */ jsx(
      VStack,
      {
        id: "brand-header-canvas",
        background: "teal",
        frame: { height: bleedingHeight },
        paddingTop: -200 * scale
      }
    ) });
  }

  // ../App/Project/src/General/WidthThresholdReader.tsx
  function WidthThresholdReader(props) {
    const widthThreshold = props.widthThreshold ?? 400;
    const content = Array.isArray(props.children) ? props.children[0] : props.children;
    if (typeof content !== "function") {
      throw new Error("WidthThresholdReader requires a render function child");
    }
    return createElement("Custom", {
      id: props.id,
      name: "WidthThresholdReader",
      values: {
        widthThreshold
      },
      slots: {
        compact: content({ width: widthThreshold - 1, isCompact: true }),
        regular: content({ width: widthThreshold + 1, isCompact: false })
      }
    });
  }

  // ../App/Project/src/Truck/Cards/CardNavigationHeader.tsx
  function CardNavigationHeader(props) {
    return /* @__PURE__ */ jsxs(HStack, { id: props.id, spacing: 0, children: [
      /* @__PURE__ */ jsx(Button, { id: `${props.id}-button`, action: props.onSelect, buttonStyle: "plain", children: /* @__PURE__ */ jsxs(HStack, { id: `${props.id}-label`, spacing: 8, children: [
        props.assetName ? /* @__PURE__ */ jsx(Image, { id: `${props.id}-asset`, name: props.assetName, frame: { width: 18, height: 18 } }) : /* @__PURE__ */ jsx(Image, { id: `${props.id}-icon`, systemName: props.systemName ?? "circle", foregroundColor: "indigo" }),
        /* @__PURE__ */ jsx(Text, { id: `${props.id}-title`, font: "headline", fontWeight: "semibold", foregroundColor: "indigo", children: props.title })
      ] }) }),
      /* @__PURE__ */ jsx(Spacer, { id: `${props.id}-spacer` }),
      props.navigationLabel ? /* @__PURE__ */ jsx(Button, { id: `${props.id}-action`, action: props.onSelect, buttonStyle: "plain", children: /* @__PURE__ */ jsxs(HStack, { id: `${props.id}-action-label`, spacing: 4, children: [
        /* @__PURE__ */ jsx(Text, { id: `${props.id}-action-text`, font: "subheadline", fontWeight: "semibold", foregroundColor: "indigo", children: props.navigationLabel }),
        /* @__PURE__ */ jsx(Image, { id: `${props.id}-action-icon`, systemName: "chevron.right", foregroundColor: "indigo" })
      ] }) }) : null
    ] });
  }

  // ../App/Project/src/Truck/Cards/TruckDonutsCard.tsx
  function TruckDonutsCard(props) {
    return /* @__PURE__ */ jsxs(VStack, { id: "truck-donuts-card", alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
      /* @__PURE__ */ jsx(
        CardNavigationHeader,
        {
          id: "truck-donuts-card-header",
          panel: "donuts",
          title: "Donuts",
          assetName: "donut",
          onSelect: () => props.onSelect("donuts")
        }
      ),
      /* @__PURE__ */ jsxs(VStack, { id: "truck-donuts-card-content", alignment: "leading", spacing: 10, frame: { minHeight: 180 }, children: [
        /* @__PURE__ */ jsx(HStack, { id: "truck-donuts-row-1", spacing: 10, children: truckShowcaseDonuts.slice(0, 5).map((donut, index) => /* @__PURE__ */ jsx(VStack, { id: `truck-row-1-${index}-${donut.id}`, children: /* @__PURE__ */ jsx(DonutPreview, { recipe: donut, size: "lattice" }) }, `truck-row-1-${index}-${donut.id}`)) }),
        /* @__PURE__ */ jsxs(HStack, { id: "truck-donuts-row-2", spacing: 10, children: [
          /* @__PURE__ */ jsx(Spacer, { id: "truck-donuts-row-2-leading" }),
          truckShowcaseDonuts.slice(5, 9).map((donut, index) => /* @__PURE__ */ jsx(VStack, { id: `truck-row-2-${index}-${donut.id}`, children: /* @__PURE__ */ jsx(DonutPreview, { recipe: donut, size: "lattice" }) }, `truck-row-2-${index}-${donut.id}`)),
          /* @__PURE__ */ jsx(Spacer, { id: "truck-donuts-row-2-trailing" })
        ] }),
        /* @__PURE__ */ jsx(HStack, { id: "truck-donuts-row-3", spacing: 10, children: truckShowcaseDonuts.slice(9, 14).map((donut, index) => /* @__PURE__ */ jsx(VStack, { id: `truck-row-3-${index}-${donut.id}`, children: /* @__PURE__ */ jsx(DonutPreview, { recipe: donut, size: "lattice" }) }, `truck-row-3-${index}-${donut.id}`)) })
      ] })
    ] });
  }

  // ../App/Project/src/Truck/Cards/TruckOrdersCard.tsx
  function TruckOrdersCard(props) {
    const cardOrders = orders.slice().reverse().slice(0, 5);
    const footerOrder = orders[orders.length - 1];
    return /* @__PURE__ */ jsxs(VStack, { id: "truck-orders-card", alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
      /* @__PURE__ */ jsx(
        CardNavigationHeader,
        {
          id: "truck-orders-card-header",
          panel: "orders",
          title: "New Orders",
          systemName: "shippingbox",
          onSelect: () => props.onSelect("orders")
        }
      ),
      /* @__PURE__ */ jsx(HeroSquareTilingLayout, { id: "truck-orders-card-media", children: cardOrders.map((order, index) => /* @__PURE__ */ jsx(
        OrderPreviewTile,
        {
          order,
          recipe: donutCatalog[index % donutCatalog.length],
          prominent: index === 0
        },
        order.id
      )) }),
      /* @__PURE__ */ jsxs(HStack, { id: "truck-orders-card-footer", spacing: 8, frame: { maxWidth: "infinity" }, children: [
        /* @__PURE__ */ jsx(Spacer, { id: "truck-orders-card-footer-leading" }),
        /* @__PURE__ */ jsx(Text, { id: "truck-orders-card-order-id", font: "subheadline", foregroundColor: "secondary", children: footerOrder.id }),
        /* @__PURE__ */ jsx(Image, { id: "truck-orders-card-order-icon", name: "donut", frame: { width: 14, height: 14 } }),
        /* @__PURE__ */ jsx(Text, { id: "truck-orders-card-order-total", font: "subheadline", foregroundColor: "secondary", children: footerOrder.total }),
        /* @__PURE__ */ jsx(Spacer, { id: "truck-orders-card-footer-trailing" })
      ] })
    ] });
  }
  function HeroSquareTilingLayout(props) {
    const spacing = props.spacing ?? 10;
    const [hero, tile1, tile2, tile3, tile4] = flattenChildren(props.children);
    return /* @__PURE__ */ jsx(VStack, { id: props.id, frame: { maxWidth: "infinity", maxHeight: 250 }, aspectRatio: { value: 2, contentMode: "fit" }, children: /* @__PURE__ */ jsxs(HStack, { id: `${props.id}-content`, spacing, distribution: "fillEqually", children: [
      /* @__PURE__ */ jsx(VStack, { id: `${props.id}-hero`, aspectRatio: { value: 1, contentMode: "fit" }, children: hero }),
      /* @__PURE__ */ jsxs(VStack, { id: `${props.id}-tiles`, spacing, distribution: "fillEqually", children: [
        /* @__PURE__ */ jsxs(HStack, { id: `${props.id}-tiles-top`, spacing, distribution: "fillEqually", children: [
          /* @__PURE__ */ jsx(VStack, { id: `${props.id}-tiles-top-left`, aspectRatio: { value: 1, contentMode: "fit" }, children: tile1 }),
          /* @__PURE__ */ jsx(VStack, { id: `${props.id}-tiles-top-right`, aspectRatio: { value: 1, contentMode: "fit" }, children: tile2 })
        ] }),
        /* @__PURE__ */ jsxs(HStack, { id: `${props.id}-tiles-bottom`, spacing, distribution: "fillEqually", children: [
          /* @__PURE__ */ jsx(VStack, { id: `${props.id}-tiles-bottom-left`, aspectRatio: { value: 1, contentMode: "fit" }, children: tile3 }),
          /* @__PURE__ */ jsx(VStack, { id: `${props.id}-tiles-bottom-right`, aspectRatio: { value: 1, contentMode: "fit" }, children: tile4 })
        ] })
      ] })
    ] }) });
  }
  function flattenChildren(children) {
    if (!Array.isArray(children)) {
      return children === void 0 || children === null || children === false ? [] : [children];
    }
    return children.flatMap((child) => flattenChildren(child));
  }
  function OrderPreviewTile(props) {
    return /* @__PURE__ */ jsx(
      VStack,
      {
        id: `order-tile-${props.order.id}`,
        alignment: "center",
        spacing: 0,
        padding: 6,
        background: "tertiarySystemFill",
        cornerRadius: 10,
        aspectRatio: { value: 1, contentMode: "fit" },
        children: /* @__PURE__ */ jsx(DonutPreview, { recipe: props.recipe, size: props.prominent ? "featured" : "mini" })
      }
    );
  }

  // ../App/Project/src/Truck/Cards/TruckSocialFeedCard.tsx
  function TruckSocialFeedCard(props) {
    return /* @__PURE__ */ jsxs(VStack, { id: "truck-social-feed-card", alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
      /* @__PURE__ */ jsx(
        CardNavigationHeader,
        {
          id: "truck-social-feed-card-header",
          panel: "socialFeed",
          title: "Social Feed",
          systemName: "text.bubble",
          onSelect: () => props.onSelect("socialFeed")
        }
      ),
      /* @__PURE__ */ jsx(
        FlowLayout,
        {
          id: "truck-social-tags",
          alignment: "center",
          spacing: 8,
          lineSpacing: 8,
          padding: 12,
          paddingTop: 15,
          background: "quaternarySystemFill",
          cornerRadius: 18,
          frame: { maxWidth: "infinity", minHeight: 180 },
          children: trendingTopics.map((topic) => /* @__PURE__ */ jsx(Text, { id: `chip-${topic}`, font: "footnote", padding: 8, background: "quaternarySystemFill", cornerRadius: 12, children: topic }, topic))
        }
      ),
      /* @__PURE__ */ jsx(Text, { id: "truck-social-feed-caption", font: "footnote", foregroundColor: "secondary", children: "Trending Topics" })
    ] });
  }

  // ../App/Project/src/Truck/Cards/TruckWeatherCard.tsx
  function TruckWeatherCard(props) {
    const low = Math.min(...truckForecast.entries.map((entry) => entry.degrees));
    const high = Math.max(...truckForecast.entries.map((entry) => entry.degrees));
    const visibleEntries = truckForecast.entries.filter((_, index) => index % 3 === 0).slice(0, 6);
    const span = Math.max(high - low, 1);
    return /* @__PURE__ */ jsxs(VStack, { id: "truck-weather-card", alignment: "leading", spacing: 12, padding: 10, background: "white", cornerRadius: 20, children: [
      /* @__PURE__ */ jsx(
        CardNavigationHeader,
        {
          id: "truck-weather-card-header",
          panel: cityPanel("san-francisco"),
          title: "Forecast",
          systemName: "cloud.sun",
          onSelect: () => props.onSelect(cityPanel("san-francisco"))
        }
      ),
      /* @__PURE__ */ jsxs(VStack, { id: "truck-weather-chart", alignment: "leading", spacing: 12, frame: { minHeight: 180 }, children: [
        /* @__PURE__ */ jsx(HStack, { id: "truck-weather-bars", spacing: 10, children: visibleEntries.map((entry) => {
          const normalizedHeight = 44 + (entry.degrees - low) / span * 76;
          return /* @__PURE__ */ jsxs(VStack, { id: `truck-weather-bar-${entry.date.toISOString()}`, alignment: "center", spacing: 8, children: [
            /* @__PURE__ */ jsx(
              VStack,
              {
                id: `truck-weather-bar-fill-${entry.date.toISOString()}`,
                background: entry.isDaylight ? "teal" : "indigo",
                cornerRadius: 12,
                frame: { width: 22, height: normalizedHeight }
              }
            ),
            /* @__PURE__ */ jsx(Text, { id: `truck-weather-bar-label-${entry.date.toISOString()}`, font: "caption", foregroundColor: "secondary", children: formatForecastHour(entry.date) }),
            /* @__PURE__ */ jsxs(Text, { id: `truck-weather-bar-value-${entry.date.toISOString()}`, font: "caption", fontWeight: "semibold", children: [
              entry.degrees,
              "\xB0"
            ] })
          ] }, entry.date.toISOString());
        }) }),
        /* @__PURE__ */ jsxs(Text, { id: "truck-weather-summary", font: "footnote", foregroundColor: "secondary", children: [
          low,
          "\xB0F to ",
          high,
          "\xB0F"
        ] })
      ] })
    ] });
  }

  // ../App/Project/src/Truck/TruckView.tsx
  function TruckView(props) {
    return /* @__PURE__ */ jsx(WidthThresholdReader, { id: "truck-width-threshold", widthThreshold: 520, children: (proxy) => /* @__PURE__ */ jsx(TruckContent, { onSelect: props.onSelect, isCompact: proxy.isCompact }) });
  }
  function TruckContent(props) {
    const orders2 = /* @__PURE__ */ jsx(TruckOrdersCard, { onSelect: props.onSelect });
    const weather = /* @__PURE__ */ jsx(TruckWeatherCard, { onSelect: props.onSelect });
    const donuts = /* @__PURE__ */ jsx(TruckDonutsCard, { onSelect: props.onSelect });
    const socialFeed = /* @__PURE__ */ jsx(TruckSocialFeedCard, { onSelect: props.onSelect });
    return /* @__PURE__ */ jsx(ScrollView, { id: "truck-view", navigationTitle: "Truck", background: "systemGroupedBackground", children: /* @__PURE__ */ jsxs(VStack, { id: "truck-stack", spacing: 16, children: [
      /* @__PURE__ */ jsx(BrandHeader, { animated: false }),
      /* @__PURE__ */ jsx(
        Grid,
        {
          id: "truck-grid",
          horizontalSpacing: 12,
          verticalSpacing: 12,
          fixedSize: { horizontal: false, vertical: true },
          padding: 16,
          frame: { maxWidth: 1200 },
          children: props.isCompact ? /* @__PURE__ */ jsxs(Fragment2, { children: [
            orders2,
            weather,
            donuts,
            socialFeed
          ] }) : /* @__PURE__ */ jsxs(Fragment2, { children: [
            /* @__PURE__ */ jsxs(GridRow, { id: "truck-grid-row-1", children: [
              orders2,
              weather
            ] }),
            /* @__PURE__ */ jsxs(GridRow, { id: "truck-grid-row-2", children: [
              donuts,
              socialFeed
            ] })
          ] })
        }
      )
    ] }) });
  }

  // ../App/Project/src/Navigation/DetailColumn.tsx
  function DetailColumn(props) {
    if (props.selection === "truck") {
      return /* @__PURE__ */ jsx(TruckView, { onSelect: props.onSelect });
    }
    if (props.selection === "orders") {
      return /* @__PURE__ */ jsx(OrdersView, {});
    }
    if (props.selection === "socialFeed") {
      return /* @__PURE__ */ jsx(SocialFeedView, {});
    }
    if (props.selection === "salesHistory") {
      return /* @__PURE__ */ jsx(SalesHistoryView, {});
    }
    if (props.selection === "donuts") {
      return /* @__PURE__ */ jsx(DonutGallery, { onSelect: props.onSelect });
    }
    if (props.selection === "donutEditor") {
      return /* @__PURE__ */ jsx(DonutEditor, {});
    }
    if (props.selection === "topFive") {
      return /* @__PURE__ */ jsx(TopFiveDonutsView, {});
    }
    if (props.selection.startsWith("city:")) {
      const city = cities.find((entry) => cityPanel(entry.id) === props.selection) ?? cities[0];
      return /* @__PURE__ */ jsx(CityView, { city });
    }
    return /* @__PURE__ */ jsx(TruckView, { onSelect: props.onSelect });
  }

  // ../App/Project/src/Navigation/Sidebar.tsx
  function Sidebar(props) {
    return /* @__PURE__ */ jsxs(List, { id: "sidebar", navigationTitle: "Food Truck", listStyle: "sidebar", children: [
      /* @__PURE__ */ jsx(
        SidebarRow,
        {
          id: "sidebar-truck",
          title: "Truck",
          systemName: "box.truck",
          selected: props.selection === "truck",
          action: () => props.onSelect("truck")
        }
      ),
      /* @__PURE__ */ jsx(
        SidebarRow,
        {
          id: "sidebar-orders",
          title: "Orders",
          systemName: "shippingbox",
          selected: props.selection === "orders",
          action: () => props.onSelect("orders")
        }
      ),
      /* @__PURE__ */ jsx(
        SidebarRow,
        {
          id: "sidebar-feed",
          title: "Social Feed",
          systemName: "text.bubble",
          selected: props.selection === "socialFeed",
          action: () => props.onSelect("socialFeed")
        }
      ),
      /* @__PURE__ */ jsx(
        SidebarRow,
        {
          id: "sidebar-history",
          title: "Sales History",
          systemName: "clock",
          selected: props.selection === "salesHistory",
          action: () => props.onSelect("salesHistory")
        }
      ),
      /* @__PURE__ */ jsx(Section, { id: "sidebar-donuts", title: "Donuts", children: donutPanels.map((item) => /* @__PURE__ */ jsx(
        SidebarRow,
        {
          id: `sidebar-${item.panel}`,
          title: item.title,
          selected: props.selection === item.panel,
          action: () => props.onSelect(item.panel),
          ...item.icon.includes("/") ? { assetName: item.icon } : { systemName: item.icon }
        },
        item.panel
      )) }),
      /* @__PURE__ */ jsx(Section, { id: "sidebar-cities", title: "Cities", children: cities.map((city) => /* @__PURE__ */ jsx(
        SidebarRow,
        {
          id: `sidebar-${city.id}`,
          title: city.name,
          systemName: "building.2",
          selected: props.selection === cityPanel(city.id),
          action: () => props.onSelect(cityPanel(city.id))
        },
        city.id
      )) })
    ] });
  }
  function SidebarRow(props) {
    return /* @__PURE__ */ jsx(
      Button,
      {
        id: props.id,
        action: props.action,
        buttonStyle: "plain",
        padding: 8,
        background: props.selected ? "tertiarySystemFill" : "clear",
        cornerRadius: 12,
        children: /* @__PURE__ */ jsxs(HStack, { id: `${props.id}-row`, spacing: 10, children: [
          props.assetName ? /* @__PURE__ */ jsx(Image, { id: `${props.id}-asset`, name: props.assetName, frame: { width: 18, height: 18 } }) : /* @__PURE__ */ jsx(Image, { id: `${props.id}-icon`, systemName: props.systemName ?? "circle" }),
          /* @__PURE__ */ jsx(Text, { id: `${props.id}-title`, font: "body", fontWeight: props.selected ? "semibold" : "regular", children: props.title }),
          /* @__PURE__ */ jsx(Spacer, { id: `${props.id}-spacer` })
        ] })
      }
    );
  }

  // ../App/Project/src/Navigation/ContentView.tsx
  function ContentView() {
    const [selection, setSelection] = useState("truck");
    return /* @__PURE__ */ jsx(
      NavigationSplitView,
      {
        id: "food-truck-root",
        sidebar: /* @__PURE__ */ jsx(Sidebar, { selection, onSelect: setSelection }),
        detail: /* @__PURE__ */ jsx(DetailColumn, { selection, onSelect: setSelection })
      }
    );
  }

  // ../App/Project/src/main.tsx
  mount(ContentView);
})();
//# sourceMappingURL=food-truck.bundle.js.map
