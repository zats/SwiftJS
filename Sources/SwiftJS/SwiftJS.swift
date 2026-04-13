import Foundation
import JavaScriptCore
import Observation
import SwiftUI
import UIKit
import SwiftJSCore

public struct SurfaceEvent: Hashable, Sendable, ExpressibleByStringLiteral {
    public let name: String
    public let payloadJSON: String?

    public init(_ name: String) {
        self.init(name, payloadJSON: nil)
    }

    public init(_ name: String, payloadJSON: String?) {
        self.name = name
        self.payloadJSON = payloadJSON
    }

    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

public struct NodeID: Hashable, Sendable, ExpressibleByStringLiteral {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

public enum TextStyle: String, Codable, Equatable, Sendable {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case caption
    case caption2
    case footnote
}

public enum FontWeight: String, Codable, Equatable, Sendable {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
}

public enum SymbolRenderingMode: String, Codable, Equatable, Sendable {
    case monochrome
    case hierarchical
    case multicolor
}

public enum VisibilityKind: String, Codable, Equatable, Sendable {
    case automatic
    case visible
    case hidden
}

public enum ButtonStyle: String, Codable, Equatable, Sendable {
    case automatic
    case borderless
    case plain
    case bordered
    case borderedProminent
    case glass
    case glassProminent
}

public enum ButtonBorderShape: String, Codable, Equatable, Sendable {
    case automatic
    case capsule
    case roundedRectangle
    case circle
}

public enum AxisKind: String, Codable, Equatable, Sendable {
    case vertical
    case horizontal
}

public enum StackDistribution: String, Codable, Equatable, Sendable {
    case natural
    case fillEqually
}

public enum ContentAlignment: String, Codable, Equatable, Sendable {
    case leading
    case center
    case trailing
    case top
    case bottom
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

public enum UnitPointValue: String, Codable, Equatable, Sendable {
    case center
    case leading
    case trailing
    case top
    case bottom
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

public enum ListStyleKind: String, Codable, Equatable, Sendable {
    case automatic
    case plain
    case grouped
    case inset
    case insetGrouped
    case sidebar
}

public enum TextAlignmentKind: String, Codable, Equatable, Sendable {
    case leading
    case center
    case trailing
}

public enum TruncationModeKind: String, Codable, Equatable, Sendable {
    case head
    case middle
    case tail
}

public enum NavigationBarTitleDisplayModeKind: String, Codable, Equatable, Sendable {
    case automatic
    case inline
    case large
}

public enum ColorSchemeKind: String, Codable, Equatable, Sendable {
    case light
    case dark
}

public enum GlassVariantKind: String, Codable, Equatable, Sendable {
    case regular
    case clear
}

public enum EdgeKind: String, Codable, Equatable, Sendable {
    case top
    case bottom
    case leading
    case trailing
}

public enum EdgeSetKind: String, Codable, Equatable, Sendable {
    case all
    case horizontal
    case vertical
    case top
    case bottom
    case leading
    case trailing
}

public enum ContentMarginPlacementKind: String, Codable, Equatable, Sendable {
    case automatic
    case scrollContent
    case scrollIndicators
}

public enum ToolbarItemPlacementKind: String, Codable, Equatable, Sendable {
    case automatic
    case principal
    case topBarLeading
    case topBarTrailing
    case bottomBar
    case status
    case cancellationAction
    case confirmationAction
    case primaryAction
}

public enum ImageContentMode: String, Codable, Equatable, Sendable {
    case fit
    case fill
}

public enum ImageInterpolation: String, Codable, Equatable, Sendable {
    case none
    case low
    case medium
    case high
}

public enum ImageSource: Equatable, Sendable {
    case system(String)
    case asset(String)
}

public struct GradientStopValue: Codable, Equatable, Sendable {
    public let color: String
    public let location: Double

    public init(color: String, location: Double) {
        self.color = color
        self.location = location
    }
}

public struct LinearGradientValue: Codable, Equatable, Sendable {
    public let colors: [String]?
    public let stops: [GradientStopValue]?
    public let startPoint: UnitPointValue
    public let endPoint: UnitPointValue
}

public struct RadialGradientValue: Codable, Equatable, Sendable {
    public let colors: [String]?
    public let stops: [GradientStopValue]?
    public let center: UnitPointValue
    public let startRadius: Double
    public let endRadius: Double
}

public struct AngularGradientValue: Codable, Equatable, Sendable {
    public let colors: [String]?
    public let stops: [GradientStopValue]?
    public let center: UnitPointValue
    public let angle: Double?
    public let startAngle: Double?
    public let endAngle: Double?
}

public enum ShapeStyleValue: Equatable, Sendable {
    case color(String)
    case linearGradient(LinearGradientValue)
    case radialGradient(RadialGradientValue)
    case angularGradient(AngularGradientValue)
}

public enum PickerSelectionValue: Equatable, Hashable, Sendable, Codable {
    case string(String)
    case number(Double)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else {
            self = .string(try container.decode(String.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case let .string(value):
            try container.encode(value)
        case let .number(value):
            try container.encode(value)
        }
    }

    var payloadJSON: String {
        switch self {
        case let .string(value):
            let data = try? JSONEncoder().encode(value)
            return String(decoding: data ?? Data("null".utf8), as: UTF8.self)
        case let .number(value):
            if value.rounded(.towardZero) == value {
                return String(Int64(value))
            }

            return String(value)
        }
    }
}

public struct PickerOption: Equatable, Hashable, Sendable, Codable {
    public let title: String
    public let value: PickerSelectionValue

    public init(title: String, value: PickerSelectionValue) {
        self.title = title
        self.value = value
    }
}

public enum BadgeValue: Equatable, Hashable, Sendable, Codable {
    case string(String)
    case number(Double)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else {
            self = .string(try container.decode(String.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case let .string(value):
            try container.encode(value)
        case let .number(value):
            try container.encode(value)
        }
    }
}

public struct EdgeInsetsValue: Codable, Equatable, Sendable {
    public let top: Double?
    public let leading: Double?
    public let bottom: Double?
    public let trailing: Double?
}

public struct ContentMarginsValue: Codable, Equatable, Sendable {
    public let edges: EdgeSetKind
    public let amount: Double
    public let placement: ContentMarginPlacementKind
}

public struct SafeAreaInsetValue: Equatable, Sendable {
    public let edge: EdgeKind
    public let spacing: Double?
    public let content: ViewNode
}

public struct ToolbarItemValue: Equatable, Sendable {
    public let placement: ToolbarItemPlacementKind
    public let content: ViewNode
}

public enum DialogActionRoleKind: String, Codable, Equatable, Sendable {
    case cancel
    case destructive
}

public struct DialogActionValue: Codable, Equatable, Sendable {
    public let title: String
    public let role: DialogActionRoleKind?
    public let event: String?
}

public struct AlertValue: Equatable, Sendable {
    public let title: String
    public let isPresented: Bool
    public let message: ViewNode?
    public let actions: [DialogActionValue]
}

public struct ConfirmationDialogValue: Equatable, Sendable {
    public let title: String
    public let isPresented: Bool
    public let titleVisibility: VisibilityKind
    public let message: ViewNode?
    public let actions: [DialogActionValue]
}

public enum PresentationDetentValue: Equatable, Sendable, Codable {
    case medium
    case large
    case fraction(Double)
    case height(Double)

    private enum CodingKeys: String, CodingKey {
        case kind
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(String.self, forKey: .kind)

        switch kind {
        case "medium":
            self = .medium
        case "large":
            self = .large
        case "fraction":
            self = .fraction(try container.decode(Double.self, forKey: .value))
        case "height":
            self = .height(try container.decode(Double.self, forKey: .value))
        default:
            throw DecodingError.dataCorruptedError(forKey: .kind, in: container, debugDescription: "Unsupported presentation detent '\(kind)'")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .medium:
            try container.encode("medium", forKey: .kind)
        case .large:
            try container.encode("large", forKey: .kind)
        case let .fraction(value):
            try container.encode("fraction", forKey: .kind)
            try container.encode(value, forKey: .value)
        case let .height(value):
            try container.encode("height", forKey: .kind)
            try container.encode(value, forKey: .value)
        }
    }
}

public enum PresentationBackgroundInteractionValue: Equatable, Sendable {
    case automatic
    case enabled
    case disabled
    case upThrough(PresentationDetentValue)
}

public enum CustomHostValue: Equatable, Sendable, Codable {
    case string(String)
    case number(Double)
    case bool(Bool)
    case array([CustomHostValue])
    case object([String: CustomHostValue])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode([CustomHostValue].self) {
            self = .array(value)
        } else if let value = try? container.decode([String: CustomHostValue].self) {
            self = .object(value)
        } else {
            self = .string(try container.decode(String.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case let .string(value):
            try container.encode(value)
        case let .number(value):
            try container.encode(value)
        case let .bool(value):
            try container.encode(value)
        case let .array(value):
            try container.encode(value)
        case let .object(value):
            try container.encode(value)
        }
    }
}

extension ShapeStyleValue: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
        case value
        case colors
        case stops
        case startPoint
        case endPoint
        case center
        case startRadius
        case endRadius
        case angle
        case startAngle
        case endAngle
    }

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(),
           let value = try? container.decode(String.self) {
            self = .color(value)
            return
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "LinearGradient":
            self = .linearGradient(
                LinearGradientValue(
                    colors: try container.decodeIfPresent([String].self, forKey: .colors),
                    stops: try container.decodeIfPresent([GradientStopValue].self, forKey: .stops),
                    startPoint: try container.decode(UnitPointValue.self, forKey: .startPoint),
                    endPoint: try container.decode(UnitPointValue.self, forKey: .endPoint)
                )
            )
        case "RadialGradient":
            self = .radialGradient(
                RadialGradientValue(
                    colors: try container.decodeIfPresent([String].self, forKey: .colors),
                    stops: try container.decodeIfPresent([GradientStopValue].self, forKey: .stops),
                    center: try container.decodeIfPresent(UnitPointValue.self, forKey: .center) ?? .center,
                    startRadius: try container.decodeIfPresent(Double.self, forKey: .startRadius) ?? 0,
                    endRadius: try container.decode(Double.self, forKey: .endRadius)
                )
            )
        case "AngularGradient":
            self = .angularGradient(
                AngularGradientValue(
                    colors: try container.decodeIfPresent([String].self, forKey: .colors),
                    stops: try container.decodeIfPresent([GradientStopValue].self, forKey: .stops),
                    center: try container.decodeIfPresent(UnitPointValue.self, forKey: .center) ?? .center,
                    angle: try container.decodeIfPresent(Double.self, forKey: .angle),
                    startAngle: try container.decodeIfPresent(Double.self, forKey: .startAngle),
                    endAngle: try container.decodeIfPresent(Double.self, forKey: .endAngle)
                )
            )
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unsupported shape style type '\(type)'")
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .color(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .linearGradient(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("LinearGradient", forKey: .type)
            try container.encodeIfPresent(value.colors, forKey: .colors)
            try container.encodeIfPresent(value.stops, forKey: .stops)
            try container.encode(value.startPoint, forKey: .startPoint)
            try container.encode(value.endPoint, forKey: .endPoint)
        case let .radialGradient(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("RadialGradient", forKey: .type)
            try container.encodeIfPresent(value.colors, forKey: .colors)
            try container.encodeIfPresent(value.stops, forKey: .stops)
            try container.encode(value.center, forKey: .center)
            try container.encode(value.startRadius, forKey: .startRadius)
            try container.encode(value.endRadius, forKey: .endRadius)
        case let .angularGradient(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("AngularGradient", forKey: .type)
            try container.encodeIfPresent(value.colors, forKey: .colors)
            try container.encodeIfPresent(value.stops, forKey: .stops)
            try container.encode(value.center, forKey: .center)
            try container.encodeIfPresent(value.angle, forKey: .angle)
            try container.encodeIfPresent(value.startAngle, forKey: .startAngle)
            try container.encodeIfPresent(value.endAngle, forKey: .endAngle)
        }
    }
}

public struct CustomHostContext: Equatable, Sendable {
    public let id: NodeID
    public let name: String
    public let values: [String: CustomHostValue]
    public let children: [ViewNode]
    public let slots: [String: ViewNode]

    public init(id: NodeID, name: String, values: [String: CustomHostValue], children: [ViewNode], slots: [String: ViewNode]) {
        self.id = id
        self.name = name
        self.values = values
        self.children = children
        self.slots = slots
    }

    public func stringValue(forKey key: String) -> String? {
        guard case let .string(value)? = values[key] else {
            return nil
        }

        return value
    }

    public func numberValue(forKey key: String) -> Double? {
        guard case let .number(value)? = values[key] else {
            return nil
        }

        return value
    }

    public func boolValue(forKey key: String) -> Bool? {
        guard case let .bool(value)? = values[key] else {
            return nil
        }

        return value
    }

    public func decodeValue<Value: Decodable>(forKey key: String, as type: Value.Type) -> Value? {
        guard let value = values[key] else {
            return nil
        }

        do {
            let data = try JSONEncoder().encode(value)
            return try JSONDecoder().decode(Value.self, from: data)
        } catch {
            return nil
        }
    }

    public func slot(named name: String) -> ViewNode? {
        slots[name]
    }
}

public struct CustomHostRegistry {
    public typealias Renderer = @MainActor (CustomHostContext, @escaping (SurfaceEvent) -> Void, CustomHostRegistry) -> AnyView
    public typealias LayoutRenderer = @MainActor (CustomHostContext) -> AnyLayout

    private let renderers: [String: Renderer]
    private let layouts: [String: LayoutRenderer]
    fileprivate let javaScriptLayoutBridge: JavaScriptLayoutBridge?
    fileprivate let geometryReaderBridge: GeometryReaderBridge?

    public init(renderers: [String: Renderer] = [:], layouts: [String: LayoutRenderer] = [:]) {
        self.renderers = renderers
        self.layouts = layouts
        self.javaScriptLayoutBridge = nil
        self.geometryReaderBridge = nil
    }

    fileprivate init(
        renderers: [String: Renderer],
        layouts: [String: LayoutRenderer],
        javaScriptLayoutBridge: JavaScriptLayoutBridge?,
        geometryReaderBridge: GeometryReaderBridge?
    ) {
        self.renderers = renderers
        self.layouts = layouts
        self.javaScriptLayoutBridge = javaScriptLayoutBridge
        self.geometryReaderBridge = geometryReaderBridge
    }

    public func renderer(named name: String) -> Renderer? {
        renderers[name]
    }

    public func layout(named name: String) -> LayoutRenderer? {
        layouts[name]
    }

    fileprivate func withJavaScriptLayoutBridge(_ bridge: JavaScriptLayoutBridge) -> Self {
        Self(
            renderers: renderers,
            layouts: layouts,
            javaScriptLayoutBridge: bridge,
            geometryReaderBridge: geometryReaderBridge
        )
    }

    fileprivate func withGeometryReaderBridge(_ bridge: GeometryReaderBridge) -> Self {
        Self(
            renderers: renderers,
            layouts: layouts,
            javaScriptLayoutBridge: javaScriptLayoutBridge,
            geometryReaderBridge: bridge
        )
    }
}

public struct ViewModifiers: Equatable, Sendable {
    public var alignment: ContentAlignment
    public var viewIdentity: CustomHostValue?
    public var padding: Double?
    public var paddingTop: Double?
    public var frameMinWidth: Double?
    public var frameMinHeight: Double?
    public var frameWidth: Double?
    public var frameHeight: Double?
    public var frameMaxWidth: Bool
    public var frameMaxHeight: Bool
    public var frameMaxWidthValue: Double?
    public var frameMaxHeightValue: Double?
    public var background: ShapeStyleValue?
    public var foregroundColor: String?
    public var foregroundStyle: ShapeStyleValue?
    public var tint: String?
    public var cornerRadius: Double?
    public var fontStyle: TextStyle?
    public var fontSize: Double?
    public var fontWeight: FontWeight?
    public var symbolRenderingMode: SymbolRenderingMode?
    public var buttonStyle: ButtonStyle?
    public var buttonBorderShape: ButtonBorderShape?
    public var isDisabled: Bool
    public var glassEffect: Bool
    public var glassVariant: GlassVariantKind
    public var glassTint: String?
    public var navigationTitle: String?
    public var navigationBarTitleDisplayMode: NavigationBarTitleDisplayModeKind?
    public var navigationLinkIndicatorVisibility: VisibilityKind?
    public var toolbarItems: [ToolbarItemValue]
    public var toolbarBackgroundVisibility: VisibilityKind?
    public var toolbarColorScheme: ColorSchemeKind?
    public var listStyle: ListStyleKind?
    public var scrollContentBackground: VisibilityKind?
    public var listRowSeparator: VisibilityKind?
    public var listSectionSeparator: VisibilityKind?
    public var listRowInsets: EdgeInsetsValue?
    public var listRowBackground: ShapeStyleValue?
    public var contentMargins: [ContentMarginsValue]
    public var imageContentMode: ImageContentMode?
    public var imageInterpolation: ImageInterpolation?
    public var aspectRatio: Double?
    public var aspectRatioContentMode: ImageContentMode?
    public var fixedSizeHorizontal: Bool
    public var fixedSizeVertical: Bool
    public var safeAreaPaddingLength: Double?
    public var safeAreaPaddingEdges: EdgeSetKind
    public var ignoresSafeArea: Bool
    public var ignoresSafeAreaEdges: EdgeSetKind
    public var safeAreaInsets: [SafeAreaInsetValue]
    public var lineLimit: Int?
    public var multilineTextAlignment: TextAlignmentKind?
    public var truncationMode: TruncationModeKind?
    public var minimumScaleFactor: Double?
    public var presentationDetents: [PresentationDetentValue]
    public var presentationDragIndicator: VisibilityKind?
    public var presentationCornerRadius: Double?
    public var presentationBackgroundInteraction: PresentationBackgroundInteractionValue?
    public var alert: AlertValue?
    public var confirmationDialog: ConfirmationDialogValue?
    public var onAppearEvent: SurfaceEvent?

    public init(
        alignment: ContentAlignment = .center,
        viewIdentity: CustomHostValue? = nil,
        padding: Double? = nil,
        paddingTop: Double? = nil,
        frameMinWidth: Double? = nil,
        frameMinHeight: Double? = nil,
        frameWidth: Double? = nil,
        frameHeight: Double? = nil,
        frameMaxWidth: Bool = false,
        frameMaxHeight: Bool = false,
        frameMaxWidthValue: Double? = nil,
        frameMaxHeightValue: Double? = nil,
        background: ShapeStyleValue? = nil,
        foregroundColor: String? = nil,
        foregroundStyle: ShapeStyleValue? = nil,
        tint: String? = nil,
        cornerRadius: Double? = nil,
        fontStyle: TextStyle? = nil,
        fontSize: Double? = nil,
        fontWeight: FontWeight? = nil,
        symbolRenderingMode: SymbolRenderingMode? = nil,
        buttonStyle: ButtonStyle? = nil,
        buttonBorderShape: ButtonBorderShape? = nil,
        isDisabled: Bool = false,
        glassEffect: Bool = false,
        glassVariant: GlassVariantKind = .regular,
        glassTint: String? = nil,
        navigationTitle: String? = nil,
        navigationBarTitleDisplayMode: NavigationBarTitleDisplayModeKind? = nil,
        navigationLinkIndicatorVisibility: VisibilityKind? = nil,
        toolbarItems: [ToolbarItemValue] = [],
        toolbarBackgroundVisibility: VisibilityKind? = nil,
        toolbarColorScheme: ColorSchemeKind? = nil,
        listStyle: ListStyleKind? = nil,
        scrollContentBackground: VisibilityKind? = nil,
        listRowSeparator: VisibilityKind? = nil,
        listSectionSeparator: VisibilityKind? = nil,
        listRowInsets: EdgeInsetsValue? = nil,
        listRowBackground: ShapeStyleValue? = nil,
        contentMargins: [ContentMarginsValue] = [],
        imageContentMode: ImageContentMode? = nil,
        imageInterpolation: ImageInterpolation? = nil,
        aspectRatio: Double? = nil,
        aspectRatioContentMode: ImageContentMode? = nil,
        fixedSizeHorizontal: Bool = false,
        fixedSizeVertical: Bool = false,
        safeAreaPaddingLength: Double? = nil,
        safeAreaPaddingEdges: EdgeSetKind = .all,
        ignoresSafeArea: Bool = false,
        ignoresSafeAreaEdges: EdgeSetKind = .all,
        safeAreaInsets: [SafeAreaInsetValue] = [],
        lineLimit: Int? = nil,
        multilineTextAlignment: TextAlignmentKind? = nil,
        truncationMode: TruncationModeKind? = nil,
        minimumScaleFactor: Double? = nil,
        presentationDetents: [PresentationDetentValue] = [],
        presentationDragIndicator: VisibilityKind? = nil,
        presentationCornerRadius: Double? = nil,
        presentationBackgroundInteraction: PresentationBackgroundInteractionValue? = nil,
        alert: AlertValue? = nil,
        confirmationDialog: ConfirmationDialogValue? = nil,
        onAppearEvent: SurfaceEvent? = nil
    ) {
        self.alignment = alignment
        self.viewIdentity = viewIdentity
        self.padding = padding
        self.paddingTop = paddingTop
        self.frameMinWidth = frameMinWidth
        self.frameMinHeight = frameMinHeight
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.frameMaxWidth = frameMaxWidth
        self.frameMaxHeight = frameMaxHeight
        self.frameMaxWidthValue = frameMaxWidthValue
        self.frameMaxHeightValue = frameMaxHeightValue
        self.background = background
        self.foregroundColor = foregroundColor
        self.foregroundStyle = foregroundStyle
        self.tint = tint
        self.cornerRadius = cornerRadius
        self.fontStyle = fontStyle
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.symbolRenderingMode = symbolRenderingMode
        self.buttonStyle = buttonStyle
        self.buttonBorderShape = buttonBorderShape
        self.isDisabled = isDisabled
        self.glassEffect = glassEffect
        self.glassVariant = glassVariant
        self.glassTint = glassTint
        self.navigationTitle = navigationTitle
        self.navigationBarTitleDisplayMode = navigationBarTitleDisplayMode
        self.navigationLinkIndicatorVisibility = navigationLinkIndicatorVisibility
        self.toolbarItems = toolbarItems
        self.toolbarBackgroundVisibility = toolbarBackgroundVisibility
        self.toolbarColorScheme = toolbarColorScheme
        self.listStyle = listStyle
        self.scrollContentBackground = scrollContentBackground
        self.listRowSeparator = listRowSeparator
        self.listSectionSeparator = listSectionSeparator
        self.listRowInsets = listRowInsets
        self.listRowBackground = listRowBackground
        self.contentMargins = contentMargins
        self.imageContentMode = imageContentMode
        self.imageInterpolation = imageInterpolation
        self.aspectRatio = aspectRatio
        self.aspectRatioContentMode = aspectRatioContentMode
        self.fixedSizeHorizontal = fixedSizeHorizontal
        self.fixedSizeVertical = fixedSizeVertical
        self.safeAreaPaddingLength = safeAreaPaddingLength
        self.safeAreaPaddingEdges = safeAreaPaddingEdges
        self.ignoresSafeArea = ignoresSafeArea
        self.ignoresSafeAreaEdges = ignoresSafeAreaEdges
        self.safeAreaInsets = safeAreaInsets
        self.lineLimit = lineLimit
        self.multilineTextAlignment = multilineTextAlignment
        self.truncationMode = truncationMode
        self.minimumScaleFactor = minimumScaleFactor
        self.presentationDetents = presentationDetents
        self.presentationDragIndicator = presentationDragIndicator
        self.presentationCornerRadius = presentationCornerRadius
        self.presentationBackgroundInteraction = presentationBackgroundInteraction
        self.alert = alert
        self.confirmationDialog = confirmationDialog
        self.onAppearEvent = onAppearEvent
    }
}

public indirect enum ViewNode: Equatable, Sendable, Identifiable {
    case vStack(
        id: NodeID,
        alignment: ContentAlignment,
        distribution: StackDistribution,
        spacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case hStack(
        id: NodeID,
        alignment: ContentAlignment,
        distribution: StackDistribution,
        spacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case zStack(
        id: NodeID,
        alignment: ContentAlignment,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case grid(
        id: NodeID,
        horizontalSpacing: Double,
        verticalSpacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case flowLayout(
        id: NodeID,
        alignment: ContentAlignment,
        spacing: Double,
        lineSpacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case viewThatFits(
        id: NodeID,
        axis: AxisKind?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case gridRow(
        id: NodeID,
        alignment: ContentAlignment,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case scrollView(
        id: NodeID,
        axis: AxisKind,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case geometryReader(
        id: NodeID,
        modifiers: ViewModifiers
    )
    case custom(
        id: NodeID,
        name: String,
        modifiers: ViewModifiers,
        values: [String: CustomHostValue],
        children: [ViewNode],
        slots: [String: ViewNode]
    )
    case customLayout(
        id: NodeID,
        name: String,
        modifiers: ViewModifiers,
        values: [String: CustomHostValue],
        children: [ViewNode]
    )
    case list(
        id: NodeID,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case form(
        id: NodeID,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case section(
        id: NodeID,
        title: String?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case navigationStack(
        id: NodeID,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case navigationLink(
        id: NodeID,
        modifiers: ViewModifiers,
        destination: ViewNode,
        children: [ViewNode]
    )
    case sheet(
        id: NodeID,
        isPresented: Bool,
        onDismiss: SurfaceEvent?,
        modifiers: ViewModifiers,
        content: ViewNode,
        children: [ViewNode]
    )
    case fullScreenCover(
        id: NodeID,
        isPresented: Bool,
        onDismiss: SurfaceEvent?,
        interactiveDismissDisabled: Bool,
        modifiers: ViewModifiers,
        content: ViewNode,
        children: [ViewNode]
    )
    case tabView(
        id: NodeID,
        selection: PickerSelectionValue?,
        event: SurfaceEvent?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case tab(
        id: NodeID,
        title: String,
        source: ImageSource?,
        badge: BadgeValue?,
        selection: PickerSelectionValue?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case navigationSplitView(
        id: NodeID,
        modifiers: ViewModifiers,
        sidebar: ViewNode,
        detail: ViewNode
    )
    case spacer(
        id: NodeID,
        modifiers: ViewModifiers
    )
    case text(
        id: NodeID,
        value: String,
        modifiers: ViewModifiers
    )
    case label(
        id: NodeID,
        title: String,
        source: ImageSource,
        modifiers: ViewModifiers
    )
    case contentUnavailable(
        id: NodeID,
        title: String,
        source: ImageSource?,
        description: ViewNode?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case image(
        id: NodeID,
        source: ImageSource,
        modifiers: ViewModifiers
    )
    case rectangle(
        id: NodeID,
        fill: ShapeStyleValue?,
        stroke: ShapeStyleValue?,
        lineWidth: Double?,
        modifiers: ViewModifiers
    )
    case roundedRectangle(
        id: NodeID,
        cornerRadius: Double,
        fill: ShapeStyleValue?,
        stroke: ShapeStyleValue?,
        lineWidth: Double?,
        modifiers: ViewModifiers
    )
    case circle(
        id: NodeID,
        fill: ShapeStyleValue?,
        stroke: ShapeStyleValue?,
        lineWidth: Double?,
        modifiers: ViewModifiers
    )
    case capsule(
        id: NodeID,
        fill: ShapeStyleValue?,
        stroke: ShapeStyleValue?,
        lineWidth: Double?,
        modifiers: ViewModifiers
    )
    case ellipse(
        id: NodeID,
        fill: ShapeStyleValue?,
        stroke: ShapeStyleValue?,
        lineWidth: Double?,
        modifiers: ViewModifiers
    )
    case linearGradient(
        id: NodeID,
        value: LinearGradientValue,
        modifiers: ViewModifiers
    )
    case radialGradient(
        id: NodeID,
        value: RadialGradientValue,
        modifiers: ViewModifiers
    )
    case angularGradient(
        id: NodeID,
        value: AngularGradientValue,
        modifiers: ViewModifiers
    )
    case divider(
        id: NodeID,
        modifiers: ViewModifiers
    )
    case button(
        id: NodeID,
        title: String,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case menu(
        id: NodeID,
        title: String,
        modifiers: ViewModifiers,
        content: ViewNode,
        children: [ViewNode]
    )
    case disclosureGroup(
        id: NodeID,
        title: String,
        isExpanded: Bool,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        content: ViewNode,
        children: [ViewNode]
    )
    case controlGroup(
        id: NodeID,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case picker(
        id: NodeID,
        title: String,
        selection: PickerSelectionValue,
        options: [PickerOption],
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case toggle(
        id: NodeID,
        title: String,
        isOn: Bool,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )

    public var id: NodeID {
        switch self {
        case let .vStack(id, _, _, _, _, _),
             let .hStack(id, _, _, _, _, _),
             let .zStack(id, _, _, _),
             let .grid(id, _, _, _, _),
             let .flowLayout(id, _, _, _, _, _),
             let .viewThatFits(id, _, _, _),
             let .gridRow(id, _, _, _),
             let .scrollView(id, _, _, _),
             let .geometryReader(id, _),
             let .custom(id, _, _, _, _, _),
             let .customLayout(id, _, _, _, _),
             let .list(id, _, _),
             let .form(id, _, _),
             let .section(id, _, _, _),
             let .navigationStack(id, _, _),
             let .navigationLink(id, _, _, _),
             let .sheet(id, _, _, _, _, _),
             let .fullScreenCover(id, _, _, _, _, _, _),
             let .tabView(id, _, _, _, _),
             let .tab(id, _, _, _, _, _, _),
             let .navigationSplitView(id, _, _, _),
             let .spacer(id, _),
             let .text(id, _, _),
             let .label(id, _, _, _),
             let .contentUnavailable(id, _, _, _, _, _),
             let .image(id, _, _),
             let .rectangle(id, _, _, _, _),
             let .roundedRectangle(id, _, _, _, _, _),
             let .circle(id, _, _, _, _),
             let .capsule(id, _, _, _, _),
             let .ellipse(id, _, _, _, _),
             let .linearGradient(id, _, _),
             let .radialGradient(id, _, _),
             let .angularGradient(id, _, _),
             let .divider(id, _),
             let .button(id, _, _, _, _),
             let .menu(id, _, _, _, _),
             let .disclosureGroup(id, _, _, _, _, _, _),
             let .controlGroup(id, _, _),
             let .picker(id, _, _, _, _, _, _),
             let .toggle(id, _, _, _, _, _):
            id
        }
    }

    fileprivate var modifiers: ViewModifiers {
        switch self {
        case let .vStack(_, _, _, _, modifiers, _),
             let .hStack(_, _, _, _, modifiers, _),
             let .zStack(_, _, modifiers, _),
             let .grid(_, _, _, modifiers, _),
             let .flowLayout(_, _, _, _, modifiers, _),
             let .viewThatFits(_, _, modifiers, _),
             let .gridRow(_, _, modifiers, _),
             let .scrollView(_, _, modifiers, _),
             let .geometryReader(_, modifiers),
             let .custom(_, _, modifiers, _, _, _),
             let .customLayout(_, _, modifiers, _, _),
             let .list(_, modifiers, _),
             let .form(_, modifiers, _),
             let .section(_, _, modifiers, _),
             let .navigationStack(_, modifiers, _),
             let .navigationLink(_, modifiers, _, _),
             let .sheet(_, _, _, modifiers, _, _),
             let .fullScreenCover(_, _, _, _, modifiers, _, _),
             let .tabView(_, _, _, modifiers, _),
             let .tab(_, _, _, _, _, modifiers, _),
             let .navigationSplitView(_, modifiers, _, _),
             let .spacer(_, modifiers),
             let .text(_, _, modifiers),
             let .label(_, _, _, modifiers),
             let .contentUnavailable(_, _, _, _, modifiers, _),
             let .image(_, _, modifiers),
             let .rectangle(_, _, _, _, modifiers),
             let .roundedRectangle(_, _, _, _, _, modifiers),
             let .circle(_, _, _, _, modifiers),
             let .capsule(_, _, _, _, modifiers),
             let .ellipse(_, _, _, _, modifiers),
             let .linearGradient(_, _, modifiers),
             let .radialGradient(_, _, modifiers),
             let .angularGradient(_, _, modifiers),
             let .divider(_, modifiers),
             let .button(_, _, _, modifiers, _),
             let .menu(_, _, modifiers, _, _),
             let .disclosureGroup(_, _, _, _, modifiers, _, _),
             let .controlGroup(_, modifiers, _),
             let .picker(_, _, _, _, _, modifiers, _),
             let .toggle(_, _, _, _, modifiers, _):
            modifiers
        }
    }

    fileprivate var isGridRow: Bool {
        if case .gridRow = self {
            return true
        }

        return false
    }

    fileprivate var gridColumnCount: Int {
        if case let .gridRow(_, _, _, children) = self {
            return max(children.count, 1)
        }

        return 1
    }

    fileprivate var gridRowChildren: [ViewNode] {
        if case let .gridRow(_, _, _, children) = self {
            return children
        }

        return [self]
    }
}

private struct ViewNodePair {
    let lhs: ViewNode
    let rhs: ViewNode
}

public func ==(lhs: ViewNode, rhs: ViewNode) -> Bool {
    var stack = [ViewNodePair(lhs: lhs, rhs: rhs)]

    while let pair = stack.popLast() {
        switch (pair.lhs, pair.rhs) {
        case let (.vStack(lID, lAlignment, lDistribution, lSpacing, lModifiers, lChildren),
                  .vStack(rID, rAlignment, rDistribution, rSpacing, rModifiers, rChildren)):
            guard lID == rID,
                  lAlignment == rAlignment,
                  lDistribution == rDistribution,
                  lSpacing == rSpacing,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.hStack(lID, lAlignment, lDistribution, lSpacing, lModifiers, lChildren),
                  .hStack(rID, rAlignment, rDistribution, rSpacing, rModifiers, rChildren)):
            guard lID == rID,
                  lAlignment == rAlignment,
                  lDistribution == rDistribution,
                  lSpacing == rSpacing,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.zStack(lID, lAlignment, lModifiers, lChildren),
                  .zStack(rID, rAlignment, rModifiers, rChildren)):
            guard lID == rID,
                  lAlignment == rAlignment,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.grid(lID, lHorizontalSpacing, lVerticalSpacing, lModifiers, lChildren),
                  .grid(rID, rHorizontalSpacing, rVerticalSpacing, rModifiers, rChildren)):
            guard lID == rID,
                  lHorizontalSpacing == rHorizontalSpacing,
                  lVerticalSpacing == rVerticalSpacing,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.flowLayout(lID, lAlignment, lSpacing, lLineSpacing, lModifiers, lChildren),
                  .flowLayout(rID, rAlignment, rSpacing, rLineSpacing, rModifiers, rChildren)):
            guard lID == rID,
                  lAlignment == rAlignment,
                  lSpacing == rSpacing,
                  lLineSpacing == rLineSpacing,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.viewThatFits(lID, lAxis, lModifiers, lChildren),
                  .viewThatFits(rID, rAxis, rModifiers, rChildren)):
            guard lID == rID,
                  lAxis == rAxis,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.gridRow(lID, lAlignment, lModifiers, lChildren),
                  .gridRow(rID, rAlignment, rModifiers, rChildren)):
            guard lID == rID,
                  lAlignment == rAlignment,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.scrollView(lID, lAxis, lModifiers, lChildren),
                  .scrollView(rID, rAxis, rModifiers, rChildren)):
            guard lID == rID,
                  lAxis == rAxis,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.geometryReader(lID, lModifiers),
                  .geometryReader(rID, rModifiers)):
            guard lID == rID, lModifiers == rModifiers else { return false }
        case let (.custom(lID, lName, lModifiers, lValues, lChildren, lSlots),
                  .custom(rID, rName, rModifiers, rValues, rChildren, rSlots)):
            guard lID == rID,
                  lName == rName,
                  lModifiers == rModifiers,
                  lValues == rValues,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack),
                  enqueueSlots(lhs: lSlots, rhs: rSlots, into: &stack)
            else { return false }
        case let (.customLayout(lID, lName, lModifiers, lValues, lChildren),
                  .customLayout(rID, rName, rModifiers, rValues, rChildren)):
            guard lID == rID,
                  lName == rName,
                  lModifiers == rModifiers,
                  lValues == rValues,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.list(lID, lModifiers, lChildren),
                  .list(rID, rModifiers, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.form(lID, lModifiers, lChildren),
                  .form(rID, rModifiers, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.section(lID, lTitle, lModifiers, lChildren),
                  .section(rID, rTitle, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.navigationStack(lID, lModifiers, lChildren),
                  .navigationStack(rID, rModifiers, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.navigationLink(lID, lModifiers, lDestination, lChildren),
                  .navigationLink(rID, rModifiers, rDestination, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
            stack.append(.init(lhs: lDestination, rhs: rDestination))
        case let (.sheet(lID, lIsPresented, lOnDismiss, lModifiers, lContent, lChildren),
                  .sheet(rID, rIsPresented, rOnDismiss, rModifiers, rContent, rChildren)):
            guard lID == rID,
                  lIsPresented == rIsPresented,
                  lOnDismiss == rOnDismiss,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
            stack.append(.init(lhs: lContent, rhs: rContent))
        case let (.fullScreenCover(lID, lIsPresented, lOnDismiss, lInteractiveDismissDisabled, lModifiers, lContent, lChildren),
                  .fullScreenCover(rID, rIsPresented, rOnDismiss, rInteractiveDismissDisabled, rModifiers, rContent, rChildren)):
            guard lID == rID,
                  lIsPresented == rIsPresented,
                  lOnDismiss == rOnDismiss,
                  lInteractiveDismissDisabled == rInteractiveDismissDisabled,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
            stack.append(.init(lhs: lContent, rhs: rContent))
        case let (.tabView(lID, lSelection, lEvent, lModifiers, lChildren),
                  .tabView(rID, rSelection, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lSelection == rSelection,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.tab(lID, lTitle, lSource, lBadge, lSelection, lModifiers, lChildren),
                  .tab(rID, rTitle, rSource, rBadge, rSelection, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lSource == rSource,
                  lBadge == rBadge,
                  lSelection == rSelection,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.navigationSplitView(lID, lModifiers, lSidebar, lDetail),
                  .navigationSplitView(rID, rModifiers, rSidebar, rDetail)):
            guard lID == rID, lModifiers == rModifiers else { return false }
            stack.append(.init(lhs: lSidebar, rhs: rSidebar))
            stack.append(.init(lhs: lDetail, rhs: rDetail))
        case let (.spacer(lID, lModifiers),
                  .spacer(rID, rModifiers)):
            guard lID == rID, lModifiers == rModifiers else { return false }
        case let (.text(lID, lValue, lModifiers),
                  .text(rID, rValue, rModifiers)):
            guard lID == rID, lValue == rValue, lModifiers == rModifiers else { return false }
        case let (.label(lID, lTitle, lSource, lModifiers),
                  .label(rID, rTitle, rSource, rModifiers)):
            guard lID == rID, lTitle == rTitle, lSource == rSource, lModifiers == rModifiers else { return false }
        case let (.image(lID, lSource, lModifiers),
                  .image(rID, rSource, rModifiers)):
            guard lID == rID, lSource == rSource, lModifiers == rModifiers else { return false }
        case let (.rectangle(lID, lFill, lStroke, lLineWidth, lModifiers),
                  .rectangle(rID, rFill, rStroke, rLineWidth, rModifiers)):
            guard lID == rID, lFill == rFill, lStroke == rStroke, lLineWidth == rLineWidth, lModifiers == rModifiers else { return false }
        case let (.roundedRectangle(lID, lCornerRadius, lFill, lStroke, lLineWidth, lModifiers),
                  .roundedRectangle(rID, rCornerRadius, rFill, rStroke, rLineWidth, rModifiers)):
            guard lID == rID, lCornerRadius == rCornerRadius, lFill == rFill, lStroke == rStroke, lLineWidth == rLineWidth, lModifiers == rModifiers else { return false }
        case let (.circle(lID, lFill, lStroke, lLineWidth, lModifiers),
                  .circle(rID, rFill, rStroke, rLineWidth, rModifiers)):
            guard lID == rID, lFill == rFill, lStroke == rStroke, lLineWidth == rLineWidth, lModifiers == rModifiers else { return false }
        case let (.capsule(lID, lFill, lStroke, lLineWidth, lModifiers),
                  .capsule(rID, rFill, rStroke, rLineWidth, rModifiers)):
            guard lID == rID, lFill == rFill, lStroke == rStroke, lLineWidth == rLineWidth, lModifiers == rModifiers else { return false }
        case let (.ellipse(lID, lFill, lStroke, lLineWidth, lModifiers),
                  .ellipse(rID, rFill, rStroke, rLineWidth, rModifiers)):
            guard lID == rID, lFill == rFill, lStroke == rStroke, lLineWidth == rLineWidth, lModifiers == rModifiers else { return false }
        case let (.linearGradient(lID, lValue, lModifiers),
                  .linearGradient(rID, rValue, rModifiers)):
            guard lID == rID, lValue == rValue, lModifiers == rModifiers else { return false }
        case let (.radialGradient(lID, lValue, lModifiers),
                  .radialGradient(rID, rValue, rModifiers)):
            guard lID == rID, lValue == rValue, lModifiers == rModifiers else { return false }
        case let (.angularGradient(lID, lValue, lModifiers),
                  .angularGradient(rID, rValue, rModifiers)):
            guard lID == rID, lValue == rValue, lModifiers == rModifiers else { return false }
        case let (.divider(lID, lModifiers),
                  .divider(rID, rModifiers)):
            guard lID == rID, lModifiers == rModifiers else { return false }
        case let (.button(lID, lTitle, lEvent, lModifiers, lChildren),
                  .button(rID, rTitle, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.menu(lID, lTitle, lModifiers, lContent, lChildren),
                  .menu(rID, rTitle, rModifiers, rContent, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
            stack.append(.init(lhs: lContent, rhs: rContent))
        case let (.disclosureGroup(lID, lTitle, lIsExpanded, lEvent, lModifiers, lContent, lChildren),
                  .disclosureGroup(rID, rTitle, rIsExpanded, rEvent, rModifiers, rContent, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lIsExpanded == rIsExpanded,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
            stack.append(.init(lhs: lContent, rhs: rContent))
        case let (.controlGroup(lID, lModifiers, lChildren),
                  .controlGroup(rID, rModifiers, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.picker(lID, lTitle, lSelection, lOptions, lEvent, lModifiers, lChildren),
                  .picker(rID, rTitle, rSelection, rOptions, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lSelection == rSelection,
                  lOptions == rOptions,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.toggle(lID, lTitle, lIsOn, lEvent, lModifiers, lChildren),
                  .toggle(rID, rTitle, rIsOn, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lIsOn == rIsOn,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        default:
            return false
        }
    }

    return true
}

private func enqueueChildren(lhs: [ViewNode], rhs: [ViewNode], into stack: inout [ViewNodePair]) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }

    for (lhsChild, rhsChild) in zip(lhs, rhs) {
        stack.append(.init(lhs: lhsChild, rhs: rhsChild))
    }

    return true
}

private func enqueueSlots(lhs: [String: ViewNode], rhs: [String: ViewNode], into stack: inout [ViewNodePair]) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }

    for (key, lhsValue) in lhs {
        guard let rhsValue = rhs[key] else {
            return false
        }

        stack.append(.init(lhs: lhsValue, rhs: rhsValue))
    }

    return true
}

public enum JSScriptSource {
    case string(String)
    case file(URL)
    case bundleResource(name: String, extension: String, bundle: Bundle)

    fileprivate func load() throws -> String {
        switch self {
        case let .string(source):
            return source
        case let .file(url):
            return try String(contentsOf: url, encoding: .utf8)
        case let .bundleResource(name, ext, bundle):
            guard let url = bundle.url(forResource: name, withExtension: ext) else {
                throw JSSurfaceError.missingScriptResource(name: name, ext: ext, bundlePath: bundle.bundlePath)
            }

            return try String(contentsOf: url, encoding: .utf8)
        }
    }
}

public struct SurfaceView: View {
    private let root: ViewNode
    private let onEvent: (SurfaceEvent) -> Void
    private let customHostRegistry: CustomHostRegistry

    public init(root: ViewNode, onEvent: @escaping (SurfaceEvent) -> Void, customHostRegistry: CustomHostRegistry = .init()) {
        self.root = root
        self.onEvent = onEvent
        self.customHostRegistry = customHostRegistry
    }

    public var body: some View {
        RenderNodeView(node: root, onEvent: onEvent, customHostRegistry: customHostRegistry)
    }
}

public enum SwiftJSTypeScriptPackage {
    public static var packageRootURL: URL? {
        Bundle.module
            .url(forResource: "package", withExtension: "json")?
            .deletingLastPathComponent()
    }

    public static func apiReferenceSkillBody() -> String? {
        guard let files = orderedSourceFiles(), !files.isEmpty else {
            return nil
        }

        var sections = [
            "Read these files before building or editing the app UI.",
            "They define the SwiftJS TSX API surface used by the app.",
        ]

        for (name, contents) in files {
            sections.append(
                """
                ## \(name)

                ```ts
                \(contents)
                ```
                """
            )
        }

        return sections.joined(separator: "\n\n")
    }

    private static func orderedSourceFiles() -> [(String, String)]? {
        guard let directoryURL = packageRootURL,
              let fileNames = try? FileManager.default.contentsOfDirectory(atPath: directoryURL.path)
        else {
            return nil
        }

        let orderedNames = fileNames
            .filter { $0.hasSuffix(".ts") && $0 != "jsx-runtime.ts" }
            .sorted { lhs, rhs in
                let preferredOrder = ["types.ts", "index.ts"]
                let lhsIndex = preferredOrder.firstIndex(of: lhs)
                let rhsIndex = preferredOrder.firstIndex(of: rhs)

                switch (lhsIndex, rhsIndex) {
                case let (.some(l), .some(r)):
                    return l < r
                case (.some, .none):
                    return true
                case (.none, .some):
                    return false
                case (.none, .none):
                    return lhs < rhs
                }
            }

        let contents = orderedNames.compactMap { name -> (String, String)? in
            let url = directoryURL.appendingPathComponent(name, isDirectory: false)
            guard let string = try? String(contentsOf: url, encoding: .utf8) else {
                return nil
            }
            return (name, string)
        }

        return contents.isEmpty ? nil : contents
    }
}

public struct JSSurfaceView: View {
    @Bindable private var runtime: JSSurfaceRuntime

    public init(runtime: JSSurfaceRuntime) {
        self.runtime = runtime
    }

    public var body: some View {
        let _ = runtime.rootVersion
        Group {
            if let rootNode = runtime.rootNode {
                SurfaceView(root: rootNode, onEvent: runtime.dispatch, customHostRegistry: runtime.customHostRegistry)
            } else if let errorMessage = runtime.errorMessage {
                ContentUnavailableView("SwiftJS Error", systemImage: "exclamationmark.triangle", description: Text(errorMessage))
            } else {
                ProgressView()
            }
        }
        .task {
            runtime.start()
        }
    }
}

@Observable
@MainActor
public final class JSSurfaceRuntime {
    @ObservationIgnored private var currentRootNode: ViewNode?
    @ObservationIgnored private var lastTreePayload: String?
    public private(set) var rootVersion = 0
    public private(set) var errorMessage: String?
    public private(set) var customHostRegistry: CustomHostRegistry

    private let source: JSScriptSource
    private let modulesByName: [String: any JSRuntimeModule]
    private var context: JSContext
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private var didStart = false
    private var activeLayoutMeasurementStack: [(Int, ProposedViewSize) -> CGSize] = []

    public var rootNode: ViewNode? {
        currentRootNode
    }

    public init(
        source: JSScriptSource,
        customHostRegistry: CustomHostRegistry = .init(),
        modules: [any JSRuntimeModule] = []
    ) {
        self.source = source
        self.customHostRegistry = customHostRegistry
        self.modulesByName = Self.makeModulesByName(modules)
        self.context = Self.makeContext()
        initializeContext()
    }

    public func start() {
        guard !didStart else {
            return
        }

        didStart = true

        do {
            try evaluateRuntime()
            try evaluateApplication()
        } catch {
            didStart = false
            report(error)
        }
    }

    public func validate() throws {
        start()

        if let errorMessage, !errorMessage.isEmpty {
            throw JSSurfaceError.invalidTree(errorMessage)
        }

        guard rootNode != nil else {
            throw JSSurfaceError.missingRootNode
        }
    }

    public func dispatch(_ event: SurfaceEvent) {
        guard didStart else {
            return
        }

        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let dispatch = runtime?.objectForKeyedSubscript("dispatchEvent")

        if let payloadJSON = event.payloadJSON {
            dispatch?.call(withArguments: [event.name, payloadJSON])
        } else {
            dispatch?.call(withArguments: [event.name])
        }

        if let exception = context.exception?.toString(), !exception.isEmpty {
            errorMessage = exception
        }
    }

    public func reload() {
        currentRootNode = nil
        lastTreePayload = nil
        errorMessage = nil
        didStart = false
        context = Self.makeContext()
        initializeContext()
        start()
    }

    private func initializeContext() {
        installBridge()
        installGeometryReaderBridge()
        installJavaScriptLayoutBridge()
    }

    private func installBridge() {
        context.exceptionHandler = { [weak self] _, exception in
            guard let message = exception?.toString(), !message.isEmpty else {
                self?.errorMessage = "Unknown JavaScript error"
                return
            }

            self?.errorMessage = message
        }

        let commit: @convention(block) (String) -> Void = { [weak self] payload in
            self?.applyTreeJSON(payload)
        }

        let report: @convention(block) (String) -> Void = { [weak self] message in
            self?.errorMessage = message
        }

        let log: @convention(block) (String) -> Void = { message in
            print("[SwiftJS] \(message)")
        }

        let storageGet: @convention(block) (String) -> String? = { key in
            UserDefaults.standard.string(forKey: key)
        }

        let storageSet: @convention(block) (String, String) -> Void = { key, payloadJSON in
            UserDefaults.standard.set(payloadJSON, forKey: key)
        }

        let invokeModule: @convention(block) (String, String, String, String?) -> Void = { [weak self] callID, moduleName, methodName, payloadJSON in
            self?.invokeModuleCall(callID: callID, moduleName: moduleName, methodName: methodName, payloadJSON: payloadJSON)
        }

        let console = JSValue(newObjectIn: context)
        console?.setObject(log, forKeyedSubscript: "log" as NSString)

        context.setObject(commit, forKeyedSubscript: "__swiftjs_commit" as NSString)
        context.setObject(report, forKeyedSubscript: "__swiftjs_reportError" as NSString)
        context.setObject(invokeModule, forKeyedSubscript: "__swiftjs_invokeModule" as NSString)
        context.setObject(storageGet, forKeyedSubscript: "__swiftjs_storage_get" as NSString)
        context.setObject(storageSet, forKeyedSubscript: "__swiftjs_storage_set" as NSString)
        context.setObject(console, forKeyedSubscript: "console" as NSString)
    }

    private func installGeometryReaderBridge() {
        customHostRegistry = customHostRegistry.withGeometryReaderBridge(
            GeometryReaderBridge(
                hasHandler: { [weak self] id in
                    self?.hasGeometryReaderHandler(id: id) ?? false
                },
                render: { [weak self] id, size in
                    self?.callJavaScriptGeometryReader(id: id, size: size)
                }
            )
        )
    }

    private func installJavaScriptLayoutBridge() {
        customHostRegistry = customHostRegistry.withJavaScriptLayoutBridge(
            JavaScriptLayoutBridge(
                hasLayoutHandler: { [weak self] id in
                    self?.hasJavaScriptLayoutHandler(id: id) ?? false
                },
                sizeThatFits: { [weak self] id, proposal, subviewCount, measureSubview in
                    self?.callJavaScriptLayoutSizeThatFits(
                        id: id,
                        proposal: proposal,
                        subviewCount: subviewCount,
                        measureSubview: measureSubview
                    )
                },
                placeSubviews: { [weak self] id, bounds, proposal, subviewCount, measureSubview in
                    self?.callJavaScriptLayoutPlaceSubviews(
                        id: id,
                        bounds: bounds,
                        proposal: proposal,
                        subviewCount: subviewCount,
                        measureSubview: measureSubview
                    )
                }
            )
        )

        let subviewSizeThatFits: @convention(block) (Int, String) -> String = { [weak self] index, proposalJSON in
            self?.javaScriptLayoutSubviewSizeThatFits(index: index, proposalJSON: proposalJSON) ?? #"{"width":0,"height":0}"#
        }

        context.setObject(subviewSizeThatFits, forKeyedSubscript: "__swiftjs_layout_subviewSizeThatFits" as NSString)
    }

    private static func makeContext() -> JSContext {
        guard let context = JSContext() else {
            fatalError("JavaScriptCore context could not be created")
        }

        return context
    }

    private static func makeModulesByName(_ modules: [any JSRuntimeModule]) -> [String: any JSRuntimeModule] {
        var byName: [String: any JSRuntimeModule] = [:]

        for module in modules {
            if byName.updateValue(module, forKey: module.name) != nil {
                preconditionFailure(JSRuntimeModuleError.duplicateModuleName(module.name).localizedDescription)
            }
        }

        return byName
    }

    private func invokeModuleCall(callID: String, moduleName: String, methodName: String, payloadJSON: String?) {
        guard let module = modulesByName[moduleName] else {
            rejectModuleCall(callID: callID, message: JSRuntimeModuleError.missingModule(moduleName).localizedDescription)
            return
        }

        MainActor.assumeIsolated {
            module.invoke(method: methodName, payloadJSON: payloadJSON) { [weak self] result in
                guard let self else {
                    return
                }

                switch result {
                case let .success(responseJSON):
                    self.resolveModuleCall(callID: callID, payloadJSON: responseJSON)
                case let .failure(error):
                    self.rejectModuleCall(callID: callID, message: error.localizedDescription)
                }
            }
        }
    }

    private func resolveModuleCall(callID: String, payloadJSON: String?) {
        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let resolve = runtime?.objectForKeyedSubscript("resolveModuleCall")
        resolve?.call(withArguments: [callID, payloadJSON ?? NSNull()])

        if let exception = context.exception?.toString(), !exception.isEmpty {
            errorMessage = exception
        }
    }

    private func rejectModuleCall(callID: String, message: String) {
        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let reject = runtime?.objectForKeyedSubscript("rejectModuleCall")
        reject?.call(withArguments: [callID, message])

        if let exception = context.exception?.toString(), !exception.isEmpty {
            errorMessage = exception
        }
    }

    private func evaluateRuntime() throws {
        guard let runtimeURL = Bundle.module.url(forResource: "SwiftJSRuntime", withExtension: "js") else {
            throw JSSurfaceError.missingPackagedRuntime
        }

        let runtimeSource = try String(contentsOf: runtimeURL, encoding: .utf8)
        context.evaluateScript(runtimeSource)

        if let exception = context.exception?.toString(), !exception.isEmpty {
            throw JSSurfaceError.javaScriptException(exception)
        }
    }

    private func evaluateApplication() throws {
        let source = try source.load()
        context.exception = nil
        context.evaluateScript(source)

        if let exception = context.exception?.toString(), !exception.isEmpty {
            throw JSSurfaceError.javaScriptException(exception)
        }

        if rootNode == nil {
            throw JSSurfaceError.missingRootNode
        }
    }

    private func applyTreeJSON(_ payload: String) {
        if lastTreePayload == payload {
            return
        }

        do {
            let data = Data(payload.utf8)
            let hostNode = try decoder.decode(HostNode.self, from: data)
            currentRootNode = try hostNode.makeViewNode()
            lastTreePayload = payload
            rootVersion += 1
            errorMessage = nil
        } catch {
            report(error)
        }
    }

    private func report(_ error: Error) {
        let message = (error as? LocalizedError)?.errorDescription ?? String(describing: error)
        errorMessage = message
    }

    private func hasJavaScriptLayoutHandler(id: NodeID) -> Bool {
        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let function = runtime?.objectForKeyedSubscript("hasLayoutHandler")
        let result = function?.call(withArguments: [id.rawValue])

        if let exception = context.exception?.toString(), !exception.isEmpty {
            errorMessage = exception
            return false
        }

        return result?.toBool() ?? false
    }

    private func hasGeometryReaderHandler(id: NodeID) -> Bool {
        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let function = runtime?.objectForKeyedSubscript("hasGeometryReaderHandler")
        let result = function?.call(withArguments: [id.rawValue])

        if let exception = context.exception?.toString(), !exception.isEmpty {
            errorMessage = exception
            return false
        }

        return result?.toBool() ?? false
    }

    private func callJavaScriptGeometryReader(id: NodeID, size: CGSize) -> ViewNode? {
        callJavaScriptLayout(
            functionName: "renderGeometryReader",
            arguments: [
                id.rawValue,
                encodeJSONObject(JavaScriptLayoutSize(size)) ?? "{}"
            ],
            decode: HostNode.self
        ).flatMap { hostNode in
            do {
                return try hostNode.makeViewNode()
            } catch {
                report(error)
                return nil
            }
        }
    }

    private func callJavaScriptLayoutSizeThatFits(
        id: NodeID,
        proposal: ProposedViewSize,
        subviewCount: Int,
        measureSubview: @escaping (Int, ProposedViewSize) -> CGSize
    ) -> CGSize? {
        callWithLayoutMeasurementContext(measureSubview) {
            callJavaScriptLayout(
                functionName: "measureLayout",
                arguments: [
                    id.rawValue,
                    encodeJSONObject(JavaScriptLayoutSize(proposal)) ?? "{}",
                    subviewCount
                ],
                decode: JavaScriptLayoutSize.self
            )?.cgSize
        }
    }

    private func callJavaScriptLayoutPlaceSubviews(
        id: NodeID,
        bounds: CGRect,
        proposal: ProposedViewSize,
        subviewCount: Int,
        measureSubview: @escaping (Int, ProposedViewSize) -> CGSize
    ) -> [JavaScriptSubviewPlacement]? {
        callWithLayoutMeasurementContext(measureSubview) {
            callJavaScriptLayout(
                functionName: "placeLayoutSubviews",
                arguments: [
                    id.rawValue,
                    encodeJSONObject(JavaScriptLayoutBounds(bounds)) ?? "{}",
                    encodeJSONObject(JavaScriptLayoutSize(proposal)) ?? "{}",
                    subviewCount
                ],
                decode: [JavaScriptSubviewPlacement].self
            )
        }
    }

    private func javaScriptLayoutSubviewSizeThatFits(index: Int, proposalJSON: String) -> String {
        guard let measureSubview = activeLayoutMeasurementStack.last else {
            return #"{"width":0,"height":0}"#
        }

        do {
            let proposal = try decoder.decode(JavaScriptLayoutSize.self, from: Data(proposalJSON.utf8))
            let size = measureSubview(index, proposal.proposedViewSize)
            return encodeJSONObject(JavaScriptLayoutSize(size)) ?? #"{"width":0,"height":0}"#
        } catch {
            return #"{"width":0,"height":0}"#
        }
    }

    private func callWithLayoutMeasurementContext<Value>(
        _ measureSubview: @escaping (Int, ProposedViewSize) -> CGSize,
        perform: () -> Value
    ) -> Value {
        activeLayoutMeasurementStack.append(measureSubview)
        defer { _ = activeLayoutMeasurementStack.popLast() }
        return perform()
    }

    private func callJavaScriptLayout<Response: Decodable>(
        functionName: String,
        arguments: [Any],
        decode: Response.Type
    ) -> Response? {
        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let function = runtime?.objectForKeyedSubscript(functionName)
        let result = function?.call(withArguments: arguments)

        if let exception = context.exception?.toString(), !exception.isEmpty {
            errorMessage = exception
            return nil
        }

        guard let json = result?.toString(), !json.isEmpty else {
            return nil
        }

        do {
            return try decoder.decode(Response.self, from: Data(json.utf8))
        } catch {
            report(error)
            return nil
        }
    }

    private func encodeJSONObject<Value: Encodable>(_ value: Value) -> String? {
        do {
            let data = try encoder.encode(value)
            return String(data: data, encoding: .utf8)
        } catch {
            report(error)
            return nil
        }
    }
}

enum JSRuntimeModuleError: LocalizedError {
    case duplicateModuleName(String)
    case missingModule(String)

    var errorDescription: String? {
        switch self {
        case let .duplicateModuleName(name):
            return "Duplicate SwiftJS module '\(name)'"
        case let .missingModule(name):
            return "Missing SwiftJS module '\(name)'"
        }
    }
}

private struct RenderNodeView: View {
    let node: ViewNode
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        switch node {
        case let .vStack(_, alignment, distribution, spacing, _, children):
            applyCommonModifiers(
                vStackView(alignment: alignment, distribution: distribution, spacing: spacing, children: children)
            )
        case let .hStack(_, alignment, distribution, spacing, modifiers, children):
            applyCommonModifiers(
                hStackView(alignment: alignment, distribution: distribution, spacing: spacing, modifiers: modifiers, children: children)
            )
        case let .zStack(_, alignment, _, children):
            applyCommonModifiers(
                ZStack(alignment: alignment.swiftUIAlignment) {
                    ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            )
        case let .grid(_, horizontalSpacing, verticalSpacing, _, children):
            applyCommonModifiers(
                gridView(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing, children: children)
            )
        case let .flowLayout(_, alignment, spacing, lineSpacing, _, children):
            applyCommonModifiers(
                flowLayoutView(alignment: alignment, spacing: spacing, lineSpacing: lineSpacing, children: children)
            )
        case let .viewThatFits(_, axis, _, children):
            applyCommonModifiers(
                viewThatFitsView(axis: axis, children: children)
            )
        case let .gridRow(_, alignment, modifiers, children):
            applyCommonModifiers(
                gridRowView(alignment: alignment, modifiers: modifiers, children: children)
            )
        case let .scrollView(_, axis, _, children):
            applyCommonModifiers(
                scrollView(axis: axis, children: children)
            )
        case let .geometryReader(id, _):
            applyCommonModifiers(
                geometryReaderView(id: id)
            )
        case let .custom(id, name, _, values, children, slots):
            applyCommonModifiers(
                customView(id: id, name: name, values: values, children: children, slots: slots)
            )
        case let .customLayout(id, name, _, values, children):
            applyCommonModifiers(
                customLayoutView(id: id, name: name, values: values, children: children)
            )
        case let .list(_, modifiers, children):
            listView(children: children, modifiers: modifiers)
        case let .form(_, _, children):
            applyCommonModifiers(
                formView(children: children)
            )
        case let .section(_, title, _, children):
            applyCommonModifiers(
                sectionView(title: title, children: children)
            )
        case let .navigationStack(_, _, children):
            applyCommonModifiers(
                navigationStackView(children: children)
            )
        case let .navigationLink(_, modifiers, destination, children):
            applyCommonModifiers(
                navigationLinkView(destination: destination, modifiers: modifiers, children: children)
            )
        case let .sheet(_, isPresented, onDismiss, modifiers, content, children):
            applyCommonModifiers(
                sheetView(isPresented: isPresented, onDismiss: onDismiss, content: content, children: children, modifiers: modifiers)
            )
        case let .fullScreenCover(_, isPresented, onDismiss, interactiveDismissDisabled, modifiers, content, children):
            applyCommonModifiers(
                fullScreenCoverView(
                    isPresented: isPresented,
                    onDismiss: onDismiss,
                    interactiveDismissDisabled: interactiveDismissDisabled,
                    content: content,
                    children: children,
                    modifiers: modifiers
                )
            )
        case let .tabView(_, selection, event, _, children):
            applyCommonModifiers(
                tabView(selection: selection, event: event, children: children)
            )
        case let .tab(_, _, _, _, _, _, children):
            applyCommonModifiers(
                tabContent(children: children)
            )
        case let .navigationSplitView(_, _, sidebar, detail):
            applyCommonModifiers(
                navigationSplitView(sidebar: sidebar, detail: detail)
            )
        case .spacer:
            applyCommonModifiers(Spacer())
        case let .text(_, value, modifiers):
            applyCommonModifiers(
                textView(value, modifiers: modifiers)
            )
        case let .label(_, title, source, modifiers):
            applyCommonModifiers(
                labelView(title: title, source: source, modifiers: modifiers)
            )
        case let .contentUnavailable(_, title, source, description, modifiers, children):
            applyCommonModifiers(
                contentUnavailableView(
                    title: title,
                    source: source,
                    description: description,
                    modifiers: modifiers,
                    children: children
                )
            )
        case let .image(_, source, modifiers):
            applyCommonModifiers(
                imageView(source, modifiers: modifiers)
            )
        case let .rectangle(_, fill, stroke, lineWidth, modifiers):
            applyCommonModifiers(
                shapeView(Rectangle(), fill: fill, stroke: stroke, lineWidth: lineWidth, modifiers: modifiers)
            )
        case let .roundedRectangle(_, cornerRadius, fill, stroke, lineWidth, modifiers):
            applyCommonModifiers(
                shapeView(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous),
                    fill: fill,
                    stroke: stroke,
                    lineWidth: lineWidth,
                    modifiers: modifiers
                )
            )
        case let .circle(_, fill, stroke, lineWidth, modifiers):
            applyCommonModifiers(
                shapeView(Circle(), fill: fill, stroke: stroke, lineWidth: lineWidth, modifiers: modifiers)
            )
        case let .capsule(_, fill, stroke, lineWidth, modifiers):
            applyCommonModifiers(
                shapeView(Capsule(), fill: fill, stroke: stroke, lineWidth: lineWidth, modifiers: modifiers)
            )
        case let .ellipse(_, fill, stroke, lineWidth, modifiers):
            applyCommonModifiers(
                shapeView(Ellipse(), fill: fill, stroke: stroke, lineWidth: lineWidth, modifiers: modifiers)
            )
        case let .linearGradient(_, value, _):
            applyCommonModifiers(linearGradientView(value))
        case let .radialGradient(_, value, _):
            applyCommonModifiers(radialGradientView(value))
        case let .angularGradient(_, value, _):
            applyCommonModifiers(angularGradientView(value))
        case .divider:
            applyCommonModifiers(Divider())
        case let .button(_, title, event, modifiers, children):
            applyCommonModifiers(
                buttonView(title, event: event, modifiers: modifiers, children: children)
            )
        case let .menu(_, title, modifiers, content, children):
            applyCommonModifiers(
                menuView(title, content: content, modifiers: modifiers, children: children)
            )
        case let .disclosureGroup(_, title, isExpanded, event, modifiers, content, children):
            applyCommonModifiers(
                disclosureGroupView(
                    title,
                    isExpanded: isExpanded,
                    event: event,
                    modifiers: modifiers,
                    content: content,
                    children: children
                )
            )
        case let .controlGroup(_, _, children):
            applyCommonModifiers(
                controlGroupView(children: children)
            )
        case let .picker(_, title, selection, options, event, modifiers, children):
            applyCommonModifiers(
                pickerView(title, selection: selection, options: options, event: event, modifiers: modifiers, children: children)
            )
        case let .toggle(_, title, isOn, event, modifiers, children):
            applyCommonModifiers(
                toggleView(title, isOn: isOn, event: event, modifiers: modifiers, children: children)
            )
        }
    }

    @ViewBuilder
    private func gridRowView(alignment: ContentAlignment, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        GridRow {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func gridView(horizontalSpacing: Double, verticalSpacing: Double, children: [ViewNode]) -> some View {
        let maxColumns = max(children.map(\.gridColumnCount).max() ?? 1, 1)

        Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
            ForEach(children) { child in
                if child.isGridRow {
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } else {
                    GridRow {
                        RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                            .gridCellColumns(maxColumns)
                    }
                }
            }
        }
    }

    private func flowLayoutView(alignment: ContentAlignment, spacing: Double, lineSpacing: Double, children: [ViewNode]) -> some View {
        SwiftJSFlowLayout(
            alignment: alignment,
            spacing: spacing,
            lineSpacing: lineSpacing
        ) {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func viewThatFitsView(axis: AxisKind?, children: [ViewNode]) -> some View {
        if let axis {
            ViewThatFits(in: axis.swiftUIAxisSet) {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        } else {
            ViewThatFits {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
    }

    @ViewBuilder
    private func customView(id: NodeID, name: String, values: [String: CustomHostValue], children: [ViewNode], slots: [String: ViewNode]) -> some View {
        if let renderer = customHostRegistry.renderer(named: name) {
            renderer(
                CustomHostContext(
                    id: id,
                    name: name,
                    values: values,
                    children: children,
                    slots: slots
                ),
                onEvent,
                customHostRegistry
            )
        } else {
            Text("Missing custom host: \(name)")
        }
    }

    @ViewBuilder
    private func geometryReaderView(id: NodeID) -> some View {
        if let geometryReaderBridge = customHostRegistry.geometryReaderBridge, geometryReaderBridge.hasHandler(id) {
            GeometryReader { geometry in
                if let node = geometryReaderBridge.render(id, geometry.size) {
                    RenderNodeView(node: node, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                } else {
                    Color.clear
                }
            }
        } else {
            Text("Missing GeometryReader handler: \(id.rawValue)")
        }
    }

    private func linearGradientView(_ value: LinearGradientValue) -> some View {
        LinearGradient(
            gradient: value.swiftUIGradient,
            startPoint: value.startPoint.swiftUIUnitPoint,
            endPoint: value.endPoint.swiftUIUnitPoint
        )
    }

    private func radialGradientView(_ value: RadialGradientValue) -> some View {
        RadialGradient(
            gradient: value.swiftUIGradient,
            center: value.center.swiftUIUnitPoint,
            startRadius: value.startRadius,
            endRadius: value.endRadius
        )
    }

    @ViewBuilder
    private func angularGradientView(_ value: AngularGradientValue) -> some View {
        if let angle = value.angle {
            AngularGradient(
                gradient: value.swiftUIGradient,
                center: value.center.swiftUIUnitPoint,
                angle: .degrees(angle)
            )
        } else {
            AngularGradient(
                gradient: value.swiftUIGradient,
                center: value.center.swiftUIUnitPoint,
                startAngle: .degrees(value.startAngle ?? 0),
                endAngle: .degrees(value.endAngle ?? 360)
            )
        }
    }

    @ViewBuilder
    private func shapeView<S: Shape>(
        _ shape: S,
        fill: ShapeStyleValue?,
        stroke: ShapeStyleValue?,
        lineWidth: Double?,
        modifiers: ViewModifiers
    ) -> some View {
        let fillStyle = fill?.swiftUIShapeStyle ?? modifiers.foregroundShapeStyle
        let width = CGFloat(lineWidth ?? 1)

        ZStack {
            if let fillStyle {
                shape.fill(fillStyle)
            } else if stroke == nil {
                shape.fill(modifiers.defaultShapeStyle)
            }

            if let stroke {
                shape.stroke(stroke.swiftUIShapeStyle, lineWidth: width)
            }
        }
    }

    @ViewBuilder
    private func customLayoutView(id: NodeID, name: String, values: [String: CustomHostValue], children: [ViewNode]) -> some View {
        if let javaScriptLayoutBridge = customHostRegistry.javaScriptLayoutBridge, javaScriptLayoutBridge.hasLayoutHandler(id) {
            SwiftJSJavaScriptLayout(
                id: id,
                bridge: javaScriptLayoutBridge
            ) {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        } else if let makeLayout = customHostRegistry.layout(named: name) {
            let layout = makeLayout(
                CustomHostContext(
                    id: id,
                    name: name,
                    values: values,
                    children: children,
                    slots: [:]
                )
            )

            layout {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        } else {
            Text("Missing custom layout: \(name)")
        }
    }

    @ViewBuilder
    private func scrollView(axis: AxisKind, children: [ViewNode]) -> some View {
        if axis == .horizontal {
            ScrollView(axis.swiftUIAxisSet) {
                HStack(spacing: 0) {
                    ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            }
        } else {
            GeometryReader { geometry in
                ScrollView(axis.swiftUIAxisSet) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(children) { child in
                            RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                }
            }
        }
    }

    private func textView(_ value: String, modifiers: ViewModifiers) -> some View {
        Text(value)
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    @ViewBuilder
    private func labelView(title: String, source: ImageSource, modifiers: ViewModifiers) -> some View {
        switch source {
        case let .system(systemName):
            Label(title, systemImage: systemName)
                .modifier(NodeAppearanceModifier(modifiers: modifiers))
        case let .asset(name):
            Label {
                Text(title)
            } icon: {
                Image(name)
            }
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
        }
    }

    @ViewBuilder
    private func contentUnavailableView(
        title: String,
        source: ImageSource?,
        description: ViewNode?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    ) -> some View {
        ContentUnavailableView {
            if let source {
                switch source {
                case let .system(systemName):
                    Label(title, systemImage: systemName)
                case let .asset(name):
                    Label {
                        Text(title)
                    } icon: {
                        Image(name)
                    }
                }
            } else {
                Text(title)
            }
        } description: {
            if let description {
                RenderNodeView(node: description, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        } actions: {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    @ViewBuilder
    private func buttonView(_ title: String, event: SurfaceEvent, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        let button = Button {
            onEvent(event)
        } label: {
            if children.isEmpty {
                Text(title)
            } else {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)

        switch modifiers.buttonStyle ?? .automatic {
        case .automatic:
            shapedButton(button, modifiers: modifiers)
        case .borderless:
            shapedButton(button.buttonStyle(.borderless), modifiers: modifiers)
        case .plain:
            shapedButton(button.buttonStyle(.plain), modifiers: modifiers)
        case .bordered:
            shapedButton(button.buttonStyle(.bordered), modifiers: modifiers)
        case .borderedProminent:
            shapedButton(button.buttonStyle(.borderedProminent), modifiers: modifiers)
        case .glass:
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
                shapedButton(button.buttonStyle(.glass(glassValue(for: modifiers))), modifiers: modifiers)
            } else {
                shapedButton(button.buttonStyle(.bordered), modifiers: modifiers)
            }
        case .glassProminent:
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
                shapedButton(button.buttonStyle(.glassProminent), modifiers: modifiers)
            } else {
                shapedButton(button.buttonStyle(.borderedProminent), modifiers: modifiers)
            }
        }
    }

    @ViewBuilder
    private func menuView(_ title: String, content: ViewNode, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        Menu {
            RenderNodeView(node: content, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } label: {
            if children.isEmpty {
                Text(title)
            } else {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func disclosureGroupView(
        _ title: String,
        isExpanded: Bool,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        content: ViewNode,
        children: [ViewNode]
    ) -> some View {
        DisclosureGroup(
            isExpanded: Binding(
                get: { isExpanded },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: nextValue ? "true" : "false"))
                }
            )
        ) {
            RenderNodeView(node: content, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } label: {
            if children.isEmpty {
                Text(title)
            } else {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func controlGroupView(children: [ViewNode]) -> some View {
        ControlGroup {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func imageView(_ source: ImageSource, modifiers: ViewModifiers) -> some View {
        switch source {
        case let .system(systemName):
            interpolationStyled(Image(systemName: systemName), interpolation: modifiers.imageInterpolation?.swiftUIImageInterpolation)
                .modifier(NodeAppearanceModifier(modifiers: modifiers))
        case let .asset(name):
            let image = interpolationStyled(Image(name).resizable(), interpolation: modifiers.imageInterpolation?.swiftUIImageInterpolation)

            switch modifiers.imageContentMode ?? .fit {
            case .fit:
                image
                    .scaledToFit()
                    .modifier(NodeAppearanceModifier(modifiers: modifiers))
            case .fill:
                image
                    .scaledToFill()
                    .modifier(NodeAppearanceModifier(modifiers: modifiers))
            }
        }
    }

    @ViewBuilder
    private func interpolationStyled(_ image: Image, interpolation: SwiftUI.Image.Interpolation?) -> some View {
        if let interpolation {
            image.interpolation(interpolation)
        } else {
            image
        }
    }

    @ViewBuilder
    private func sectionView(title: String?, children: [ViewNode]) -> some View {
        if let title, !title.isEmpty {
            Section(title) {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        } else {
            Section {
                ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            }
        }

    @ViewBuilder
    private func listView(children: [ViewNode], modifiers: ViewModifiers) -> some View {
        let list = List {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }

        switch modifiers.listStyle ?? .automatic {
        case .automatic:
            applyCommonModifiers(list)
        case .plain:
            applyCommonModifiers(list.listStyle(.plain))
        case .grouped:
            applyCommonModifiers(list.listStyle(.grouped))
        case .inset:
            applyCommonModifiers(list.listStyle(.inset))
        case .insetGrouped:
            applyCommonModifiers(list.listStyle(.insetGrouped))
        case .sidebar:
            applyCommonModifiers(list.listStyle(.sidebar))
        }
    }

    @ViewBuilder
    private func formView(children: [ViewNode]) -> some View {
        Form {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func navigationStackView(children: [ViewNode]) -> some View {
        NavigationStack {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func tabView(selection: PickerSelectionValue?, event: SurfaceEvent?, children: [ViewNode]) -> some View {
        let tabs = children.compactMap { child -> (NodeID, ViewNode)? in
            if case .tab(let id, _, _, _, _, _, _) = child {
                return (id, child)
            }

            return nil
        }

        if let selection, let event {
            TabView(
                selection: Binding(
                    get: { selection },
                    set: { nextValue in
                        onEvent(SurfaceEvent(event.name, payloadJSON: nextValue.payloadJSON))
                    }
                )
            ) {
                ForEach(tabs, id: \.0) { entry in
                    tabItemView(entry.1)
                }
            }
        } else {
            TabView {
                ForEach(tabs, id: \.0) { entry in
                    tabItemView(entry.1)
                }
            }
        }
    }

    @ViewBuilder
    private func tabItemView(_ node: ViewNode) -> some View {
        if case let .tab(_, title, source, badge, selection, _, children) = node {
            tabContent(children: children)
                .modifier(TabItemLabelModifier(title: title, source: source))
                .modifier(TabBadgeModifier(badge: badge))
                .modifier(TabTagModifier(selection: selection))
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func tabContent(children: [ViewNode]) -> some View {
        if children.isEmpty {
            Color.clear
        } else {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func navigationLinkView(destination: ViewNode, modifiers _: ViewModifiers, children: [ViewNode]) -> some View {
        NavigationLink {
            RenderNodeView(node: destination, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } label: {
            if children.isEmpty {
                Text("Open")
            } else {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
    }

    @ViewBuilder
    private func sheetView(
        isPresented: Bool,
        onDismiss: SurfaceEvent?,
        content: ViewNode,
        children: [ViewNode],
        modifiers: ViewModifiers
    ) -> some View {
        let root = modalRootView(children: children)
        let modal = root.sheet(
            isPresented: Binding(
                get: { isPresented },
                set: { nextValue in
                    if !nextValue, let onDismiss {
                        onEvent(onDismiss)
                    }
                }
            )
        ) {
            RenderNodeView(node: content, onEvent: onEvent, customHostRegistry: customHostRegistry)
        }

        configuredSheet(modal, modifiers: modifiers)
    }

    @ViewBuilder
    private func fullScreenCoverView(
        isPresented: Bool,
        onDismiss: SurfaceEvent?,
        interactiveDismissDisabled: Bool,
        content: ViewNode,
        children: [ViewNode],
        modifiers _: ViewModifiers
    ) -> some View {
        modalRootView(children: children)
            .fullScreenCover(
                isPresented: Binding(
                    get: { isPresented },
                    set: { nextValue in
                        if !nextValue, let onDismiss {
                            onEvent(onDismiss)
                        }
                    }
                )
            ) {
                RenderNodeView(node: content, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
            .interactiveDismissDisabled(interactiveDismissDisabled)
    }

    @ViewBuilder
    private func modalRootView(children: [ViewNode]) -> some View {
        if children.isEmpty {
            Color.clear
        } else {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func configuredSheet<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        let detentConfigured = presentationDetentsStyled(content, modifiers: modifiers)
        let cornerConfigured = presentationCornerRadiusStyled(detentConfigured, modifiers: modifiers)
        let backgroundInteractionConfigured = presentationBackgroundInteractionStyled(cornerConfigured, modifiers: modifiers)

        if let visibility = modifiers.swiftUIPresentationDragIndicator {
            backgroundInteractionConfigured.presentationDragIndicator(visibility)
        } else {
            backgroundInteractionConfigured
        }
    }

    @ViewBuilder
    private func presentationDetentsStyled<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        if !modifiers.presentationDetents.isEmpty {
            content.presentationDetents(Set(modifiers.presentationDetents.map(\.swiftUIPresentationDetent)))
        } else {
            content
        }
    }

    @ViewBuilder
    private func presentationCornerRadiusStyled<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        if let radius = modifiers.presentationCornerRadius {
            content.presentationCornerRadius(radius)
        } else {
            content
        }
    }

    @ViewBuilder
    private func presentationBackgroundInteractionStyled<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        switch modifiers.presentationBackgroundInteraction {
        case .automatic:
            content.presentationBackgroundInteraction(.automatic)
        case .enabled:
            content.presentationBackgroundInteraction(.enabled)
        case .disabled:
            content.presentationBackgroundInteraction(.disabled)
        case let .upThrough(detent):
            content.presentationBackgroundInteraction(.enabled(upThrough: detent.swiftUIPresentationDetent))
        case nil:
            content
        }
    }

    @ViewBuilder
    private func pickerView(
        _ title: String,
        selection: PickerSelectionValue,
        options: [PickerOption],
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    ) -> some View {
        Picker(
            selection: Binding(
                get: { selection },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: nextValue.payloadJSON))
                }
            )
        ) {
            ForEach(options, id: \.value) { option in
                Text(option.title).tag(option.value)
            }
        } label: {
            if children.isEmpty {
                Text(title)
            } else {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func toggleView(_ title: String, isOn: Bool, event: SurfaceEvent, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        Toggle(
            isOn: Binding(
                get: { isOn },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: nextValue ? "true" : "false"))
                }
            )
        ) {
            if children.isEmpty {
                Text(title)
                    .modifier(NodeAppearanceModifier(modifiers: modifiers))
            } else {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
    }

    private func applyCommonModifiers<Content: View>(_ content: Content) -> some View {
        content.modifier(CommonNodeModifier(modifiers: node.modifiers, onEvent: onEvent, customHostRegistry: customHostRegistry))
    }

    @ViewBuilder
    private func vStackView(alignment: ContentAlignment, distribution: StackDistribution, spacing: Double, children: [ViewNode]) -> some View {
        VStack(alignment: alignment.swiftUIHorizontalAlignment, spacing: spacing) {
            ForEach(children) { child in
                stackItemView(child, axis: .vertical, distribution: distribution, alignment: alignment)
            }
        }
    }

    @ViewBuilder
    private func hStackView(alignment: ContentAlignment, distribution: StackDistribution, spacing: Double, modifiers _: ViewModifiers, children: [ViewNode]) -> some View {
        HStack(alignment: alignment.swiftUIVerticalAlignment, spacing: spacing) {
            ForEach(children) { child in
                stackItemView(child, axis: .horizontal, distribution: distribution, alignment: alignment)
            }
        }
    }

    @ViewBuilder
    private func stackItemView(_ child: ViewNode, axis: AxisKind, distribution: StackDistribution, alignment: ContentAlignment) -> some View {
        let rendered = RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)

        switch (axis, distribution) {
        case (.horizontal, .fillEqually):
            rendered.frame(maxWidth: .infinity, alignment: alignment.swiftUIAlignment)
        case (.vertical, .fillEqually):
            rendered.frame(maxHeight: .infinity, alignment: alignment.swiftUIAlignment)
        default:
            rendered
        }
    }

    @ViewBuilder
    private func navigationSplitView(sidebar: ViewNode, detail: ViewNode) -> some View {
        if horizontalSizeClass == .compact {
            CompactNavigationSplitHost(sidebar: sidebar, detail: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } else {
            NavigationSplitView {
                RenderNodeView(node: sidebar, onEvent: onEvent, customHostRegistry: customHostRegistry)
            } detail: {
                RenderNodeView(node: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }
}

private struct SwiftJSFlowLayout: Layout {
    let alignment: ContentAlignment
    let spacing: Double
    let lineSpacing: Double

    struct Line {
        var indices: [Int]
        var width: CGFloat
        var height: CGFloat
    }

    func makeCache(subviews: Subviews) -> [Line] {
        []
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout [Line]) -> CGSize {
        cache = makeLines(proposal: proposal, subviews: subviews)
        let width = cache.map(\.width).max() ?? 0
        let height = cache.reduce(CGFloat.zero) { partialResult, line in
            if partialResult == 0 {
                return line.height
            }

            return partialResult + CGFloat(lineSpacing) + line.height
        }
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout [Line]) {
        let lines = cache.isEmpty ? makeLines(proposal: ProposedViewSize(bounds.size), subviews: subviews) : cache
        var lineTop = bounds.minY

        for line in lines {
            let lineOriginX = bounds.minX + horizontalOffset(for: line.width, in: bounds.width)
            var itemX = lineOriginX

            for index in line.indices {
                let size = subviews[index].sizeThatFits(.unspecified)
                let point = CGPoint(
                    x: itemX,
                    y: lineTop + ((line.height - size.height) * 0.5)
                )
                subviews[index].place(at: point, proposal: ProposedViewSize(size))
                itemX += size.width + CGFloat(spacing)
            }

            lineTop += line.height + CGFloat(lineSpacing)
        }
    }

    private func makeLines(proposal: ProposedViewSize, subviews: Subviews) -> [Line] {
        let maxWidth = proposal.width ?? .greatestFiniteMagnitude
        guard !subviews.isEmpty else {
            return []
        }

        var lines: [Line] = []
        var currentIndices: [Int] = []
        var currentWidth: CGFloat = 0
        var currentHeight: CGFloat = 0

        for index in subviews.indices {
            let size = subviews[index].sizeThatFits(.unspecified)
            let itemWidth = size.width
            let nextWidth = currentIndices.isEmpty ? itemWidth : currentWidth + CGFloat(spacing) + itemWidth

            if !currentIndices.isEmpty && nextWidth > maxWidth {
                lines.append(Line(indices: currentIndices, width: currentWidth, height: currentHeight))
                currentIndices = [index]
                currentWidth = itemWidth
                currentHeight = size.height
                continue
            }

            currentIndices.append(index)
            currentWidth = nextWidth
            currentHeight = max(currentHeight, size.height)
        }

        if !currentIndices.isEmpty {
            lines.append(Line(indices: currentIndices, width: currentWidth, height: currentHeight))
        }

        return lines
    }

    private func horizontalOffset(for contentWidth: CGFloat, in containerWidth: CGFloat) -> CGFloat {
        switch alignment.swiftUIHorizontalAlignment {
        case .leading:
            return 0
        case .trailing:
            return max(containerWidth - contentWidth, 0)
        default:
            return max((containerWidth - contentWidth) * 0.5, 0)
        }
    }
}

private struct JavaScriptLayoutSize: Codable {
    let width: Double?
    let height: Double?

    init(width: Double?, height: Double?) {
        self.width = width
        self.height = height
    }

    init(_ proposal: ProposedViewSize) {
        self.width = proposal.width.map(Double.init)
        self.height = proposal.height.map(Double.init)
    }

    init(_ size: CGSize) {
        self.width = size.width
        self.height = size.height
    }

    var proposedViewSize: ProposedViewSize {
        let proposedWidth = width.map { CGFloat($0) }
        let proposedHeight = height.map { CGFloat($0) }
        return ProposedViewSize(width: proposedWidth, height: proposedHeight)
    }

    var cgSize: CGSize {
        CGSize(width: width ?? 0, height: height ?? 0)
    }
}

private struct JavaScriptLayoutBounds: Codable {
    let minX: Double
    let minY: Double
    let width: Double
    let height: Double

    init(_ rect: CGRect) {
        self.minX = rect.minX
        self.minY = rect.minY
        self.width = rect.width
        self.height = rect.height
    }
}

private struct JavaScriptSubviewPlacement: Codable {
    let x: Double
    let y: Double
    let anchor: ContentAlignment
    let width: Double?
    let height: Double?
}

private final class JavaScriptLayoutBridge: @unchecked Sendable {
    let hasLayoutHandler: (_ id: NodeID) -> Bool
    let sizeThatFits: (_ id: NodeID, _ proposal: ProposedViewSize, _ subviewCount: Int, _ measureSubview: @escaping (Int, ProposedViewSize) -> CGSize) -> CGSize?
    let placeSubviews: (_ id: NodeID, _ bounds: CGRect, _ proposal: ProposedViewSize, _ subviewCount: Int, _ measureSubview: @escaping (Int, ProposedViewSize) -> CGSize) -> [JavaScriptSubviewPlacement]?

    init(
        hasLayoutHandler: @escaping (_ id: NodeID) -> Bool,
        sizeThatFits: @escaping (_ id: NodeID, _ proposal: ProposedViewSize, _ subviewCount: Int, _ measureSubview: @escaping (Int, ProposedViewSize) -> CGSize) -> CGSize?,
        placeSubviews: @escaping (_ id: NodeID, _ bounds: CGRect, _ proposal: ProposedViewSize, _ subviewCount: Int, _ measureSubview: @escaping (Int, ProposedViewSize) -> CGSize) -> [JavaScriptSubviewPlacement]?
    ) {
        self.hasLayoutHandler = hasLayoutHandler
        self.sizeThatFits = sizeThatFits
        self.placeSubviews = placeSubviews
    }
}

private final class GeometryReaderBridge: @unchecked Sendable {
    let hasHandler: (_ id: NodeID) -> Bool
    let render: (_ id: NodeID, _ size: CGSize) -> ViewNode?

    init(
        hasHandler: @escaping (_ id: NodeID) -> Bool,
        render: @escaping (_ id: NodeID, _ size: CGSize) -> ViewNode?
    ) {
        self.hasHandler = hasHandler
        self.render = render
    }
}

private struct SwiftJSJavaScriptLayout: Layout {
    let id: NodeID
    let bridge: JavaScriptLayoutBridge

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        bridge.sizeThatFits(id, proposal, subviews.count) { index, proposedSize in
            guard index >= 0, index < subviews.count else {
                return .zero
            }

            return subviews[index].sizeThatFits(proposedSize)
        } ?? .zero
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let placements = bridge.placeSubviews(id, bounds, proposal, subviews.count) { index, proposedSize in
            guard index >= 0, index < subviews.count else {
                return .zero
            }

            return subviews[index].sizeThatFits(proposedSize)
        } ?? []

        for (index, placement) in placements.enumerated() {
            guard index < subviews.count else {
                break
            }

            let proposedWidth = placement.width.map { CGFloat($0) }
            let proposedHeight = placement.height.map { CGFloat($0) }

            subviews[index].place(
                at: CGPoint(x: placement.x, y: placement.y),
                anchor: placement.anchor.swiftUIUnitPoint,
                proposal: ProposedViewSize(width: proposedWidth, height: proposedHeight)
            )
        }
    }
}

private struct CompactNavigationSplitHost: View {
    let sidebar: ViewNode
    let detail: ViewNode
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @State private var isShowingDetail = true

    var body: some View {
        NavigationStack {
            RenderNodeView(node: sidebar, onEvent: onEvent, customHostRegistry: customHostRegistry)
                .navigationDestination(isPresented: $isShowingDetail) {
                    RenderNodeView(node: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
        }
        .onAppear {
            isShowingDetail = true
        }
        .onChange(of: detail) { _, _ in
            isShowingDetail = true
        }
    }
}

private extension RenderNodeView {
    @ViewBuilder
    func shapedButton<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        switch modifiers.buttonBorderShape ?? .automatic {
        case .automatic:
            content.buttonBorderShape(.automatic)
        case .capsule:
            content.buttonBorderShape(.capsule)
        case .roundedRectangle:
            content.buttonBorderShape(.roundedRectangle)
        case .circle:
            content.buttonBorderShape(.circle)
        }
    }
}

private struct TabItemLabelModifier: ViewModifier {
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

private struct TabBadgeModifier: ViewModifier {
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

private struct TabTagModifier: ViewModifier {
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

private struct NodeAppearanceModifier: ViewModifier {
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

private struct CommonNodeModifier: ViewModifier {
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
            .modifier(OptionalNavigationTitleModifier(title: modifiers.navigationTitle))
            .modifier(OptionalNavigationBarTitleDisplayModeModifier(mode: modifiers.swiftUINavigationBarTitleDisplayMode))
            .modifier(OptionalToolbarBackgroundModifier(visibility: modifiers.swiftUIToolbarBackgroundVisibility))
            .modifier(OptionalToolbarColorSchemeModifier(scheme: modifiers.swiftUIColorScheme))
            .modifier(OptionalScrollContentBackgroundModifier(visibility: modifiers.swiftUIScrollContentBackgroundVisibility))
            .modifier(OptionalListRowSeparatorModifier(visibility: modifiers.swiftUIListRowSeparatorVisibility))
            .modifier(OptionalListSectionSeparatorModifier(visibility: modifiers.swiftUIListSectionSeparatorVisibility))
            .modifier(OptionalListRowInsetsModifier(insets: modifiers.listRowInsets?.swiftUIEdgeInsets))
            .modifier(OptionalListRowBackgroundModifier(background: modifiers.listRowBackground?.swiftUIShapeStyle))
            .modifier(ContentMarginsModifier(margins: modifiers.contentMargins))
            .modifier(SafeAreaInsetsModifier(insets: modifiers.safeAreaInsets, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalNavigationLinkIndicatorModifier(visibility: modifiers.swiftUINavigationLinkIndicatorVisibility))
            .modifier(ToolbarItemsModifier(items: modifiers.toolbarItems, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalAlertModifier(alert: modifiers.alert, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalConfirmationDialogModifier(dialog: modifiers.confirmationDialog, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(OptionalIdentityModifier(viewIdentity: modifiers.viewIdentity))
            .modifier(OptionalOnAppearModifier(event: modifiers.onAppearEvent, onEvent: onEvent))
    }
}

private struct NodeForegroundModifier: ViewModifier {
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

private struct NodeMultilineTextAlignmentModifier: ViewModifier {
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

private struct OptionalAspectRatioModifier: ViewModifier {
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

private struct OptionalSafeAreaPaddingModifier: ViewModifier {
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

private struct OptionalIgnoresSafeAreaModifier: ViewModifier {
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

private struct OptionalBackgroundModifier: ViewModifier {
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

private struct OptionalClipModifier: ViewModifier {
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

private struct OptionalGlassEffectModifier: ViewModifier {
    let modifiers: ViewModifiers

    @ViewBuilder
    func body(content: Content) -> some View {
        if modifiers.glassEffect && !modifiers.usesGlassButtonStyle {
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
                content.glassEffect(glassValue(for: modifiers))
            } else {
                content
            }
        } else {
            content
        }
    }
}

private struct OptionalTintModifier: ViewModifier {
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

private struct OptionalNavigationTitleModifier: ViewModifier {
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

private struct OptionalNavigationBarTitleDisplayModeModifier: ViewModifier {
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

private struct OptionalNavigationLinkIndicatorModifier: ViewModifier {
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

private struct OptionalIdentityModifier: ViewModifier {
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

private struct OptionalToolbarBackgroundModifier: ViewModifier {
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

private struct OptionalToolbarColorSchemeModifier: ViewModifier {
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

private struct OptionalScrollContentBackgroundModifier: ViewModifier {
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

private struct OptionalListRowSeparatorModifier: ViewModifier {
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

private struct OptionalListSectionSeparatorModifier: ViewModifier {
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

private struct OptionalListRowInsetsModifier: ViewModifier {
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

private struct OptionalListRowBackgroundModifier: ViewModifier {
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

private struct ContentMarginsModifier: ViewModifier {
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

private struct ContentMarginsEntryModifier: ViewModifier {
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

private struct SafeAreaInsetsModifier: ViewModifier {
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

private struct SafeAreaInsetEdgeModifier: ViewModifier {
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

private struct SafeAreaInsetGroupContent: View {
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

private struct ToolbarItemsModifier: ViewModifier {
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
        let matching = Array(items.enumerated().filter { $0.element.placement == placement })
        if !matching.isEmpty {
            ToolbarItemGroup(placement: placement.swiftUIToolbarItemPlacement) {
                ForEach(matching, id: \.offset) { entry in
                    RenderNodeView(node: entry.element.content, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
    }
}

private struct OptionalAlertModifier: ViewModifier {
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

private struct OptionalConfirmationDialogModifier: ViewModifier {
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

private struct DialogButtons: View {
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

private struct OptionalOnAppearModifier: ViewModifier {
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

private struct HostToolbarItem: Decodable {
    let placement: ToolbarItemPlacementKind
    let content: HostNode
}

private struct HostSafeAreaInset: Decodable {
    let edge: EdgeKind
    let spacing: Double?
    let content: HostNode
}

private final class HostNode: Decodable {
    let type: HostComponentType
    let id: String
    let alignment: ContentAlignment?
    let viewIdentity: CustomHostValue?
    let distribution: StackDistribution?
    let axis: AxisKind?
    let spacing: Double?
    let lineSpacing: Double?
    let horizontalSpacing: Double?
    let verticalSpacing: Double?
    let padding: Double?
    let paddingTop: Double?
    let frameMinWidth: Double?
    let frameMinHeight: Double?
    let frameWidth: Double?
    let frameHeight: Double?
    let frameMaxWidth: Bool?
    let frameMaxHeight: Bool?
    let frameMaxWidthValue: Double?
    let frameMaxHeightValue: Double?
    let background: ShapeStyleValue?
    let foregroundColor: String?
    let foregroundStyle: ShapeStyleValue?
    let tint: String?
    let fill: ShapeStyleValue?
    let stroke: ShapeStyleValue?
    let lineWidth: Double?
    let cornerRadius: Double?
    let fontName: TextStyle?
    let fontSize: Double?
    let fontWeight: FontWeight?
    let symbolRenderingMode: SymbolRenderingMode?
    let buttonStyle: ButtonStyle?
    let buttonBorderShape: ButtonBorderShape?
    let isDisabled: Bool?
    let glassEffect: Bool?
    let glassVariant: GlassVariantKind?
    let glassTint: String?
    let navigationTitle: String?
    let navigationBarTitleDisplayMode: NavigationBarTitleDisplayModeKind?
    let navigationLinkIndicatorVisibility: VisibilityKind?
    let toolbarItems: [HostToolbarItem]?
    let toolbarBackgroundVisibility: VisibilityKind?
    let toolbarColorScheme: ColorSchemeKind?
    let listStyle: ListStyleKind?
    let scrollContentBackground: VisibilityKind?
    let listRowSeparator: VisibilityKind?
    let listSectionSeparator: VisibilityKind?
    let listRowInsetTop: Double?
    let listRowInsetLeading: Double?
    let listRowInsetBottom: Double?
    let listRowInsetTrailing: Double?
    let listRowBackground: ShapeStyleValue?
    let contentMargins: [ContentMarginsValue]?
    let imageContentMode: ImageContentMode?
    let imageInterpolation: ImageInterpolation?
    let aspectRatio: Double?
    let aspectRatioContentMode: ImageContentMode?
    let fixedSizeHorizontal: Bool?
    let fixedSizeVertical: Bool?
    let safeAreaPaddingLength: Double?
    let safeAreaPaddingEdges: EdgeSetKind?
    let ignoresSafeArea: Bool?
    let ignoresSafeAreaEdges: EdgeSetKind?
    let safeAreaInsets: [HostSafeAreaInset]?
    let lineLimit: Int?
    let multilineTextAlignment: TextAlignmentKind?
    let truncationMode: TruncationModeKind?
    let minimumScaleFactor: Double?
    let alertTitle: String?
    let alertIsPresented: Bool?
    let alertMessage: HostNode?
    let alertActions: [DialogActionValue]?
    let confirmationDialogTitle: String?
    let confirmationDialogIsPresented: Bool?
    let confirmationDialogTitleVisibility: VisibilityKind?
    let confirmationDialogMessage: HostNode?
    let confirmationDialogActions: [DialogActionValue]?
    let onAppearEvent: String?
    let value: String?
    let systemName: String?
    let name: String?
    let title: String?
    let description: HostNode?
    let event: String?
    let onDismiss: String?
    let isOn: Bool?
    let isPresented: Bool?
    let selection: PickerSelectionValue?
    let badge: BadgeValue?
    let options: [PickerOption]?
    let presentationDetents: [PresentationDetentValue]?
    let presentationDragIndicator: VisibilityKind?
    let presentationCornerRadius: Double?
    let presentationBackgroundInteractionKind: String?
    let presentationBackgroundInteractionDetent: PresentationDetentValue?
    let interactiveDismissDisabled: Bool?
    let colors: [String]?
    let stops: [GradientStopValue]?
    let startPoint: UnitPointValue?
    let endPoint: UnitPointValue?
    let center: UnitPointValue?
    let startRadius: Double?
    let endRadius: Double?
    let angle: Double?
    let startAngle: Double?
    let endAngle: Double?
    let destination: HostNode?
    let content: HostNode?
    let customName: String?
    let customValues: [String: CustomHostValue]?
    let children: [HostNode]?
    let sidebar: HostNode?
    let detail: HostNode?
    let compact: HostNode?
    let regular: HostNode?
    let customSlots: [String: HostNode]?

    func makeViewNode() throws -> ViewNode {
        let modifiers = try makeModifiers()

        switch type {
        case .vStack:
            return .vStack(
                id: NodeID(id),
                alignment: alignment ?? .center,
                distribution: distribution ?? .natural,
                spacing: spacing ?? 16,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .hStack:
            return .hStack(
                id: NodeID(id),
                alignment: alignment ?? .center,
                distribution: distribution ?? .natural,
                spacing: spacing ?? 12,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .zStack:
            return .zStack(
                id: NodeID(id),
                alignment: alignment ?? .center,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .grid:
            return .grid(
                id: NodeID(id),
                horizontalSpacing: horizontalSpacing ?? 12,
                verticalSpacing: verticalSpacing ?? 12,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .flowLayout:
            return .flowLayout(
                id: NodeID(id),
                alignment: alignment ?? .center,
                spacing: spacing ?? 8,
                lineSpacing: lineSpacing ?? spacing ?? 8,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .viewThatFits:
            return .viewThatFits(
                id: NodeID(id),
                axis: axis,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .gridRow:
            return .gridRow(
                id: NodeID(id),
                alignment: alignment ?? .center,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .scrollView:
            return .scrollView(
                id: NodeID(id),
                axis: axis ?? .vertical,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .geometryReader:
            return .geometryReader(
                id: NodeID(id),
                modifiers: modifiers
            )
        case .custom:
            guard let customName else {
                throw JSSurfaceError.invalidTree("Custom node '\(id)' is missing a name")
            }

            return .custom(
                id: NodeID(id),
                name: customName,
                modifiers: modifiers,
                values: customValues ?? [:],
                children: try mapChildren(),
                slots: try mapCustomSlots()
            )
        case .customLayout:
            guard let customName else {
                throw JSSurfaceError.invalidTree("CustomLayout node '\(id)' is missing a name")
            }

            return .customLayout(
                id: NodeID(id),
                name: customName,
                modifiers: modifiers,
                values: customValues ?? [:],
                children: try mapChildren()
            )
        case .list:
            return .list(
                id: NodeID(id),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .form:
            return .form(
                id: NodeID(id),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .section:
            return .section(
                id: NodeID(id),
                title: title,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .navigationStack:
            return .navigationStack(
                id: NodeID(id),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .navigationLink:
            return .navigationLink(
                id: NodeID(id),
                modifiers: modifiers,
                destination: try mapSlot(destination, name: "destination"),
                children: try mapChildren()
            )
        case .sheet:
            guard let isPresented else {
                throw JSSurfaceError.invalidTree("Sheet node '\(id)' is missing an isPresented value")
            }

            return .sheet(
                id: NodeID(id),
                isPresented: isPresented,
                onDismiss: onDismiss.map { SurfaceEvent($0) },
                modifiers: modifiers,
                content: try mapSlot(content, name: "content"),
                children: try mapChildren()
            )
        case .fullScreenCover:
            guard let isPresented else {
                throw JSSurfaceError.invalidTree("FullScreenCover node '\(id)' is missing an isPresented value")
            }

            return .fullScreenCover(
                id: NodeID(id),
                isPresented: isPresented,
                onDismiss: onDismiss.map { SurfaceEvent($0) },
                interactiveDismissDisabled: interactiveDismissDisabled ?? false,
                modifiers: modifiers,
                content: try mapSlot(content, name: "content"),
                children: try mapChildren()
            )
        case .tabView:
            return .tabView(
                id: NodeID(id),
                selection: selection,
                event: event.map { SurfaceEvent($0) },
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .tab:
            guard let title else {
                throw JSSurfaceError.invalidTree("Tab node '\(id)' is missing a title")
            }

            let source: ImageSource?
            if let systemName {
                source = .system(systemName)
            } else if let name {
                source = .asset(name)
            } else {
                source = nil
            }

            return .tab(
                id: NodeID(id),
                title: title,
                source: source,
                badge: badge,
                selection: selection,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .navigationSplitView:
            return .navigationSplitView(
                id: NodeID(id),
                modifiers: modifiers,
                sidebar: try mapSlot(sidebar, name: "sidebar"),
                detail: try mapSlot(detail, name: "detail")
            )
        case .spacer:
            return .spacer(
                id: NodeID(id),
                modifiers: modifiers
            )
        case .text:
            guard let value else {
                throw JSSurfaceError.invalidTree("Text node '\(id)' is missing a value")
            }

            return .text(
                id: NodeID(id),
                value: value,
                modifiers: modifiers
            )
        case .label:
            guard let title else {
                throw JSSurfaceError.invalidTree("Label node '\(id)' is missing a title")
            }

            let source: ImageSource
            if let systemName {
                source = .system(systemName)
            } else if let name {
                source = .asset(name)
            } else {
                throw JSSurfaceError.invalidTree("Label node '\(id)' is missing an image name")
            }

            return .label(
                id: NodeID(id),
                title: title,
                source: source,
                modifiers: modifiers
            )
        case .contentUnavailable:
            guard let title else {
                throw JSSurfaceError.invalidTree("ContentUnavailableView node '\(id)' is missing a title")
            }

            let source: ImageSource?
            if let systemName {
                source = .system(systemName)
            } else if let name {
                source = .asset(name)
            } else {
                source = nil
            }

            return .contentUnavailable(
                id: NodeID(id),
                title: title,
                source: source,
                description: try description?.makeViewNode(),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .image:
            let source: ImageSource
            if let systemName {
                source = .system(systemName)
            } else if let name {
                source = .asset(name)
            } else {
                throw JSSurfaceError.invalidTree("Image node '\(id)' is missing an image name")
            }

            return .image(
                id: NodeID(id),
                source: source,
                modifiers: modifiers
            )
        case .rectangle:
            return .rectangle(
                id: NodeID(id),
                fill: fill,
                stroke: stroke,
                lineWidth: lineWidth,
                modifiers: modifiers
            )
        case .roundedRectangle:
            guard let cornerRadius else {
                throw JSSurfaceError.invalidTree("RoundedRectangle node '\(id)' is missing a cornerRadius")
            }

            return .roundedRectangle(
                id: NodeID(id),
                cornerRadius: cornerRadius,
                fill: fill,
                stroke: stroke,
                lineWidth: lineWidth,
                modifiers: modifiers
            )
        case .circle:
            return .circle(
                id: NodeID(id),
                fill: fill,
                stroke: stroke,
                lineWidth: lineWidth,
                modifiers: modifiers
            )
        case .capsule:
            return .capsule(
                id: NodeID(id),
                fill: fill,
                stroke: stroke,
                lineWidth: lineWidth,
                modifiers: modifiers
            )
        case .ellipse:
            return .ellipse(
                id: NodeID(id),
                fill: fill,
                stroke: stroke,
                lineWidth: lineWidth,
                modifiers: modifiers
            )
        case .linearGradient:
            return .linearGradient(
                id: NodeID(id),
                value: try makeLinearGradientValue(),
                modifiers: modifiers
            )
        case .radialGradient:
            return .radialGradient(
                id: NodeID(id),
                value: try makeRadialGradientValue(),
                modifiers: modifiers
            )
        case .angularGradient:
            return .angularGradient(
                id: NodeID(id),
                value: try makeAngularGradientValue(),
                modifiers: modifiers
            )
        case .divider:
            return .divider(
                id: NodeID(id),
                modifiers: modifiers
            )
        case .button:
            guard let event else {
                throw JSSurfaceError.invalidTree("Button node '\(id)' is missing an action event")
            }

            let childNodes = try mapChildren()
            if (title ?? "").isEmpty && childNodes.isEmpty {
                throw JSSurfaceError.invalidTree("Button node '\(id)' is missing content")
            }

            return .button(
                id: NodeID(id),
                title: title ?? "",
                event: SurfaceEvent(event),
                modifiers: modifiers,
                children: childNodes
            )
        case .menu:
            return .menu(
                id: NodeID(id),
                title: title ?? "",
                modifiers: modifiers,
                content: try mapSlot(content, name: "content"),
                children: try mapChildren()
            )
        case .disclosureGroup:
            guard let event else {
                throw JSSurfaceError.invalidTree("DisclosureGroup node '\(id)' is missing an onExpandedChange event")
            }

            guard let isPresented else {
                throw JSSurfaceError.invalidTree("DisclosureGroup node '\(id)' is missing an isExpanded value")
            }

            return .disclosureGroup(
                id: NodeID(id),
                title: title ?? "",
                isExpanded: isPresented,
                event: SurfaceEvent(event),
                modifiers: modifiers,
                content: try mapSlot(content, name: "content"),
                children: try mapChildren()
            )
        case .controlGroup:
            return .controlGroup(
                id: NodeID(id),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .picker:
            guard let event else {
                throw JSSurfaceError.invalidTree("Picker node '\(id)' is missing an onChange event")
            }

            guard let selection else {
                throw JSSurfaceError.invalidTree("Picker node '\(id)' is missing a selection value")
            }

            guard let options else {
                throw JSSurfaceError.invalidTree("Picker node '\(id)' is missing options")
            }

            return .picker(
                id: NodeID(id),
                title: title ?? "",
                selection: selection,
                options: options,
                event: SurfaceEvent(event),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .toggle:
            guard let event else {
                throw JSSurfaceError.invalidTree("Toggle node '\(id)' is missing an onChange event")
            }

            guard let isOn else {
                throw JSSurfaceError.invalidTree("Toggle node '\(id)' is missing an isOn value")
            }

            return .toggle(
                id: NodeID(id),
                title: title ?? "",
                isOn: isOn,
                event: SurfaceEvent(event),
                modifiers: modifiers,
                children: try mapChildren()
            )
        }
    }

    private func mapChildren() throws -> [ViewNode] {
        try (children ?? []).map { try $0.makeViewNode() }
    }

    private func mapSlot(_ node: HostNode?, name: String) throws -> ViewNode {
        guard let node else {
            throw JSSurfaceError.invalidTree("NavigationSplitView node '\(id)' is missing a \(name) slot")
        }

        return try node.makeViewNode()
    }

    private func mapCustomSlots() throws -> [String: ViewNode] {
        var result: [String: ViewNode] = [:]

        for (key, value) in customSlots ?? [:] {
            result[key] = try value.makeViewNode()
        }

        return result
    }

    private func makeModifiers() throws -> ViewModifiers {
        ViewModifiers(
            alignment: alignment ?? .center,
            viewIdentity: viewIdentity,
            padding: padding,
            paddingTop: paddingTop,
            frameMinWidth: frameMinWidth,
            frameMinHeight: frameMinHeight,
            frameWidth: frameWidth,
            frameHeight: frameHeight,
            frameMaxWidth: frameMaxWidth ?? false,
            frameMaxHeight: frameMaxHeight ?? false,
            frameMaxWidthValue: frameMaxWidthValue,
            frameMaxHeightValue: frameMaxHeightValue,
            background: background,
            foregroundColor: foregroundColor,
            foregroundStyle: foregroundStyle,
            tint: tint,
            cornerRadius: cornerRadius,
            fontStyle: fontName,
            fontSize: fontSize,
            fontWeight: fontWeight,
            symbolRenderingMode: symbolRenderingMode,
            buttonStyle: buttonStyle,
            buttonBorderShape: buttonBorderShape,
            isDisabled: isDisabled ?? false,
            glassEffect: glassEffect ?? false,
            glassVariant: glassVariant ?? .regular,
            glassTint: glassTint,
            navigationTitle: navigationTitle,
            navigationBarTitleDisplayMode: navigationBarTitleDisplayMode,
            navigationLinkIndicatorVisibility: navigationLinkIndicatorVisibility,
            toolbarItems: try mapToolbarItems(),
            toolbarBackgroundVisibility: toolbarBackgroundVisibility,
            toolbarColorScheme: toolbarColorScheme,
            listStyle: listStyle,
            scrollContentBackground: scrollContentBackground,
            listRowSeparator: listRowSeparator,
            listSectionSeparator: listSectionSeparator,
            listRowInsets: makeListRowInsets(),
            listRowBackground: listRowBackground,
            contentMargins: contentMargins ?? [],
            imageContentMode: imageContentMode,
            imageInterpolation: imageInterpolation,
            aspectRatio: aspectRatio,
            aspectRatioContentMode: aspectRatioContentMode,
            fixedSizeHorizontal: fixedSizeHorizontal ?? false,
            fixedSizeVertical: fixedSizeVertical ?? false,
            safeAreaPaddingLength: safeAreaPaddingLength,
            safeAreaPaddingEdges: safeAreaPaddingEdges ?? .all,
            ignoresSafeArea: ignoresSafeArea ?? false,
            ignoresSafeAreaEdges: ignoresSafeAreaEdges ?? .all,
            safeAreaInsets: try mapSafeAreaInsets(),
            lineLimit: lineLimit,
            multilineTextAlignment: multilineTextAlignment,
            truncationMode: truncationMode,
            minimumScaleFactor: minimumScaleFactor,
            presentationDetents: presentationDetents ?? [],
            presentationDragIndicator: presentationDragIndicator,
            presentationCornerRadius: presentationCornerRadius,
            presentationBackgroundInteraction: makePresentationBackgroundInteraction(),
            alert: try makeAlert(),
            confirmationDialog: try makeConfirmationDialog(),
            onAppearEvent: onAppearEvent.map { SurfaceEvent($0) }
        )
    }

    private func mapToolbarItems() throws -> [ToolbarItemValue] {
        try (toolbarItems ?? []).map { item in
            ToolbarItemValue(
                placement: item.placement,
                content: try item.content.makeViewNode()
            )
        }
    }

    private func makeListRowInsets() -> EdgeInsetsValue? {
        if listRowInsetTop == nil, listRowInsetLeading == nil, listRowInsetBottom == nil, listRowInsetTrailing == nil {
            return nil
        }

        return EdgeInsetsValue(
            top: listRowInsetTop,
            leading: listRowInsetLeading,
            bottom: listRowInsetBottom,
            trailing: listRowInsetTrailing
        )
    }

    private func mapSafeAreaInsets() throws -> [SafeAreaInsetValue] {
        try (safeAreaInsets ?? []).map { item in
            SafeAreaInsetValue(
                edge: item.edge,
                spacing: item.spacing,
                content: try item.content.makeViewNode()
            )
        }
    }

    private func makeAlert() throws -> AlertValue? {
        guard let alertTitle, let alertIsPresented else {
            return nil
        }

        return AlertValue(
            title: alertTitle,
            isPresented: alertIsPresented,
            message: try alertMessage?.makeViewNode(),
            actions: alertActions ?? []
        )
    }

    private func makeConfirmationDialog() throws -> ConfirmationDialogValue? {
        guard let confirmationDialogTitle, let confirmationDialogIsPresented else {
            return nil
        }

        return ConfirmationDialogValue(
            title: confirmationDialogTitle,
            isPresented: confirmationDialogIsPresented,
            titleVisibility: confirmationDialogTitleVisibility ?? .automatic,
            message: try confirmationDialogMessage?.makeViewNode(),
            actions: confirmationDialogActions ?? []
        )
    }

    private func makePresentationBackgroundInteraction() -> PresentationBackgroundInteractionValue? {
        switch presentationBackgroundInteractionKind {
        case "automatic":
            return .automatic
        case "enabled":
            return .enabled
        case "disabled":
            return .disabled
        case "upThrough":
            guard let presentationBackgroundInteractionDetent else {
                return nil
            }

            return .upThrough(presentationBackgroundInteractionDetent)
        default:
            return nil
        }
    }

    private func makeLinearGradientValue() throws -> LinearGradientValue {
        LinearGradientValue(
            colors: colors,
            stops: stops,
            startPoint: try required(startPoint, name: "startPoint"),
            endPoint: try required(endPoint, name: "endPoint")
        )
    }

    private func makeRadialGradientValue() throws -> RadialGradientValue {
        RadialGradientValue(
            colors: colors,
            stops: stops,
            center: center ?? .center,
            startRadius: startRadius ?? 0,
            endRadius: try required(endRadius, name: "endRadius")
        )
    }

    private func makeAngularGradientValue() throws -> AngularGradientValue {
        AngularGradientValue(
            colors: colors,
            stops: stops,
            center: center ?? .center,
            angle: angle,
            startAngle: startAngle,
            endAngle: endAngle
        )
    }

    private func required<Value>(_ value: Value?, name: String) throws -> Value {
        guard let value else {
            throw JSSurfaceError.invalidTree("\(type.rawValue) node '\(id)' is missing a \(name)")
        }

        return value
    }
}

private enum HostComponentType: String, Decodable {
    case vStack = "VStack"
    case hStack = "HStack"
    case zStack = "ZStack"
    case grid = "Grid"
    case flowLayout = "FlowLayout"
    case viewThatFits = "ViewThatFits"
    case gridRow = "GridRow"
    case scrollView = "ScrollView"
    case geometryReader = "GeometryReader"
    case custom = "Custom"
    case customLayout = "CustomLayout"
    case list = "List"
    case form = "Form"
    case section = "Section"
    case navigationStack = "NavigationStack"
    case navigationLink = "NavigationLink"
    case sheet = "Sheet"
    case fullScreenCover = "FullScreenCover"
    case tabView = "TabView"
    case tab = "Tab"
    case navigationSplitView = "NavigationSplitView"
    case spacer = "Spacer"
    case text = "Text"
    case label = "Label"
    case contentUnavailable = "ContentUnavailableView"
    case image = "Image"
    case rectangle = "Rectangle"
    case roundedRectangle = "RoundedRectangle"
    case circle = "Circle"
    case capsule = "Capsule"
    case ellipse = "Ellipse"
    case linearGradient = "LinearGradient"
    case radialGradient = "RadialGradient"
    case angularGradient = "AngularGradient"
    case divider = "Divider"
    case button = "Button"
    case menu = "Menu"
    case disclosureGroup = "DisclosureGroup"
    case controlGroup = "ControlGroup"
    case picker = "Picker"
    case toggle = "Toggle"
}

private enum JSSurfaceError: LocalizedError {
    case javaScriptException(String)
    case missingPackagedRuntime
    case missingScriptResource(name: String, ext: String, bundlePath: String)
    case missingRootNode
    case invalidTree(String)

    var errorDescription: String? {
        switch self {
        case let .javaScriptException(message):
            "JavaScript exception: \(message)"
        case .missingPackagedRuntime:
            "SwiftJS runtime script is missing from the package resources."
        case let .missingScriptResource(name, ext, bundlePath):
            "Could not find script resource '\(name).\(ext)' in bundle '\(bundlePath)'."
        case .missingRootNode:
            "The JavaScript bundle finished without mounting a root component."
        case let .invalidTree(message):
            "Invalid host tree: \(message)"
        }
    }
}

private extension ViewModifiers {
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

private extension ShapeStyleValue {
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

private extension LinearGradientValue {
    var swiftUIGradient: Gradient {
        makeGradient(colors: colors, stops: stops)
    }
}

private extension RadialGradientValue {
    var swiftUIGradient: Gradient {
        makeGradient(colors: colors, stops: stops)
    }
}

private extension AngularGradientValue {
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
private func glassValue(for modifiers: ViewModifiers) -> SwiftUI.Glass {
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

private extension VisibilityKind {
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

private extension EdgeInsetsValue {
    var swiftUIEdgeInsets: EdgeInsets {
        EdgeInsets(
            top: CGFloat(top ?? 0),
            leading: CGFloat(leading ?? 0),
            bottom: CGFloat(bottom ?? 0),
            trailing: CGFloat(trailing ?? 0)
        )
    }
}

private extension EdgeKind {
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

private extension EdgeSetKind {
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

private extension ContentMarginPlacementKind {
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

private extension ToolbarItemPlacementKind {
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

private extension DialogActionRoleKind {
    var swiftUIRole: ButtonRole? {
        switch self {
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        }
    }
}

private extension PresentationDetentValue {
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

private extension Color {
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

private extension String {
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

private extension AxisKind {
    var swiftUIAxisSet: Axis.Set {
        switch self {
        case .vertical:
            return .vertical
        case .horizontal:
            return .horizontal
        }
    }
}

private extension UnitPointValue {
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

private extension ImageContentMode {
    var swiftUIContentMode: SwiftUI.ContentMode {
        switch self {
        case .fit:
            return .fit
        case .fill:
            return .fill
        }
    }
}

private extension ImageInterpolation {
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

private extension ContentAlignment {
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
