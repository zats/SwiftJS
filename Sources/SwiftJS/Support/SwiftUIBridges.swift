import Foundation
import JavaScriptCore
import Observation
import SwiftUI
import UniformTypeIdentifiers
import UIKit
import WebKit
import SwiftJSCore

extension DatePickerDisplayedComponentsKind {
    var swiftUIDatePickerComponents: DatePickerComponents {
        switch self {
        case .date:
            [.date]
        case .hourAndMinute:
            [.hourAndMinute]
        case .dateAndTime:
            [.date, .hourAndMinute]
        }
    }
}

extension ViewModifiers {
    var swiftUIFont: Font? {
        if let fontSize {
            return .system(size: fontSize, weight: swiftUIFontWeight ?? .regular)
        }

        guard let fontStyle else {
            return nil
        }

        switch fontStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .caption:
            return .caption
        case .caption2:
            return .caption2
        case .footnote:
            return .footnote
        }
    }

    var swiftUIFontWeight: SwiftUI.Font.Weight? {
        guard let fontWeight else {
            return nil
        }

        switch fontWeight {
        case .ultraLight:
            return .ultraLight
        case .thin:
            return .thin
        case .light:
            return .light
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        case .heavy:
            return .heavy
        case .black:
            return .black
        }
    }

    var swiftUIColor: Color? {
        foregroundColor.flatMap(Color.named(_:))
    }

    var backgroundShapeStyle: AnyShapeStyle? {
        background?.swiftUIShapeStyle
    }

    var foregroundShapeStyle: AnyShapeStyle? {
        foregroundStyle?.swiftUIShapeStyle
    }

    var defaultShapeStyle: AnyShapeStyle {
        foregroundShapeStyle ?? swiftUIColor.map(AnyShapeStyle.init) ?? AnyShapeStyle(.foreground)
    }

    var swiftUISymbolRenderingMode: SwiftUI.SymbolRenderingMode? {
        guard let symbolRenderingMode else {
            return nil
        }

        switch symbolRenderingMode {
        case .monochrome:
            return .monochrome
        case .hierarchical:
            return .hierarchical
        case .multicolor:
            return .multicolor
        }
    }

    var usesGlassButtonStyle: Bool {
        switch buttonStyle {
        case .glass, .glassProminent:
            return true
        default:
            return false
        }
    }

    var swiftUIAlignment: Alignment {
        alignment.swiftUIAlignment
    }

    var swiftUIAspectRatioContentMode: SwiftUI.ContentMode {
        (aspectRatioContentMode ?? .fit).swiftUIContentMode
    }

    var swiftUINavigationLinkIndicatorVisibility: SwiftUI.Visibility? {
        guard let navigationLinkIndicatorVisibility else {
            return nil
        }

        switch navigationLinkIndicatorVisibility {
        case .automatic:
            return .automatic
        case .visible:
            return .visible
        case .hidden:
            return .hidden
        }
    }

    var swiftUITextAlignment: TextAlignment? {
        guard let multilineTextAlignment else {
            return nil
        }

        switch multilineTextAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }

    var swiftUITruncationMode: Text.TruncationMode? {
        guard let truncationMode else {
            return nil
        }

        switch truncationMode {
        case .head:
            return .head
        case .middle:
            return .middle
        case .tail:
            return .tail
        }
    }

    var swiftUINavigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode? {
        guard let navigationBarTitleDisplayMode else {
            return nil
        }

        switch navigationBarTitleDisplayMode {
        case .automatic:
            return .automatic
        case .inline:
            return .inline
        case .large:
            return .large
        }
    }

    var swiftUIToolbarRole: ToolbarRole? {
        guard let toolbarRole else {
            return nil
        }

        return toolbarRole.swiftUIToolbarRole
    }

    var swiftUISearchPresentationToolbarBehavior: SearchPresentationToolbarBehaviorKind? {
        searchPresentationToolbarBehavior
    }

    var swiftUIToolbarBackgroundVisibility: Visibility? {
        toolbarBackgroundVisibility?.swiftUIVisibility
    }

    var swiftUIColorScheme: ColorScheme? {
        guard let toolbarColorScheme else {
            return nil
        }

        switch toolbarColorScheme {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    var swiftUIScrollContentBackgroundVisibility: Visibility? {
        scrollContentBackground?.swiftUIVisibility
    }

    var swiftUIListRowSeparatorVisibility: Visibility? {
        listRowSeparator?.swiftUIVisibility
    }

    var swiftUIListSectionSeparatorVisibility: Visibility? {
        listSectionSeparator?.swiftUIVisibility
    }

    var swiftUIPresentationDragIndicator: Visibility? {
        presentationDragIndicator?.swiftUIVisibility
    }
}

extension TransferItemValue {
    var itemProvider: NSItemProvider {
        switch self {
        case let .text(value, _, suggestedName):
            let provider = NSItemProvider(object: value as NSString)
            provider.suggestedName = suggestedName
            return provider
        case let .url(value, _, suggestedName),
             let .file(value, _, suggestedName):
            let provider = NSItemProvider(object: value as NSURL)
            provider.suggestedName = suggestedName
            return provider
        case let .data(value, contentType, suggestedName):
            let provider = NSItemProvider()
            provider.suggestedName = suggestedName
            provider.registerDataRepresentation(forTypeIdentifier: contentType, visibility: .all) { completion in
                completion(value, nil)
                return nil
            }
            return provider
        }
    }
}

extension DropDestinationValue {
    var contentTypeIdentifiers: [String] {
        if let contentTypes, !contentTypes.isEmpty {
            return contentTypes
        }

        return [
            UTType.fileURL.identifier,
            UTType.url.identifier,
            UTType.plainText.identifier,
            UTType.data.identifier
        ]
    }
}

extension ShapeStyleValue {
    var swiftUIShapeStyle: AnyShapeStyle {
        switch self {
        case let .color(value):
            AnyShapeStyle(Color.named(value) ?? Color(value))
        case let .linearGradient(value):
            AnyShapeStyle(
                LinearGradient(
                    gradient: value.swiftUIGradient,
                    startPoint: value.startPoint.swiftUIUnitPoint,
                    endPoint: value.endPoint.swiftUIUnitPoint
                )
            )
        case let .radialGradient(value):
            AnyShapeStyle(
                RadialGradient(
                    gradient: value.swiftUIGradient,
                    center: value.center.swiftUIUnitPoint,
                    startRadius: value.startRadius,
                    endRadius: value.endRadius
                )
            )
        case let .angularGradient(value):
            if let angle = value.angle {
                AnyShapeStyle(
                    AngularGradient(
                        gradient: value.swiftUIGradient,
                        center: value.center.swiftUIUnitPoint,
                        angle: .degrees(angle)
                    )
                )
            } else {
                AnyShapeStyle(
                    AngularGradient(
                        gradient: value.swiftUIGradient,
                        center: value.center.swiftUIUnitPoint,
                        startAngle: .degrees(value.startAngle ?? 0),
                        endAngle: .degrees(value.endAngle ?? 360)
                    )
                )
            }
        }
    }
}

extension LinearGradientValue {
    var swiftUIGradient: Gradient {
        makeGradient(colors: colors, stops: stops)
    }
}

extension RadialGradientValue {
    var swiftUIGradient: Gradient {
        makeGradient(colors: colors, stops: stops)
    }
}

extension AngularGradientValue {
    var swiftUIGradient: Gradient {
        makeGradient(colors: colors, stops: stops)
    }
}

private func makeGradient(colors: [String]?, stops: [GradientStopValue]?) -> Gradient {
    if let stops, !stops.isEmpty {
        return Gradient(
            stops: stops.map { stop in
                Gradient.Stop(
                    color: Color.named(stop.color) ?? Color(stop.color),
                    location: stop.location
                )
            }
        )
    }

    return Gradient(colors: (colors ?? ["clear", "clear"]).map { Color.named($0) ?? Color($0) })
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
func glassValue(for modifiers: ViewModifiers) -> SwiftUI.Glass {
    if let tint = modifiers.glassTint.flatMap(Color.named(_:)) {
        switch modifiers.glassVariant {
        case .clear:
            return .clear.tint(tint)
        case .regular:
            return .regular.tint(tint)
        }
    }

    switch modifiers.glassVariant {
    case .clear:
        return .clear
    case .regular:
        return .regular
    }
}

extension VisibilityKind {
    var swiftUIVisibility: Visibility {
        switch self {
        case .automatic:
            return .automatic
        case .visible:
            return .visible
        case .hidden:
            return .hidden
        }
    }
}

extension EditModeKind {
    var swiftUIEditMode: SwiftUI.EditMode {
        switch self {
        case .inactive:
            return .inactive
        case .transient:
            return .transient
        case .active:
            return .active
        }
    }
}

extension SwiftUI.EditMode {
    var swiftJSEditMode: EditModeKind {
        switch self {
        case .inactive:
            return .inactive
        case .transient:
            return .transient
        case .active:
            return .active
        @unknown default:
            return .inactive
        }
    }
}

extension EdgeInsetsValue {
    var swiftUIEdgeInsets: EdgeInsets {
        EdgeInsets(
            top: CGFloat(top ?? 0),
            leading: CGFloat(leading ?? 0),
            bottom: CGFloat(bottom ?? 0),
            trailing: CGFloat(trailing ?? 0)
        )
    }
}

extension EdgeKind {
    var swiftUIEdge: Edge {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

extension HorizontalEdgeKind {
    var swiftUIHorizontalEdge: HorizontalEdge {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

extension EdgeSetKind {
    var swiftUIEdgeSet: Edge.Set {
        switch self {
        case .all:
            return .all
        case .horizontal:
            return .horizontal
        case .vertical:
            return .vertical
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

extension ContentMarginPlacementKind {
    var swiftUIContentMarginPlacement: ContentMarginPlacement {
        switch self {
        case .automatic:
            return .automatic
        case .scrollContent:
            return .scrollContent
        case .scrollIndicators:
            return .scrollIndicators
        }
    }
}

extension ToolbarItemPlacementKind {
    var swiftUIToolbarItemPlacement: ToolbarItemPlacement {
        switch self {
        case .automatic:
            return .automatic
        case .principal:
            return .principal
        case .topBarLeading:
            return .topBarLeading
        case .topBarTrailing:
            return .topBarTrailing
        case .bottomBar:
            return .bottomBar
        case .status:
            return .status
        case .cancellationAction:
            return .cancellationAction
        case .confirmationAction:
            return .confirmationAction
        case .primaryAction:
            return .primaryAction
        }
    }
}

extension ToolbarRoleKind {
    var swiftUIToolbarRole: ToolbarRole {
        switch self {
        case .automatic:
            .automatic
        case .browser:
            .browser
        case .editor:
#if os(tvOS)
            .automatic
#else
            .editor
#endif
        }
    }
}

extension SearchFieldPlacementValue {
    var swiftUISearchFieldPlacement: SearchFieldPlacement {
        switch kind {
        case .automatic:
            .automatic
        case .toolbar:
#if os(tvOS)
            .automatic
#else
            .toolbar
#endif
        case .toolbarPrincipal:
#if os(tvOS)
            .automatic
#else
            .toolbarPrincipal
#endif
        case .sidebar:
#if os(tvOS)
            .automatic
#else
            .sidebar
#endif
        case .navigationBarDrawer:
#if os(tvOS)
            .automatic
#else
            .navigationBarDrawer(displayMode: navigationBarDrawerDisplayMode?.swiftUISearchFieldNavigationBarDrawerDisplayMode ?? .automatic)
#endif
        }
    }
}

#if !os(tvOS)
extension SearchFieldNavigationBarDrawerDisplayModeKind {
    var swiftUISearchFieldNavigationBarDrawerDisplayMode: SearchFieldPlacement.NavigationBarDrawerDisplayMode {
        switch self {
        case .automatic:
            .automatic
        case .always:
            .always
        }
    }
}
#endif

@available(iOS 17.1, tvOS 17.1, watchOS 10.1, *)
extension SearchPresentationToolbarBehaviorKind {
    var swiftUISearchPresentationToolbarBehavior: SearchPresentationToolbarBehavior {
        switch self {
        case .automatic:
            .automatic
        case .avoidHidingContent:
            .avoidHidingContent
        }
    }
}

@available(iOS 26.0, tvOS 26.0, watchOS 26.0, *)
extension SearchToolbarBehaviorKind {
    var swiftUISearchToolbarBehavior: SearchToolbarBehavior {
        switch self {
        case .automatic:
            .automatic
        case .minimized:
            .minimize
        }
    }
}

extension KeyboardTypeKind {
    var swiftUIKeyboardType: UIKeyboardType {
        switch self {
        case .default:
            .default
        case .asciiCapable:
            .asciiCapable
        case .numberPad:
            .numberPad
        case .decimalPad:
            .decimalPad
        case .phonePad:
            .phonePad
        case .emailAddress:
            .emailAddress
        case .URL:
            .URL
        }
    }
}

extension TextInputAutocapitalizationKind {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    var swiftUITextInputAutocapitalization: TextInputAutocapitalization {
        switch self {
        case .never:
            .never
        case .words:
            .words
        case .sentences:
            .sentences
        case .characters:
            .characters
        }
    }
}

extension SubmitLabelKind {
    var swiftUISubmitLabel: SubmitLabel {
        switch self {
        case .done:
            .done
        case .go:
            .go
        case .send:
            .send
        case .join:
            .join
        case .route:
            .route
        case .search:
            .search
        case .return:
            .return
        case .next:
            .next
        case .continue:
            .continue
        }
    }
}

extension ButtonRoleKind {
    var swiftUIRole: ButtonRole? {
        switch self {
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        }
    }
}

extension PresentationDetentValue {
    var swiftUIPresentationDetent: PresentationDetent {
        switch self {
        case .medium:
            return .medium
        case .large:
            return .large
        case let .fraction(value):
            return .fraction(value)
        case let .height(value):
            return .height(value)
        }
    }
}

extension Color {
    static func named(_ value: String) -> Color? {
        if let hexColor = hex(value) {
            return hexColor
        }

        switch value {
        case "red":
            return .red
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "pink":
            return .pink
        case "purple":
            return .purple
        case "cyan":
            return .cyan
        case "gray", "grey":
            return .gray
        case "black":
            return .black
        case "mint":
            return .mint
        case "indigo":
            return .indigo
        case "teal":
            return .teal
        case "white":
            return .white
        case "primary":
            return .primary
        case "secondary":
            return .secondary
        case "clear":
            return .clear
        case "systemGroupedBackground":
            return Color(uiColor: .systemGroupedBackground)
        case "secondarySystemBackground":
            return Color(uiColor: .secondarySystemBackground)
        case "tertiarySystemBackground":
            return Color(uiColor: .tertiarySystemBackground)
        case "tertiarySystemFill":
            return Color(uiColor: .tertiarySystemFill)
        case "quaternarySystemFill":
            return Color(uiColor: .quaternarySystemFill)
        default:
            return Color(value)
        }
    }

    static func hex(_ value: String) -> Color? {
        guard let digits = value.stripHexPrefix else {
            return nil
        }

        let expanded: String
        switch digits.count {
        case 3, 4:
            expanded = digits.reduce(into: "") { partialResult, character in
                partialResult.append(character)
                partialResult.append(character)
            }
        case 6, 8:
            expanded = digits
        default:
            return nil
        }

        guard let hex = UInt64(expanded, radix: 16) else {
            return nil
        }

        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double

        if expanded.count == 6 {
            red = Double((hex >> 16) & 0xFF) / 255
            green = Double((hex >> 8) & 0xFF) / 255
            blue = Double(hex & 0xFF) / 255
            alpha = 1
        } else {
            red = Double((hex >> 24) & 0xFF) / 255
            green = Double((hex >> 16) & 0xFF) / 255
            blue = Double((hex >> 8) & 0xFF) / 255
            alpha = Double(hex & 0xFF) / 255
        }

        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension String {
    var stripHexPrefix: String? {
        guard hasPrefix("#") else {
            return nil
        }

        let digits = String(dropFirst())
        guard !digits.isEmpty, digits.allSatisfy(\.isHexDigit) else {
            return nil
        }

        return digits
    }
}

extension AxisKind {
    var swiftUIAxisSet: Axis.Set {
        switch self {
        case .vertical:
            return .vertical
        case .horizontal:
            return .horizontal
        }
    }
}

extension UnitPointValue {
    var swiftUIUnitPoint: UnitPoint {
        switch self {
        case .center:
            .center
        case .leading:
            .leading
        case .trailing:
            .trailing
        case .top:
            .top
        case .bottom:
            .bottom
        case .topLeading:
            .topLeading
        case .topTrailing:
            .topTrailing
        case .bottomLeading:
            .bottomLeading
        case .bottomTrailing:
            .bottomTrailing
        }
    }
}

extension ImageContentMode {
    var swiftUIContentMode: SwiftUI.ContentMode {
        switch self {
        case .fit:
            return .fit
        case .fill:
            return .fill
        }
    }
}

extension ImageInterpolation {
    var swiftUIImageInterpolation: SwiftUI.Image.Interpolation {
        switch self {
        case .none:
            return .none
        case .low:
            return .low
        case .medium:
            return .medium
        case .high:
            return .high
        }
    }
}

extension ContentAlignment {
    var swiftUIUnitPoint: UnitPoint {
        switch self {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .topLeading:
            return .topLeading
        case .topTrailing:
            return .topTrailing
        case .bottomLeading:
            return .bottomLeading
        case .bottomTrailing:
            return .bottomTrailing
        }
    }

    var swiftUIAlignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .topLeading:
            return .topLeading
        case .topTrailing:
            return .topTrailing
        case .bottomLeading:
            return .bottomLeading
        case .bottomTrailing:
            return .bottomTrailing
        }
    }

    var swiftUIHorizontalAlignment: HorizontalAlignment {
        switch self {
        case .leading, .topLeading, .bottomLeading:
            return .leading
        case .trailing, .topTrailing, .bottomTrailing:
            return .trailing
        default:
            return .center
        }
    }

    var swiftUIVerticalAlignment: VerticalAlignment {
        switch self {
        case .top, .topLeading, .topTrailing:
            return .top
        case .bottom, .bottomLeading, .bottomTrailing:
            return .bottom
        default:
            return .center
        }
    }
}
