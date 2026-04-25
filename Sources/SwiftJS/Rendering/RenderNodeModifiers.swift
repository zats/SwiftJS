import Foundation
import JavaScriptCore
import Observation
import SwiftUI
import UniformTypeIdentifiers
import UIKit
import WebKit
import SwiftJSCore

struct TabItemLabelModifier: ViewModifier {
    let title: String
    let source: ImageSource?

    @ViewBuilder
    func body(content: Content) -> some View {
        switch source {
        case let .system(systemName):
            content.tabItem { Label(title, systemImage: systemName) }
        case let .asset(name):
            content.tabItem {
                Label {
                    Text(title)
                } icon: {
                    Image(name)
                }
            }
        case nil:
            content.tabItem { Text(title) }
        }
    }
}

struct TabBadgeModifier: ViewModifier {
    let badge: BadgeValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        switch badge {
        case let .string(value):
            content.badge(value)
        case let .number(value):
            content.badge(Int(value))
        case nil:
            content
        }
    }
}

struct TabTagModifier: ViewModifier {
    let selection: PickerSelectionValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let selection {
            content.tag(selection)
        } else {
            content
        }
    }
}

extension TabRoleKind {
    var swiftUIRole: TabRole {
        switch self {
        case .search:
            .search
        }
    }
}

@MainActor
@ViewBuilder
func roleTabView<TabItem: TabContent>(_ tabItem: TabItem, badge: BadgeValue?) -> some View {
    switch badge {
    case let .string(value):
        tabItem.badge(Text(verbatim: value))._identifiedView
    case let .number(value):
        tabItem.badge(Int(value))._identifiedView
    case nil:
        tabItem._identifiedView
    }
}

struct NodeAppearanceModifier: ViewModifier {
    let modifiers: ViewModifiers

    func body(content: Content) -> some View {
        content
            .font(modifiers.swiftUIFont)
            .fontWeight(modifiers.swiftUIFontWeight)
            .symbolRenderingMode(modifiers.swiftUISymbolRenderingMode)
            .lineLimit(modifiers.lineLimit)
            .minimumScaleFactor(CGFloat(modifiers.minimumScaleFactor ?? 1))
            .modifier(NodeForegroundModifier(shapeStyle: modifiers.foregroundShapeStyle, color: modifiers.swiftUIColor))
            .modifier(NodeMultilineTextAlignmentModifier(alignment: modifiers.swiftUITextAlignment))
            .truncationMode(modifiers.swiftUITruncationMode ?? .tail)
    }
}

struct CommonNodeModifier: ViewModifier {
    let modifiers: ViewModifiers
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    func body(content: Content) -> some View {
        let minWidth = modifiers.frameMinWidth.map { CGFloat($0) }
        let minHeight = modifiers.frameMinHeight.map { CGFloat($0) }
        let width = modifiers.frameWidth.map { CGFloat($0) }
        let height = modifiers.frameHeight.map { CGFloat($0) }
        let maxWidth = modifiers.frameMaxWidth ? CGFloat.infinity : modifiers.frameMaxWidthValue.map { CGFloat($0) }
        let maxHeight = modifiers.frameMaxHeight ? CGFloat.infinity : modifiers.frameMaxHeightValue.map { CGFloat($0) }
        let aspectRatio = modifiers.aspectRatio.map { CGFloat($0) }

        return content
            .padding(modifiers.padding ?? 0)
            .padding(.top, modifiers.paddingTop ?? 0)
            .fixedSize(horizontal: modifiers.fixedSizeHorizontal, vertical: modifiers.fixedSizeVertical)
            .modifier(OptionalAspectRatioModifier(aspectRatio: aspectRatio, contentMode: modifiers.swiftUIAspectRatioContentMode))
            .frame(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight, alignment: modifiers.swiftUIAlignment)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: modifiers.swiftUIAlignment)
            .frame(width: width, height: height, alignment: modifiers.swiftUIAlignment)
            .modifier(OptionalSafeAreaPaddingModifier(length: modifiers.safeAreaPaddingLength, edges: modifiers.safeAreaPaddingEdges.swiftUIEdgeSet))
            .modifier(OptionalIgnoresSafeAreaModifier(isEnabled: modifiers.ignoresSafeArea, edges: modifiers.ignoresSafeAreaEdges.swiftUIEdgeSet))
            .modifier(OptionalBackgroundModifier(style: modifiers.backgroundShapeStyle))
            .modifier(OptionalClipModifier(cornerRadius: modifiers.cornerRadius, imageContentMode: modifiers.imageContentMode))
            .modifier(OptionalGlassEffectModifier(modifiers: modifiers))
            .modifier(OptionalTintModifier(tint: modifiers.tint.flatMap(Color.named(_:))))
            .modifier(OptionalBadgeModifier(badge: modifiers.badge))
            .modifier(OptionalNavigationTitleModifier(title: modifiers.navigationTitle))
            .modifier(OptionalNavigationBarTitleDisplayModeModifier(mode: modifiers.swiftUINavigationBarTitleDisplayMode))
            .modifier(OptionalTabBarMinimizeBehaviorModifier(modifiers: modifiers))
            .modifier(OptionalTabViewBottomAccessoryModifier(accessory: modifiers.tabViewBottomAccessory, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalToolbarRoleModifier(role: modifiers.swiftUIToolbarRole))
            .modifier(OptionalSearchPresentationToolbarBehaviorModifier(behavior: modifiers.swiftUISearchPresentationToolbarBehavior))
            .modifier(OptionalSearchToolbarBehaviorModifier(behavior: modifiers.searchToolbarBehavior))
            .modifier(OptionalToolbarBackgroundModifier(visibility: modifiers.swiftUIToolbarBackgroundVisibility))
            .modifier(OptionalToolbarColorSchemeModifier(scheme: modifiers.swiftUIColorScheme))
            .modifier(OptionalKeyboardTypeModifier(keyboardType: modifiers.keyboardType))
            .modifier(OptionalTextInputAutocapitalizationModifier(autocapitalization: modifiers.textInputAutocapitalization))
            .modifier(OptionalAutocorrectionDisabledModifier(isDisabled: modifiers.autocorrectionDisabled))
            .modifier(OptionalSubmitLabelModifier(submitLabel: modifiers.submitLabel))
            .modifier(OptionalOnSubmitModifier(event: modifiers.submitEvent, onEvent: onEvent))
            .modifier(OptionalSensoryFeedbackModifier(value: modifiers.sensoryFeedback))
            .modifier(OptionalScrollContentBackgroundModifier(visibility: modifiers.swiftUIScrollContentBackgroundVisibility))
            .modifier(OptionalListRowSeparatorModifier(visibility: modifiers.swiftUIListRowSeparatorVisibility))
            .modifier(OptionalListSectionSeparatorModifier(visibility: modifiers.swiftUIListSectionSeparatorVisibility))
            .modifier(OptionalListRowInsetsModifier(insets: modifiers.listRowInsets?.swiftUIEdgeInsets))
            .modifier(OptionalListRowBackgroundModifier(background: modifiers.listRowBackground?.swiftUIShapeStyle))
            .modifier(OptionalDraggableModifier(draggable: modifiers.draggable))
            .modifier(OptionalDropDestinationModifier(dropDestination: modifiers.dropDestination, onEvent: onEvent))
            .modifier(OptionalSwipeActionsModifier(swipeActions: modifiers.swipeActions, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(ContentMarginsModifier(margins: modifiers.contentMargins))
            .modifier(SafeAreaInsetsModifier(insets: modifiers.safeAreaInsets, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalNavigationLinkIndicatorModifier(visibility: modifiers.swiftUINavigationLinkIndicatorVisibility))
            .modifier(ToolbarItemsModifier(items: modifiers.toolbarItems, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalAlertModifier(alert: modifiers.alert, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalConfirmationDialogModifier(dialog: modifiers.confirmationDialog, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalContextMenuModifier(contextMenu: modifiers.contextMenu, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalAccessibilityLabelModifier(label: modifiers.accessibilityLabel))
            .modifier(OptionalTagModifier(tag: modifiers.tag))
            .modifier(OptionalSearchCompletionModifier(completion: modifiers.searchCompletion))
            .modifier(OptionalEditModeModifier(editMode: modifiers.editMode, event: modifiers.editModeEvent, onEvent: onEvent))
            .modifier(OptionalIdentityModifier(viewIdentity: modifiers.viewIdentity))
            .modifier(OptionalOnAppearModifier(event: modifiers.onAppearEvent, onEvent: onEvent))
            .moveDisabled(modifiers.moveDisabled)
    }
}

struct OptionalBadgeModifier: ViewModifier {
    let badge: BadgeValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        switch badge {
        case let .string(value):
            content.badge(value)
        case let .number(value):
            content.badge(Int(value))
        case nil:
            content
        }
    }
}

struct OptionalTabBarMinimizeBehaviorModifier: ViewModifier {
    let modifiers: ViewModifiers

    @ViewBuilder
    func body(content: Content) -> some View {
        if let behavior = modifiers.swiftUITabBarMinimizeBehavior {
            content.tabBarMinimizeBehavior(behavior)
        } else {
            content
        }
    }
}

struct OptionalTabViewBottomAccessoryModifier: ViewModifier {
    let accessory: TabViewBottomAccessoryValue?
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let accessory {
            content.tabViewBottomAccessory(isEnabled: accessory.isEnabled) {
                RenderNodeView(node: accessory.content, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        } else {
            content
        }
    }
}

struct OptionalAccessibilityLabelModifier: ViewModifier {
    let label: String?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let label, !label.isEmpty {
            content.accessibilityLabel(Text(label))
        } else {
            content
        }
    }
}

struct OptionalTagModifier: ViewModifier {
    let tag: PickerSelectionValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let tag {
            content.tag(tag)
        } else {
            content
        }
    }
}

struct OptionalEditModeModifier: ViewModifier {
    let editMode: EditModeKind?
    let event: SurfaceEvent?
    let onEvent: (SurfaceEvent) -> Void

    @ViewBuilder
    func body(content: Content) -> some View {
        if let editMode {
            if let event {
                content.environment(
                    \.editMode,
                    Binding(
                        get: { editMode.swiftUIEditMode },
                        set: { nextValue in
                            onEvent(SurfaceEvent(event.name, payloadJSON: nextValue.swiftJSEditMode.rawValue.payloadJSON))
                        }
                    )
                )
            } else {
                content.environment(\.editMode, .constant(editMode.swiftUIEditMode))
            }
        } else {
            content
        }
    }
}

struct NodeForegroundModifier: ViewModifier {
    let shapeStyle: AnyShapeStyle?
    let color: Color?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let shapeStyle {
            content.foregroundStyle(shapeStyle)
        } else if let color {
            content.foregroundStyle(color)
        } else {
            content
        }
    }
}

struct NodeMultilineTextAlignmentModifier: ViewModifier {
    let alignment: TextAlignment?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let alignment {
            content.multilineTextAlignment(alignment)
        } else {
            content
        }
    }
}

struct OptionalAspectRatioModifier: ViewModifier {
    let aspectRatio: CGFloat?
    let contentMode: ContentMode

    @ViewBuilder
    func body(content: Content) -> some View {
        if let aspectRatio {
            content.aspectRatio(aspectRatio, contentMode: contentMode)
        } else {
            content
        }
    }
}

struct OptionalSafeAreaPaddingModifier: ViewModifier {
    let length: Double?
    let edges: Edge.Set

    @ViewBuilder
    func body(content: Content) -> some View {
        if let length {
            content.safeAreaPadding(edges, length)
        } else {
            content
        }
    }
}

struct OptionalIgnoresSafeAreaModifier: ViewModifier {
    let isEnabled: Bool
    let edges: Edge.Set

    @ViewBuilder
    func body(content: Content) -> some View {
        if isEnabled {
            content.ignoresSafeArea(edges: edges)
        } else {
            content
        }
    }
}

struct OptionalBackgroundModifier: ViewModifier {
    let style: AnyShapeStyle?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let style {
            content.background {
                Rectangle().fill(style)
            }
        } else {
            content
        }
    }
}

struct OptionalClipModifier: ViewModifier {
    let cornerRadius: Double?
    let imageContentMode: ImageContentMode?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let cornerRadius {
            content.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else if imageContentMode == .fill {
            content.clipped()
        } else {
            content
        }
    }
}

struct OptionalGlassEffectModifier: ViewModifier {
    let modifiers: ViewModifiers

    @ViewBuilder
    func body(content: Content) -> some View {
        if modifiers.glassEffect && !modifiers.usesGlassButtonStyle {
            content.glassEffect(glassValue(for: modifiers))
        } else {
            content
        }
    }
}

struct OptionalTintModifier: ViewModifier {
    let tint: Color?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let tint {
            content.tint(tint)
        } else {
            content
        }
    }
}

struct OptionalNavigationTitleModifier: ViewModifier {
    let title: String?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let title {
            content.navigationTitle(title)
        } else {
            content
        }
    }
}

struct OptionalNavigationBarTitleDisplayModeModifier: ViewModifier {
    let mode: NavigationBarItem.TitleDisplayMode?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let mode {
            content.navigationBarTitleDisplayMode(mode)
        } else {
            content
        }
    }
}

struct OptionalNavigationLinkIndicatorModifier: ViewModifier {
    let visibility: Visibility?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let visibility {
            content.navigationLinkIndicatorVisibility(visibility)
        } else {
            content
        }
    }
}

struct OptionalPickerStyleModifier: ViewModifier {
    let style: PickerStyleKind?

    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .inline:
            content.pickerStyle(.inline)
        case .menu:
            content.pickerStyle(.menu)
        case .segmented:
            content.pickerStyle(.segmented)
        case nil:
            content
        }
    }
}

struct OptionalKeyboardTypeModifier: ViewModifier {
    let keyboardType: KeyboardTypeKind?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let keyboardType {
            content.keyboardType(keyboardType.swiftUIKeyboardType)
        } else {
            content
        }
    }
}

struct OptionalTextInputAutocapitalizationModifier: ViewModifier {
    let autocapitalization: TextInputAutocapitalizationKind?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let autocapitalization {
            content.textInputAutocapitalization(autocapitalization.swiftUITextInputAutocapitalization)
        } else {
            content
        }
    }
}

struct OptionalAutocorrectionDisabledModifier: ViewModifier {
    let isDisabled: Bool?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let isDisabled {
            content.autocorrectionDisabled(isDisabled)
        } else {
            content
        }
    }
}

struct OptionalSubmitLabelModifier: ViewModifier {
    let submitLabel: SubmitLabelKind?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let submitLabel {
            content.submitLabel(submitLabel.swiftUISubmitLabel)
        } else {
            content
        }
    }
}

struct OptionalOnSubmitModifier: ViewModifier {
    let event: SurfaceEvent?
    let onEvent: (SurfaceEvent) -> Void

    @ViewBuilder
    func body(content: Content) -> some View {
        if let event {
            content.onSubmit {
                onEvent(event)
            }
        } else {
            content
        }
    }
}

struct OptionalSensoryFeedbackModifier: ViewModifier {
    let value: SensoryFeedbackValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let value {
            content.sensoryFeedback(value.feedback.swiftUISensoryFeedback, trigger: value.trigger)
        } else {
            content
        }
    }
}

struct OptionalSearchableModifier: ViewModifier {
    let searchable: SearchableValue?
    let onEvent: (SurfaceEvent) -> Void

    @ViewBuilder
    func body(content: Content) -> some View {
        if let searchable {
            content.searchable(
                text: Binding(
                    get: { searchable.text },
                    set: { nextValue in
                        onEvent(SurfaceEvent(searchable.event.name, payloadJSON: nextValue.payloadJSON))
                    }
                ),
                placement: searchable.placement.swiftUISearchFieldPlacement,
                prompt: searchable.prompt.map(Text.init)
            )
        } else {
            content
        }
    }
}

struct OptionalSearchSuggestionsModifier: ViewModifier {
    let suggestions: SearchSuggestionsValue?
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let suggestions {
            content.searchSuggestions {
                ForEach(suggestions.content) { node in
                    RenderNodeView(node: node, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        } else {
            content
        }
    }
}

struct OptionalSearchScopesModifier: ViewModifier {
    let searchScopes: SearchScopesValue?
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let searchScopes {
            content.searchScopes(
                Binding(
                    get: { searchScopes.selection },
                    set: { nextValue in
                        onEvent(SurfaceEvent(searchScopes.event.name, payloadJSON: nextValue.payloadJSON))
                    }
                )
            ) {
                ForEach(searchScopes.content) { node in
                    RenderNodeView(node: node, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        } else {
            content
        }
    }
}

struct OptionalSearchCompletionModifier: ViewModifier {
    let completion: String?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let completion {
            content.searchCompletion(completion)
        } else {
            content
        }
    }
}

struct OptionalToolbarRoleModifier: ViewModifier {
    let role: ToolbarRole?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let role {
            content.toolbarRole(role)
        } else {
            content
        }
    }
}

struct OptionalSearchPresentationToolbarBehaviorModifier: ViewModifier {
    let behavior: SearchPresentationToolbarBehaviorKind?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let behavior {
            content.searchPresentationToolbarBehavior(behavior.swiftUISearchPresentationToolbarBehavior)
        } else {
            content
        }
    }
}

struct OptionalSearchToolbarBehaviorModifier: ViewModifier {
    let behavior: SearchToolbarBehaviorKind?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let behavior {
            content.searchToolbarBehavior(behavior.swiftUISearchToolbarBehavior)
        } else {
            content
        }
    }
}

struct OptionalIdentityModifier: ViewModifier {
    let viewIdentity: CustomHostValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let viewIdentity {
            switch viewIdentity {
            case let .string(value):
                content.id(value)
            case let .number(value):
                content.id(value)
            case let .bool(value):
                content.id(value)
            case .array, .object:
                content
            }
        } else {
            content
        }
    }
}

struct OptionalToolbarBackgroundModifier: ViewModifier {
    let visibility: Visibility?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let visibility {
            content.toolbarBackground(visibility, for: .navigationBar, .tabBar, .bottomBar)
        } else {
            content
        }
    }
}

struct OptionalToolbarColorSchemeModifier: ViewModifier {
    let scheme: ColorScheme?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let scheme {
            content.toolbarColorScheme(scheme, for: .navigationBar, .tabBar, .bottomBar)
        } else {
            content
        }
    }
}

struct OptionalScrollContentBackgroundModifier: ViewModifier {
    let visibility: Visibility?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let visibility {
            content.scrollContentBackground(visibility)
        } else {
            content
        }
    }
}

struct OptionalListRowSeparatorModifier: ViewModifier {
    let visibility: Visibility?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let visibility {
            content.listRowSeparator(visibility)
        } else {
            content
        }
    }
}

struct OptionalListSectionSeparatorModifier: ViewModifier {
    let visibility: Visibility?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let visibility {
            content.listSectionSeparator(visibility)
        } else {
            content
        }
    }
}

struct OptionalListRowInsetsModifier: ViewModifier {
    let insets: EdgeInsets?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let insets {
            content.listRowInsets(insets)
        } else {
            content
        }
    }
}

struct OptionalListRowBackgroundModifier: ViewModifier {
    let background: AnyShapeStyle?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let background {
            content.listRowBackground(Rectangle().fill(background))
        } else {
            content
        }
    }
}

struct ContentMarginsModifier: ViewModifier {
    let margins: [ContentMarginsValue]

    func body(content: Content) -> some View {
        content
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .all, placement: .automatic), edges: .all, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .horizontal, placement: .automatic), edges: .horizontal, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .vertical, placement: .automatic), edges: .vertical, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .top, placement: .automatic), edges: .top, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .bottom, placement: .automatic), edges: .bottom, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .leading, placement: .automatic), edges: .leading, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .trailing, placement: .automatic), edges: .trailing, placement: .automatic))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .all, placement: .scrollContent), edges: .all, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .horizontal, placement: .scrollContent), edges: .horizontal, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .vertical, placement: .scrollContent), edges: .vertical, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .top, placement: .scrollContent), edges: .top, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .bottom, placement: .scrollContent), edges: .bottom, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .leading, placement: .scrollContent), edges: .leading, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .trailing, placement: .scrollContent), edges: .trailing, placement: .scrollContent))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .all, placement: .scrollIndicators), edges: .all, placement: .scrollIndicators))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .horizontal, placement: .scrollIndicators), edges: .horizontal, placement: .scrollIndicators))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .vertical, placement: .scrollIndicators), edges: .vertical, placement: .scrollIndicators))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .top, placement: .scrollIndicators), edges: .top, placement: .scrollIndicators))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .bottom, placement: .scrollIndicators), edges: .bottom, placement: .scrollIndicators))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .leading, placement: .scrollIndicators), edges: .leading, placement: .scrollIndicators))
            .modifier(ContentMarginsEntryModifier(amount: amount(for: .trailing, placement: .scrollIndicators), edges: .trailing, placement: .scrollIndicators))
    }

    private func amount(for edges: EdgeSetKind, placement: ContentMarginPlacementKind) -> Double? {
        margins.last(where: { $0.edges == edges && $0.placement == placement })?.amount
    }
}

struct ContentMarginsEntryModifier: ViewModifier {
    let amount: Double?
    let edges: Edge.Set
    let placement: ContentMarginPlacement

    @ViewBuilder
    func body(content: Content) -> some View {
        if let amount {
            content.contentMargins(edges, amount, for: placement)
        } else {
            content
        }
    }
}

struct SafeAreaInsetsModifier: ViewModifier {
    let insets: [SafeAreaInsetValue]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    func body(content: Content) -> some View {
        content
            .modifier(SafeAreaInsetEdgeModifier(edge: .top, insets: entries(for: .top), onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(SafeAreaInsetEdgeModifier(edge: .bottom, insets: entries(for: .bottom), onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(SafeAreaInsetEdgeModifier(edge: .leading, insets: entries(for: .leading), onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(SafeAreaInsetEdgeModifier(edge: .trailing, insets: entries(for: .trailing), onEvent: onEvent, customHostRegistry: customHostRegistry))
    }

    private func entries(for edge: EdgeKind) -> [SafeAreaInsetValue] {
        insets.filter { $0.edge == edge }
    }
}

struct SafeAreaInsetEdgeModifier: ViewModifier {
    let edge: EdgeKind
    let insets: [SafeAreaInsetValue]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if insets.isEmpty {
            content
        } else {
            switch edge {
            case .top:
                content.safeAreaInset(edge: .top, spacing: insets.last?.spacing.map { CGFloat($0) }) {
                    SafeAreaInsetGroupContent(edge: edge, insets: insets, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            case .bottom:
                content.safeAreaInset(edge: .bottom, spacing: insets.last?.spacing.map { CGFloat($0) }) {
                    SafeAreaInsetGroupContent(edge: edge, insets: insets, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            case .leading:
                content.safeAreaInset(edge: .leading, spacing: insets.last?.spacing.map { CGFloat($0) }) {
                    SafeAreaInsetGroupContent(edge: edge, insets: insets, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            case .trailing:
                content.safeAreaInset(edge: .trailing, spacing: insets.last?.spacing.map { CGFloat($0) }) {
                    SafeAreaInsetGroupContent(edge: edge, insets: insets, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
    }
}

struct SafeAreaInsetGroupContent: View {
    let edge: EdgeKind
    let insets: [SafeAreaInsetValue]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    var body: some View {
        if edge == .top || edge == .bottom {
            VStack(spacing: 0) {
                renderedInsets
            }
        } else {
            HStack(spacing: 0) {
                renderedInsets
            }
        }
    }

    @ViewBuilder
    private var renderedInsets: some View {
        ForEach(Array(insets.enumerated()), id: \.offset) { entry in
            RenderNodeView(node: entry.element.content, onEvent: onEvent, customHostRegistry: customHostRegistry)
        }
    }
}

struct ToolbarItemsModifier: ViewModifier {
    let items: [ToolbarItemValue]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if items.isEmpty {
            content
        } else {
            content.toolbar {
                toolbarGroup(for: .automatic)
                toolbarGroup(for: .principal)
                toolbarGroup(for: .topBarLeading)
                toolbarGroup(for: .topBarTrailing)
                toolbarGroup(for: .bottomBar)
                toolbarGroup(for: .status)
                toolbarGroup(for: .cancellationAction)
                toolbarGroup(for: .confirmationAction)
                toolbarGroup(for: .primaryAction)
            }
        }
    }

    @ToolbarContentBuilder
    private func toolbarGroup(for placement: ToolbarItemPlacementKind) -> some ToolbarContent {
        let matching = Array(items.enumerated().filter { $0.element.placement == placement && $0.element.kind == .item })
        if !matching.isEmpty {
            ToolbarItemGroup(placement: placement.swiftUIToolbarItemPlacement) {
                ForEach(matching, id: \.offset) { entry in
                    if let content = entry.element.content {
                        RenderNodeView(node: content, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            }
        }

        toolbarSpacers(for: placement)
    }

    @ToolbarContentBuilder
    private func toolbarSpacers(for placement: ToolbarItemPlacementKind) -> some ToolbarContent {
        let matching = items.filter { $0.placement == placement && $0.kind == .spacer }
        if let spacer = matching.first {
            ToolbarSpacer(spacer.sizing?.swiftUISpacerSizing ?? .flexible, placement: placement.swiftUIToolbarItemPlacement)
        }
    }
}

struct OptionalAlertModifier: ViewModifier {
    let alert: AlertValue?
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let alert {
            content.alert(
                alert.title,
                isPresented: .constant(alert.isPresented),
                actions: {
                    DialogButtons(actions: alert.actions, onEvent: onEvent)
                },
                message: {
                    if let message = alert.message {
                        RenderNodeView(node: message, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            )
        } else {
            content
        }
    }
}

struct OptionalConfirmationDialogModifier: ViewModifier {
    let dialog: ConfirmationDialogValue?
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let dialog {
            content.confirmationDialog(
                dialog.title,
                isPresented: .constant(dialog.isPresented),
                titleVisibility: dialog.titleVisibility.swiftUIVisibility,
                actions: {
                    DialogButtons(actions: dialog.actions, onEvent: onEvent)
                },
                message: {
                    if let message = dialog.message {
                        RenderNodeView(node: message, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            )
        } else {
            content
        }
    }
}

struct OptionalContextMenuModifier: ViewModifier {
    let contextMenu: ContextMenuValue?
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let contextMenu {
            if let preview = contextMenu.preview {
                content.contextMenu {
                    DialogButtons(actions: contextMenu.actions, onEvent: onEvent)
                } preview: {
                    RenderNodeView(node: preview, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            } else {
                content.contextMenu {
                    DialogButtons(actions: contextMenu.actions, onEvent: onEvent)
                }
            }
        } else {
            content
        }
    }
}

struct OptionalSwipeActionsModifier: ViewModifier {
    let swipeActions: [SwipeActionsValue]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if swipeActions.isEmpty {
            content
        } else {
            swipeActions.reduce(AnyView(content)) { partial, entry in
                AnyView(
                    partial.swipeActions(edge: entry.edge.swiftUIHorizontalEdge, allowsFullSwipe: entry.allowsFullSwipe) {
                        SwipeActionItems(items: entry.items, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                )
            }
        }
    }
}

struct OptionalDraggableModifier: ViewModifier {
    let draggable: TransferItemValue?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let draggable {
            content.onDrag {
                draggable.itemProvider
            }
        } else {
            content
        }
    }
}

struct OptionalDropDestinationModifier: ViewModifier {
    let dropDestination: DropDestinationValue?
    let onEvent: (SurfaceEvent) -> Void

    @State private var isTargeted = false

    @ViewBuilder
    func body(content: Content) -> some View {
        if let dropDestination {
            content
                .onDrop(of: dropDestination.contentTypeIdentifiers, isTargeted: $isTargeted) { providers, location in
                    handleDrop(providers: providers, location: location, destination: dropDestination)
                }
                .onChange(of: isTargeted) { _, nextValue in
                    guard let targetedEvent = dropDestination.targetedEvent else {
                        return
                    }

                    onEvent(SurfaceEvent(targetedEvent.name, payloadJSON: nextValue ? "true" : "false"))
                }
        } else {
            content
        }
    }

    private func handleDrop(providers: [NSItemProvider], location: CGPoint, destination: DropDestinationValue) -> Bool {
        let matchingProviders = providers.filter { provider in
            destination.contentTypeIdentifiers.contains { typeIdentifier in
                provider.hasItemConformingToTypeIdentifier(typeIdentifier)
            }
        }

        guard !matchingProviders.isEmpty else {
            return false
        }

        Task {
            let items = await loadItems(from: matchingProviders, supportedTypes: destination.contentTypeIdentifiers)
            guard !items.isEmpty else {
                return
            }

            let payload = DropActionPayloadValue(
                items: items,
                location: DropLocationValue(x: location.x, y: location.y)
            )

            await MainActor.run {
                onEvent(SurfaceEvent(destination.event.name, payloadJSON: payload.payloadJSON))
            }
        }

        return true
    }

    private func loadItems(from providers: [NSItemProvider], supportedTypes: [String]) async -> [TransferItemValue] {
        var items: [TransferItemValue] = []
        for provider in providers {
            if let item = await loadItem(from: provider, supportedTypes: supportedTypes) {
                items.append(item)
            }
        }
        return items
    }

    private func loadItem(from provider: NSItemProvider, supportedTypes: [String]) async -> TransferItemValue? {
        guard let matchedType = supportedTypes.first(where: { provider.hasItemConformingToTypeIdentifier($0) }) else {
            return nil
        }

        if matchedType == UTType.fileURL.identifier,
           let url = await loadURL(from: provider, typeIdentifier: matchedType) {
            return .file(value: url, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        if matchedType == UTType.url.identifier,
           let url = await loadURL(from: provider, typeIdentifier: matchedType) {
            return .url(value: url, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        if (matchedType == UTType.plainText.identifier || matchedType == UTType.text.identifier),
           let text = await loadText(from: provider) {
            return .text(value: text, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        if let fileURL = await loadFileRepresentation(from: provider, typeIdentifier: matchedType) {
            return .file(value: fileURL, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        if let data = await loadDataRepresentation(from: provider, typeIdentifier: matchedType) {
            return .data(value: data, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        if let text = await loadText(from: provider) {
            return .text(value: text, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        if let url = await loadURL(from: provider, typeIdentifier: matchedType) {
            return .url(value: url, contentType: matchedType, suggestedName: provider.suggestedName)
        }

        return nil
    }

    private func loadText(from provider: NSItemProvider) async -> String? {
        await withCheckedContinuation { continuation in
            provider.loadObject(ofClass: NSString.self) { object, _ in
                continuation.resume(returning: object as? String)
            }
        }
    }

    private func loadURL(from provider: NSItemProvider, typeIdentifier: String) async -> URL? {
        await withCheckedContinuation { continuation in
            provider.loadItem(forTypeIdentifier: typeIdentifier, options: nil) { item, _ in
                switch item {
                case let url as URL:
                    continuation.resume(returning: url)
                case let url as NSURL:
                    continuation.resume(returning: url as URL)
                case let data as Data:
                    continuation.resume(returning: URL(dataRepresentation: data, relativeTo: nil))
                case let string as String:
                    continuation.resume(returning: URL(string: string))
                case let string as NSString:
                    continuation.resume(returning: URL(string: string as String))
                default:
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    private func loadFileRepresentation(from provider: NSItemProvider, typeIdentifier: String) async -> URL? {
        await withCheckedContinuation { continuation in
            provider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, _ in
                continuation.resume(returning: url)
            }
        }
    }

    private func loadDataRepresentation(from provider: NSItemProvider, typeIdentifier: String) async -> Data? {
        await withCheckedContinuation { continuation in
            provider.loadDataRepresentation(forTypeIdentifier: typeIdentifier) { data, _ in
                continuation.resume(returning: data)
            }
        }
    }
}

struct SwipeActionItems: View {
    let items: [ViewNode]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    var body: some View {
        ForEach(items) { item in
            RenderNodeView(node: item, onEvent: onEvent, customHostRegistry: customHostRegistry)
        }
    }
}

struct DialogButtons: View {
    let actions: [DialogActionValue]
    let onEvent: (SurfaceEvent) -> Void

    var body: some View {
        ForEach(Array(actions.enumerated()), id: \.offset) { entry in
            let action = entry.element
            Button(action.title, role: action.role?.swiftUIRole) {
                if let event = action.event {
                    onEvent(SurfaceEvent(event))
                }
            }
        }
    }
}

struct OptionalOnAppearModifier: ViewModifier {
    let event: SurfaceEvent?
    let onEvent: (SurfaceEvent) -> Void

    @ViewBuilder
    func body(content: Content) -> some View {
        if let event {
            content.onAppear {
                onEvent(event)
            }
        } else {
            content
        }
    }
}
