# Document Work TODO

## Goal

Make `SwiftJS` capable of building document-heavy iPhone flows close to the SwiftUI SDK guidance while keeping:

- reusable primitives in `Sources/SwiftJS`
- app-specific document UI and behavior outside the core framework

## Current State

Supported enough for:

- browse lists and grouped forms
- pushed destinations with destination views
- value and path-based navigation
- sheets and full-screen covers
- basic toolbars
- search, search suggestions, and search scopes
- selection and edit mode
- swipe actions and context menus
- share links and external links
- custom section headers and footers
- buttons, menus, pickers, toggles
- generic empty states

No remaining framework blockers identified for document-heavy iPhone flows.

API-faithfulness cleanup remains before this surface should be considered settled.

## Component Pattern Docs API Gaps

- [x] `Picker`: support SwiftUI-shaped child options using tagged `Text`/`Label` rows, while keeping the serializable options form.
- [x] `List` and `ForEach`: support data-driven builders so docs can stay close to `List(items) { ... }` and `ForEach(items) { ... }`.
- [x] `Toolbar`: expose `ToolbarItem`, `ToolbarItemGroup`, and `ToolbarSpacer` helpers instead of requiring raw object literals.
- [x] Search: support `searchable(..., isPresented:)`.
- [x] Search: add search submit; use the existing `isPresented` binding for active/dismiss state.
- [x] Presentations: support item-driven `Sheet` and `FullScreenCover` content builders.
- [x] Liquid Glass: add `buttonSizing`.
- [x] Liquid Glass: expand `glassEffect` with shape/interactive/container/id/union APIs and `scrollEdgeEffectStyle`.
- [x] Web: expand `WebView` beyond `url` before converting the WebView docs.
- [x] Media/maps/charts: add `Map`, `Chart`, and `VideoPlayer`.
- [x] Image: add `AsyncImage` empty/failure phase slots and SwiftUI-shaped clipping names.
- [x] Accessibility: add hint, value, and content-shape coverage used by the docs.
- [x] Accessibility: add traits coverage used by the docs.
- [x] Typography: add line spacing.
- [x] Typography: express formatted/concatenated text as `Text` segments in TSX.
- [x] Color/materials: add `systemBackground`, material shape styles, and `tint` foreground style support.
- [x] Text input: add text content type coverage for email/password/code flows.
- [x] Edit/list actions: add delete actions and improve edit-mode ergonomics where docs need them.
- [x] Haptics: add conditional and parameterized sensory feedback.

## SwiftUI SDK Coverage

- [x] Add typed `Tab` search role
- [x] Add `Slider`, `Stepper`, and `GroupBox`
- [x] Add `AsyncImage`
- [x] Add tab chrome APIs
- [x] Add toolbar groups, spacers, and generic `badge`
- [x] Add `sensoryFeedback`

Deferred follow-up only if a concrete screen proves the default native picker presentation is insufficient:

- forced `.inline` picker style override

## P0 Core

- [x] Export a generic `Custom` TSX primitive so app targets can add native document-specific behavior without putting it in core
- [x] Add `TextField`
- [x] Add `SecureField`
- [x] Add `TextEditor`
- [x] Add `searchable(text:prompt:)`
- [x] Add `ContentUnavailableView.search(text:)`
- [x] Add `List(selection:)`
- [x] Add edit-mode state support
- [x] Add `EditButton`
- [x] Add `swipeActions`
- [x] Add `contextMenu`
- [x] Add `ShareLink`
- [x] Add `Link`
- [x] Add accessibility label support for icon-only `Button`, `Menu`, toolbar items, and similar controls

## P1 Core

- [x] Add `NavigationStack(path:)`
- [x] Add `NavigationLink(value:)`
- [x] Add `navigationDestination`
- [x] Extend `Section` with custom `header`
- [x] Extend `Section` with `footer`
- [x] Add button roles, especially destructive and cancel semantics
- [x] Add `toolbarRole`
- [x] Add search toolbar behavior APIs
- [x] Add search suggestions
- [x] Add search scopes
- [x] Add search completions
- [x] Add `ProgressView`
- [x] Add `WebView`
- [x] Add tab role support for search tabs

## P2 Core

- [x] Add `DatePicker`
- [x] Add reorder support
- [x] Add move support for editable lists
- [x] Add drag and drop primitives
- [x] Evaluate minimal picker-style overrides after the higher-priority document work lands

## API Fidelity Cleanup

- [x] Move reordering off `List` and `Section` container props toward a more SwiftUI-like repeatable row API
- [x] Make `List(selection:)` set-like rather than ordered-array shaped
- [x] Rename `searchToolbarBehavior="minimize"` to SwiftUI-faithful `searchToolbarBehavior="minimized"`
- [x] Expand the text-input subset with high-value SwiftUI controls: keyboard type, text input autocapitalization, autocorrection disabling, submit label, and submit handling
- [x] Reduce and document the `dropDestination` subset explicitly where true SwiftUI accept/reject parity is not possible
- [x] Clarify `WebView` as a SwiftJS-specific primitive rather than SwiftUI-parity surface

## App-Level Follow-Up

These should stay out of core unless they become clearly reusable primitives:

- [ ] Document row compositions
- [ ] Document browser screens
- [ ] Rename flows
- [ ] Move flows
- [ ] Export flows
- [ ] Search start-state UI
- [ ] Document preview chrome
- [ ] App-specific file metadata rendering

## Recommended Order

1. `Custom`
2. text input
3. search
4. selection and edit mode
5. swipe actions and context menus
6. share and links
7. value/path navigation
8. richer sections
9. web, date, reorder, drag and drop
10. minimal picker-style overrides if still needed
11. API-faithfulness cleanup

## Notes

- Prefer fixing missing framework primitives instead of bending sample apps around framework gaps.
- Keep document-specific native behavior behind the extension mechanism when it is not a general-purpose `SwiftJS` primitive.
- Match SwiftUI semantics where practical, especially for navigation, search, list editing, destructive actions, and toolbar behavior.
- Keep `Picker` generic by default. Use existing `Menu` composition for compact menu pickers, existing navigation primitives for selection screens, and revisit forced `.inline` only if a real document flow requires it.
