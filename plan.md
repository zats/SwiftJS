# Food Truck SwiftJS Port Plan

## Goal

Recreate the **iPhone** experience of Apple's Food Truck sample as a separate SwiftJS sample app, with:

- all screen logic, state, data shaping, filtering, sorting, navigation decisions, and feature behavior written in JavaScript/TypeScript
- Swift limited to the host runtime, native view bindings, asset loading, and sample-app bootstrapping
- the sample app kept separate from the core `SwiftJS` library so library work and sample-app work do not get mixed together

## Product Decisions

- Target **iPhone only** for the first port.
- Keep the new sample in `Examples/` as its own app target and JS project.
- Port the app's real screens and flows first.
- Use local bundled data in JS for anything that currently depends on Apple services.
- For components that are unusually expensive for a first pass, keep the screen present and insert a visible placeholder or simpler approximation.
- Track every deferred feature in `to-dos.md`.

## What Counts As In Scope

- Truck dashboard
- Orders list
- Order detail
- Order completion flow
- Social feed
- Sales history screen
- Donut gallery
- Donut editor
- Top 5 donuts screen
- City detail screen
- local asset loading for donut art and branded imagery
- JS-owned sample data and derived view state

## What Swift Owns

- the SwiftUI host app shell for the sample
- the JS runtime bridge
- decoding JS view trees into native SwiftUI nodes
- native bindings for new SwiftUI components and modifiers
- loading bundled local assets by name
- any temporary placeholder views for deferred native features

## What JavaScript Owns

- app state
- seeded sample data and static fixtures
- derived collections and filters
- search and sort behavior
- order status transitions
- screen-to-screen navigation intent
- donut editing state
- placeholder-state decisions for deferred features

## Planned Repository Shape

1. Add a new sample app under `Examples/FoodTruckApp`.
2. Add a paired JS workspace under `Examples/FoodTruckAppJS`.
3. Keep `Sources/SwiftJS` focused on reusable bindings and runtime support.
4. Keep Food Truck-specific models, fixtures, assets, and JS screens inside the new example.
5. Avoid adding Food Truck-specific logic to the core library.

## Workstreams

### 1. Sample App Scaffolding

- create a new iOS example target separate from `CounterApp`
- copy the original Food Truck assets that are useful on iPhone
- set up a dedicated JS bundle build step for the Food Truck sample
- add a sample-specific workspace helper similar to the counter sample, if needed

### 2. JS Data Port

- port `City`, `ParkingSpot`, `Donut`, `Order`, `OrderSummary`, and seeded order generation into TypeScript
- port the social feed content into TypeScript
- generate derived chart data in JavaScript
- use static weather and attribution fixtures in JavaScript for the first pass

### 3. Core SwiftJS Binding Expansion

Add the minimum native surface needed for Food Truck on iPhone:

- layout: `ZStack`, `Spacer`, `ScrollView`, `List`, `Section`, grid-style layout support, lazy grid support if needed
- navigation: `NavigationStack`, `NavigationLink`, pushed destinations, title handling, toolbar items, modal sheets
- content: asset-backed `Image`, richer `Text`, `Label`, badges
- input: `TextField`, `Picker`, segmented picker mode, menu-style actions
- styling: overlays, strokes, shadows, gradients, opacity, clipping, aspect ratio, frame alignment, line limits, multiline alignment
- list polish: section headers, row backgrounds, row insets, grouped/inset grouped styling where practical
- async or lifecycle hooks already started by `onAppear`, plus any missing task-style behavior needed for sample data loading

### 4. App Shell And Navigation

- implement an iPhone root shell in JS
- replace the original split-view sidebar structure with an iPhone-first navigation stack flow
- create a dashboard entry screen that links to all major sections
- preserve deep enough navigation to match the original iPhone experience

### 5. Screen Port Order

Build in this order:

1. Truck dashboard
2. Orders list and order detail
3. Donut gallery
4. Donut editor
5. Social feed
6. Sales history
7. Top 5 donuts
8. City detail
9. order completion modal and remaining polish

This order gives an early working app and surfaces the most important missing bindings first.

### 6. Visual Fidelity Strategy

- keep the overall information architecture and visual hierarchy close to Apple's sample
- use real bundled image assets for donuts and branding
- preserve card-based dashboard layout
- preserve the donut-composition visuals by stacking local asset images in JS
- accept simpler animation where parity is expensive and not central to app comprehension

## Screen-Level Plan

### Truck Dashboard

Implement:

- branded header
- four-card landing layout
- links into Orders, Forecast or City, Donuts, and Social Feed
- recent orders summary
- trending topics summary

First-pass simplifications:

- use a static branded header image treatment instead of porting `Canvas` and `TimelineView` immediately
- use a simplified forecast card visual instead of a full native chart if chart bindings are not ready yet

### Orders

Implement:

- grouped list by status
- search
- order row visuals with donut thumbnails
- order detail page
- status progression action
- completion sheet

Skip for first pass:

- iPad and macOS table mode
- multi-selection editing mode
- Live Activity integration
- local notification scheduling

### Donut Gallery

Implement:

- searchable donut gallery
- grid presentation
- navigation into editor
- create-new flow
- JS-driven sorting controls

Skip for first pass:

- native table layout variant
- browser-role toolbar parity if it adds host complexity without UI value on iPhone

### Donut Editor

Implement:

- live donut preview built from local layered assets
- name editing
- dough, glaze, and topping pickers
- flavor summary presentation

Acceptable simplification:

- use a simpler flavor summary UI before building native `Gauge` support

### Social Feed

Implement:

- list of posts
- tag chips
- plus-marketing card as normal app content

Skip for first pass:

- StoreKit paywall
- subscription management flows
- premium entitlement logic

### Sales History

Implement:

- timeframe switching
- totals summary
- chart area reserved in the layout

First-pass simplification:

- replace the native Charts implementation with a simpler custom visual or an explicit chart placeholder if chart bindings are not ready
- keep locked premium messaging as static UI only

### Top 5 Donuts

Implement:

- timeframe picker
- ranked top-donuts content

First-pass simplification:

- use a ranked list or simple bars before adding native Charts support

Skip for first pass:

- App Intents and Siri tip content

### City Detail

Implement:

- city title and supporting weather copy
- recommended parking spot card
- supporting informational cards

First-pass simplification:

- replace the animated 3D map with a visible placeholder or static hero treatment
- use bundled fixture weather data instead of WeatherKit
- keep attribution UI only if it still makes sense with bundled fixtures

## Opinionated Skips For The First Port

- widgets
- Live Activities
- Dynamic Island
- App Intents
- Siri tips
- StoreKit purchasing and refund flows
- account creation and passkeys
- WeatherKit live data
- MapKit 3D animated map camera
- iPad and macOS layouts
- Canvas or Timeline-driven header animation if a static version achieves the same UI structure
- custom `Table` support

## Placeholders We Should Show Instead Of Hiding Screens

- City map region
- advanced chart regions
- premium-only store surfaces
- Live Activity related affordances

Placeholders should be visually obvious and framed as temporary implementation gaps, not blank space.

## Verification Plan

- keep the new sample buildable independently from the counter sample
- run an Xcode build for the sample after each meaningful Swift binding batch
- verify the JS bundle step is deterministic
- smoke-test navigation through every screen on iPhone simulator
- verify local assets resolve from the JS surface
- verify the core library remains generic and sample-agnostic

## Commit Strategy

- commit after scaffold setup
- commit after each major binding batch
- commit after each major screen batch
- keep commits scoped so sample-app work stays separate from unrelated local changes

## Exit Criteria For The First Major Pass

- the app launches into a recognizable iPhone Food Truck experience
- every primary iPhone screen exists and is navigable
- all business logic lives in JavaScript
- local assets load correctly
- deferred native or platform features are represented in `to-dos.md`
- the core `SwiftJS` library remains reusable and not Food Truck-specific
