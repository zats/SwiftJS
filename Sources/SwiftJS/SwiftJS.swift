import AVKit
import Charts
import Foundation
import JavaScriptCore
import MapKit
import Observation
import SwiftUI
import UniformTypeIdentifiers
import UIKit
import WebKit
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

public enum EditModeKind: String, Codable, Equatable, Sendable {
    case inactive
    case transient
    case active
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

public enum ButtonSizingKind: String, Codable, Equatable, Sendable {
    case automatic
    case flexible
}

public enum ShapeKind: String, Codable, Equatable, Sendable {
    case rectangle
    case rect
    case circle
    case capsule
    case roundedRectangle
}

public struct ShapeValue: Codable, Equatable, Sendable {
    public let kind: ShapeKind
    public let cornerRadius: Double?
}

public typealias ContentShapeKind = ShapeValue

public enum ScrollEdgeEffectStyleKind: String, Codable, Equatable, Sendable {
    case automatic
    case hard
    case soft
}

public enum ButtonRoleKind: String, Codable, Equatable, Sendable {
    case cancel
    case destructive
}

public enum TabRoleKind: String, Codable, Equatable, Sendable {
    case search
}

public enum TabBarMinimizeBehaviorKind: String, Codable, Equatable, Sendable {
    case automatic
    case onScrollDown
    case onScrollUp
    case never
}

public enum ToolbarContentKind: String, Codable, Equatable, Sendable {
    case item
    case spacer
}

public enum ToolbarSpacerSizingKind: String, Codable, Equatable, Sendable {
    case fixed
    case flexible
}

public enum SensoryFeedbackKind: String, Codable, Equatable, Sendable {
    case selection
    case success
    case warning
    case error
    case increase
    case decrease
    case start
    case stop
    case alignment
    case levelChange
    case impact
}

public enum SensoryFeedbackWeightKind: String, Codable, Equatable, Sendable {
    case light
    case medium
    case heavy
}

public enum SensoryFeedbackFlexibilityKind: String, Codable, Equatable, Sendable {
    case soft
    case solid
    case rigid
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

public enum PickerStyleKind: String, Codable, Equatable, Sendable {
    case inline
    case menu
    case segmented
}

public enum KeyboardTypeKind: String, Codable, Equatable, Sendable {
    case `default`
    case asciiCapable
    case numberPad
    case decimalPad
    case phonePad
    case emailAddress
    case URL
}

public enum TextInputAutocapitalizationKind: String, Codable, Equatable, Sendable {
    case never
    case words
    case sentences
    case characters
}

public enum TextContentTypeKind: String, Codable, Equatable, Sendable {
    case name
    case givenName
    case familyName
    case username
    case emailAddress
    case password
    case newPassword
    case oneTimeCode
    case URL
    case telephoneNumber
}

public enum SubmitLabelKind: String, Codable, Equatable, Sendable {
    case done
    case go
    case send
    case join
    case route
    case search
    case `return`
    case next
    case `continue`
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

public enum ToolbarRoleKind: String, Codable, Equatable, Sendable {
    case automatic
    case browser
    case editor
}

public enum SearchFieldPlacementKind: String, Codable, Equatable, Sendable {
    case automatic
    case toolbar
    case toolbarPrincipal
    case sidebar
    case navigationBarDrawer
}

public enum SearchFieldNavigationBarDrawerDisplayModeKind: String, Codable, Equatable, Sendable {
    case automatic
    case always
}

public enum SearchPresentationToolbarBehaviorKind: String, Codable, Equatable, Sendable {
    case automatic
    case avoidHidingContent
}

public enum SearchToolbarBehaviorKind: String, Codable, Equatable, Sendable {
    case automatic
    case minimized
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

public enum HorizontalEdgeKind: String, Codable, Equatable, Sendable {
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
    case destructiveAction
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

public enum ImageResizingModeKind: String, Codable, Equatable, Sendable {
    case stretch
    case tile

    var swiftUIResizingMode: Image.ResizingMode {
        switch self {
        case .stretch:
            return .stretch
        case .tile:
            return .tile
        }
    }
}

public enum ImageSource: Equatable, Sendable {
    case system(String)
    case asset(String)
}

public enum ShareItemValue: Equatable, Sendable {
    case text(String)
    case url(URL)
}

public enum TransferItemValue: Equatable, Sendable, Codable {
    case text(value: String, contentType: String?, suggestedName: String?)
    case url(value: URL, contentType: String?, suggestedName: String?)
    case file(value: URL, contentType: String?, suggestedName: String?)
    case data(value: Data, contentType: String, suggestedName: String?)

    private enum CodingKeys: String, CodingKey {
        case kind
        case value
        case contentType
        case suggestedName
    }

    private enum Kind: String, Codable {
        case text
        case url
        case file
        case data
    }

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(),
           let value = try? container.decode(String.self) {
            self = .text(value: value, contentType: nil, suggestedName: nil)
            return
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(Kind.self, forKey: .kind)
        let contentType = try container.decodeIfPresent(String.self, forKey: .contentType)
        let suggestedName = try container.decodeIfPresent(String.self, forKey: .suggestedName)

        switch kind {
        case .text:
            self = .text(
                value: try container.decode(String.self, forKey: .value),
                contentType: contentType,
                suggestedName: suggestedName
            )
        case .url:
            self = .url(
                value: try container.decode(URL.self, forKey: .value),
                contentType: contentType,
                suggestedName: suggestedName
            )
        case .file:
            self = .file(
                value: try container.decode(URL.self, forKey: .value),
                contentType: contentType,
                suggestedName: suggestedName
            )
        case .data:
            guard let contentType else {
                throw DecodingError.dataCorruptedError(
                    forKey: .contentType,
                    in: container,
                    debugDescription: "Transfer data items require a contentType"
                )
            }

            self = .data(
                value: try container.decode(Data.self, forKey: .value),
                contentType: contentType,
                suggestedName: suggestedName
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .text(value, contentType, suggestedName):
            try container.encode(Kind.text, forKey: .kind)
            try container.encode(value, forKey: .value)
            try container.encodeIfPresent(contentType, forKey: .contentType)
            try container.encodeIfPresent(suggestedName, forKey: .suggestedName)
        case let .url(value, contentType, suggestedName):
            try container.encode(Kind.url, forKey: .kind)
            try container.encode(value, forKey: .value)
            try container.encodeIfPresent(contentType, forKey: .contentType)
            try container.encodeIfPresent(suggestedName, forKey: .suggestedName)
        case let .file(value, contentType, suggestedName):
            try container.encode(Kind.file, forKey: .kind)
            try container.encode(value, forKey: .value)
            try container.encodeIfPresent(contentType, forKey: .contentType)
            try container.encodeIfPresent(suggestedName, forKey: .suggestedName)
        case let .data(value, contentType, suggestedName):
            try container.encode(Kind.data, forKey: .kind)
            try container.encode(value, forKey: .value)
            try container.encode(contentType, forKey: .contentType)
            try container.encodeIfPresent(suggestedName, forKey: .suggestedName)
        }
    }
}

public struct DropLocationValue: Codable, Equatable, Sendable {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

public struct DropDestinationValue: Equatable, Sendable {
    public let contentTypes: [String]?
    public let event: SurfaceEvent
    public let targetedEvent: SurfaceEvent?

    public init(contentTypes: [String]? = nil, event: SurfaceEvent, targetedEvent: SurfaceEvent? = nil) {
        self.contentTypes = contentTypes
        self.event = event
        self.targetedEvent = targetedEvent
    }
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
    case material(String)
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

extension PickerSelectionValue {
    var stableSortKey: String {
        switch self {
        case let .number(value):
            return "0:\(value)"
        case let .string(value):
            return "1:\(value)"
        }
    }
}

extension Array where Element == PickerSelectionValue {
    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("[]".utf8), as: UTF8.self)
    }
}

extension Array where Element == CustomHostValue {
    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("[]".utf8), as: UTF8.self)
    }
}

extension Array where Element == TransferItemValue {
    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("[]".utf8), as: UTF8.self)
    }
}

struct MoveActionValue: Codable, Equatable, Sendable {
    let fromOffsets: [Int]
    let toOffset: Int

    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("null".utf8), as: UTF8.self)
    }
}

struct DropActionPayloadValue: Codable, Equatable, Sendable {
    let items: [TransferItemValue]
    let location: DropLocationValue

    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("null".utf8), as: UTF8.self)
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

public enum DatePickerDisplayedComponentsKind: String, Codable, Equatable, Sendable {
    case date
    case hourAndMinute
    case dateAndTime
}

extension String {
    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("null".utf8), as: UTF8.self)
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

private enum HostDateValue {
    static func makeFractionalFormatter() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }

    static func makeStandardFormatter() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }

    static func parse(_ value: String) -> Date? {
        makeFractionalFormatter().date(from: value) ?? makeStandardFormatter().date(from: value)
    }

    static func stringify(_ value: Date) -> String {
        makeFractionalFormatter().string(from: value)
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

public struct TabViewBottomAccessoryValue: Equatable, Sendable {
    public let isEnabled: Bool
    public let content: ViewNode
}

public struct SensoryFeedbackValue: Equatable, Sendable {
    public let feedback: SensoryFeedbackKind
    public let trigger: CustomHostValue
    public let weight: SensoryFeedbackWeightKind?
    public let flexibility: SensoryFeedbackFlexibilityKind?
    public let intensity: Double?
    public let isEnabled: Bool

    public init(
        feedback: SensoryFeedbackKind,
        trigger: CustomHostValue,
        weight: SensoryFeedbackWeightKind? = nil,
        flexibility: SensoryFeedbackFlexibilityKind? = nil,
        intensity: Double? = nil,
        isEnabled: Bool = true
    ) {
        self.feedback = feedback
        self.trigger = trigger
        self.weight = weight
        self.flexibility = flexibility
        self.intensity = intensity
        self.isEnabled = isEnabled
    }
}

public enum AccessibilityTraitKind: String, Codable, Equatable, Sendable {
    case button
    case link
    case header
    case selected
    case image
    case staticText
    case summaryElement
    case updatesFrequently
    case searchField
    case isModal
}

public struct TextSegmentValue: Codable, Equatable, Sendable {
    public let text: String
    public let fontName: TextStyle?
    public let fontSize: Double?
    public let fontWeight: FontWeight?
    public let foregroundColor: String?
    public let foregroundStyle: ShapeStyleValue?
}

public struct MapMarkerValue: Codable, Equatable, Sendable {
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let systemName: String?
}

public enum ChartMarkKind: String, Codable, Equatable, Sendable {
    case bar
    case line
    case point
    case area
}

public struct ChartPointValue: Codable, Equatable, Sendable, Identifiable {
    public var id: String { "\(series ?? "")|\(label)|\(value)" }
    public let label: String
    public let value: Double
    public let series: String?
}

public struct DeleteActionValue: Codable, Equatable, Sendable {
    public let offsets: [Int]

    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("null".utf8), as: UTF8.self)
    }
}

public struct ToolbarItemValue: Equatable, Sendable {
    public let kind: ToolbarContentKind
    public let placement: ToolbarItemPlacementKind
    public let content: ViewNode?
    public let sizing: ToolbarSpacerSizingKind?
}

public typealias DialogActionRoleKind = ButtonRoleKind

public struct DialogActionValue: Codable, Equatable, Sendable {
    public let title: String
    public let role: ButtonRoleKind?
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

public struct ContextMenuValue: Equatable, Sendable {
    public let actions: [DialogActionValue]
    public let preview: ViewNode?

    public init(actions: [DialogActionValue], preview: ViewNode? = nil) {
        self.actions = actions
        self.preview = preview
    }
}

public struct SwipeActionsValue: Equatable, Sendable {
    public let items: [ViewNode]
    public let edge: HorizontalEdgeKind
    public let allowsFullSwipe: Bool

    public init(items: [ViewNode], edge: HorizontalEdgeKind = .trailing, allowsFullSwipe: Bool = true) {
        self.items = items
        self.edge = edge
        self.allowsFullSwipe = allowsFullSwipe
    }
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

public enum CustomHostValue: Equatable, Hashable, Sendable, Codable {
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

    var payloadJSON: String {
        let data = try? JSONEncoder().encode(self)
        return String(decoding: data ?? Data("null".utf8), as: UTF8.self)
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .string(value):
            hasher.combine(0)
            hasher.combine(value)
        case let .number(value):
            hasher.combine(1)
            hasher.combine(value)
        case let .bool(value):
            hasher.combine(2)
            hasher.combine(value)
        case let .array(value):
            hasher.combine(3)
            hasher.combine(value)
        case let .object(value):
            hasher.combine(4)
            for key in value.keys.sorted() {
                hasher.combine(key)
                hasher.combine(value[key])
            }
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
            if Material.named(value) != nil {
                self = .material(value)
            } else {
                self = .color(value)
            }
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
        case let .material(value):
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
    fileprivate let navigationDestinationBridge: NavigationDestinationBridge?

    public init(renderers: [String: Renderer] = [:], layouts: [String: LayoutRenderer] = [:]) {
        self.renderers = renderers
        self.layouts = layouts
        self.javaScriptLayoutBridge = nil
        self.geometryReaderBridge = nil
        self.navigationDestinationBridge = nil
    }

    fileprivate init(
        renderers: [String: Renderer],
        layouts: [String: LayoutRenderer],
        javaScriptLayoutBridge: JavaScriptLayoutBridge?,
        geometryReaderBridge: GeometryReaderBridge?,
        navigationDestinationBridge: NavigationDestinationBridge?
    ) {
        self.renderers = renderers
        self.layouts = layouts
        self.javaScriptLayoutBridge = javaScriptLayoutBridge
        self.geometryReaderBridge = geometryReaderBridge
        self.navigationDestinationBridge = navigationDestinationBridge
    }

    public func renderer(named name: String) -> Renderer? {
        renderers[name]
    }

    public func layout(named name: String) -> LayoutRenderer? {
        layouts[name]
    }

    func withJavaScriptLayoutBridge(_ bridge: JavaScriptLayoutBridge) -> Self {
        Self(
            renderers: renderers,
            layouts: layouts,
            javaScriptLayoutBridge: bridge,
            geometryReaderBridge: geometryReaderBridge,
            navigationDestinationBridge: navigationDestinationBridge
        )
    }

    func withGeometryReaderBridge(_ bridge: GeometryReaderBridge) -> Self {
        Self(
            renderers: renderers,
            layouts: layouts,
            javaScriptLayoutBridge: javaScriptLayoutBridge,
            geometryReaderBridge: bridge,
            navigationDestinationBridge: navigationDestinationBridge
        )
    }

    func withNavigationDestinationBridge(_ bridge: NavigationDestinationBridge) -> Self {
        Self(
            renderers: renderers,
            layouts: layouts,
            javaScriptLayoutBridge: javaScriptLayoutBridge,
            geometryReaderBridge: geometryReaderBridge,
            navigationDestinationBridge: bridge
        )
    }
}

public struct ViewModifiers: Equatable, Sendable {
    public var alignment: ContentAlignment
    public var viewIdentity: CustomHostValue?
    public var tag: PickerSelectionValue?
    public var accessibilityLabel: String?
    public var accessibilityHint: String?
    public var accessibilityValue: String?
    public var accessibilityAddTraits: [AccessibilityTraitKind]
    public var accessibilityRemoveTraits: [AccessibilityTraitKind]
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
    public var badge: BadgeValue?
    public var cornerRadius: Double?
    public var fontStyle: TextStyle?
    public var fontSize: Double?
    public var fontWeight: FontWeight?
    public var symbolRenderingMode: SymbolRenderingMode?
    public var buttonStyle: ButtonStyle?
    public var buttonBorderShape: ButtonBorderShape?
    public var buttonSizing: ButtonSizingKind?
    public var contentShape: ContentShapeKind?
    public var clipShape: ShapeValue?
    public var clipped: Bool
    public var isDisabled: Bool
    public var moveDisabled: Bool
    public var glassEffect: Bool
    public var glassVariant: GlassVariantKind
    public var glassTint: String?
    public var glassShape: ShapeValue?
    public var glassInteractive: Bool
    public var glassID: String?
    public var glassUnionID: String?
    public var scrollEdgeEffectStyle: ScrollEdgeEffectStyleKind?
    public var scrollEdgeEffectEdge: EdgeKind
    public var editMode: EditModeKind?
    public var editModeEvent: SurfaceEvent?
    public var navigationTitle: String?
    public var navigationBarTitleDisplayMode: NavigationBarTitleDisplayModeKind?
    public var navigationLinkIndicatorVisibility: VisibilityKind?
    public var tabBarMinimizeBehavior: TabBarMinimizeBehaviorKind?
    public var tabViewBottomAccessory: TabViewBottomAccessoryValue?
    public var toolbarRole: ToolbarRoleKind?
    public var searchable: SearchableValue?
    public var searchSuggestions: SearchSuggestionsValue?
    public var searchScopes: SearchScopesValue?
    public var searchCompletion: String?
    public var tabRole: TabRoleKind?
    public var searchPresentationToolbarBehavior: SearchPresentationToolbarBehaviorKind?
    public var searchToolbarBehavior: SearchToolbarBehaviorKind?
    public var toolbarItems: [ToolbarItemValue]
    public var toolbarBackgroundVisibility: VisibilityKind?
    public var toolbarColorScheme: ColorSchemeKind?
    public var listStyle: ListStyleKind?
    public var pickerStyle: PickerStyleKind?
    public var keyboardType: KeyboardTypeKind?
    public var textInputAutocapitalization: TextInputAutocapitalizationKind?
    public var autocorrectionDisabled: Bool?
    public var submitLabel: SubmitLabelKind?
    public var submitEvent: SurfaceEvent?
    public var sensoryFeedback: SensoryFeedbackValue?
    public var scrollContentBackground: VisibilityKind?
    public var listRowSeparator: VisibilityKind?
    public var listSectionSeparator: VisibilityKind?
    public var listRowInsets: EdgeInsetsValue?
    public var listRowBackground: ShapeStyleValue?
    public var draggable: TransferItemValue?
    public var dropDestination: DropDestinationValue?
    public var swipeActions: [SwipeActionsValue]
    public var contentMargins: [ContentMarginsValue]
    public var imageContentMode: ImageContentMode?
    public var imageResizable: Bool
    public var imageResizableCapInsets: EdgeInsetsValue?
    public var imageResizingMode: ImageResizingModeKind?
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
    public var lineSpacing: Double?
    public var multilineTextAlignment: TextAlignmentKind?
    public var truncationMode: TruncationModeKind?
    public var minimumScaleFactor: Double?
    public var presentationDetents: [PresentationDetentValue]
    public var presentationDragIndicator: VisibilityKind?
    public var presentationCornerRadius: Double?
    public var presentationBackgroundInteraction: PresentationBackgroundInteractionValue?
    public var alert: AlertValue?
    public var confirmationDialog: ConfirmationDialogValue?
    public var contextMenu: ContextMenuValue?
    public var onAppearEvent: SurfaceEvent?

    public init(
        alignment: ContentAlignment = .center,
        viewIdentity: CustomHostValue? = nil,
        tag: PickerSelectionValue? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        accessibilityValue: String? = nil,
        accessibilityAddTraits: [AccessibilityTraitKind] = [],
        accessibilityRemoveTraits: [AccessibilityTraitKind] = [],
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
        badge: BadgeValue? = nil,
        cornerRadius: Double? = nil,
        fontStyle: TextStyle? = nil,
        fontSize: Double? = nil,
        fontWeight: FontWeight? = nil,
        symbolRenderingMode: SymbolRenderingMode? = nil,
        buttonStyle: ButtonStyle? = nil,
        buttonBorderShape: ButtonBorderShape? = nil,
        buttonSizing: ButtonSizingKind? = nil,
        contentShape: ContentShapeKind? = nil,
        clipShape: ShapeValue? = nil,
        clipped: Bool = false,
        isDisabled: Bool = false,
        moveDisabled: Bool = false,
        glassEffect: Bool = false,
        glassVariant: GlassVariantKind = .regular,
        glassTint: String? = nil,
        glassShape: ShapeValue? = nil,
        glassInteractive: Bool = false,
        glassID: String? = nil,
        glassUnionID: String? = nil,
        scrollEdgeEffectStyle: ScrollEdgeEffectStyleKind? = nil,
        scrollEdgeEffectEdge: EdgeKind = .top,
        editMode: EditModeKind? = nil,
        editModeEvent: SurfaceEvent? = nil,
        navigationTitle: String? = nil,
        navigationBarTitleDisplayMode: NavigationBarTitleDisplayModeKind? = nil,
        navigationLinkIndicatorVisibility: VisibilityKind? = nil,
        tabBarMinimizeBehavior: TabBarMinimizeBehaviorKind? = nil,
        tabViewBottomAccessory: TabViewBottomAccessoryValue? = nil,
        toolbarRole: ToolbarRoleKind? = nil,
        searchable: SearchableValue? = nil,
        searchSuggestions: SearchSuggestionsValue? = nil,
        searchScopes: SearchScopesValue? = nil,
        searchCompletion: String? = nil,
        tabRole: TabRoleKind? = nil,
        searchPresentationToolbarBehavior: SearchPresentationToolbarBehaviorKind? = nil,
        searchToolbarBehavior: SearchToolbarBehaviorKind? = nil,
        toolbarItems: [ToolbarItemValue] = [],
        toolbarBackgroundVisibility: VisibilityKind? = nil,
        toolbarColorScheme: ColorSchemeKind? = nil,
        listStyle: ListStyleKind? = nil,
        pickerStyle: PickerStyleKind? = nil,
        keyboardType: KeyboardTypeKind? = nil,
        textInputAutocapitalization: TextInputAutocapitalizationKind? = nil,
        autocorrectionDisabled: Bool? = nil,
        submitLabel: SubmitLabelKind? = nil,
        submitEvent: SurfaceEvent? = nil,
        sensoryFeedback: SensoryFeedbackValue? = nil,
        scrollContentBackground: VisibilityKind? = nil,
        listRowSeparator: VisibilityKind? = nil,
        listSectionSeparator: VisibilityKind? = nil,
        listRowInsets: EdgeInsetsValue? = nil,
        listRowBackground: ShapeStyleValue? = nil,
        draggable: TransferItemValue? = nil,
        dropDestination: DropDestinationValue? = nil,
        swipeActions: [SwipeActionsValue] = [],
        contentMargins: [ContentMarginsValue] = [],
        imageContentMode: ImageContentMode? = nil,
        imageResizable: Bool = false,
        imageResizableCapInsets: EdgeInsetsValue? = nil,
        imageResizingMode: ImageResizingModeKind? = nil,
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
        lineSpacing: Double? = nil,
        multilineTextAlignment: TextAlignmentKind? = nil,
        truncationMode: TruncationModeKind? = nil,
        minimumScaleFactor: Double? = nil,
        presentationDetents: [PresentationDetentValue] = [],
        presentationDragIndicator: VisibilityKind? = nil,
        presentationCornerRadius: Double? = nil,
        presentationBackgroundInteraction: PresentationBackgroundInteractionValue? = nil,
        alert: AlertValue? = nil,
        confirmationDialog: ConfirmationDialogValue? = nil,
        contextMenu: ContextMenuValue? = nil,
        onAppearEvent: SurfaceEvent? = nil
    ) {
        self.alignment = alignment
        self.viewIdentity = viewIdentity
        self.tag = tag
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.accessibilityValue = accessibilityValue
        self.accessibilityAddTraits = accessibilityAddTraits
        self.accessibilityRemoveTraits = accessibilityRemoveTraits
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
        self.badge = badge
        self.cornerRadius = cornerRadius
        self.fontStyle = fontStyle
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.symbolRenderingMode = symbolRenderingMode
        self.buttonStyle = buttonStyle
        self.buttonBorderShape = buttonBorderShape
        self.buttonSizing = buttonSizing
        self.contentShape = contentShape
        self.clipShape = clipShape
        self.clipped = clipped
        self.isDisabled = isDisabled
        self.moveDisabled = moveDisabled
        self.glassEffect = glassEffect
        self.glassVariant = glassVariant
        self.glassTint = glassTint
        self.glassShape = glassShape
        self.glassInteractive = glassInteractive
        self.glassID = glassID
        self.glassUnionID = glassUnionID
        self.scrollEdgeEffectStyle = scrollEdgeEffectStyle
        self.scrollEdgeEffectEdge = scrollEdgeEffectEdge
        self.editMode = editMode
        self.editModeEvent = editModeEvent
        self.navigationTitle = navigationTitle
        self.navigationBarTitleDisplayMode = navigationBarTitleDisplayMode
        self.navigationLinkIndicatorVisibility = navigationLinkIndicatorVisibility
        self.tabBarMinimizeBehavior = tabBarMinimizeBehavior
        self.tabViewBottomAccessory = tabViewBottomAccessory
        self.toolbarRole = toolbarRole
        self.searchable = searchable
        self.searchSuggestions = searchSuggestions
        self.searchScopes = searchScopes
        self.searchCompletion = searchCompletion
        self.tabRole = tabRole
        self.searchPresentationToolbarBehavior = searchPresentationToolbarBehavior
        self.searchToolbarBehavior = searchToolbarBehavior
        self.toolbarItems = toolbarItems
        self.toolbarBackgroundVisibility = toolbarBackgroundVisibility
        self.toolbarColorScheme = toolbarColorScheme
        self.listStyle = listStyle
        self.pickerStyle = pickerStyle
        self.keyboardType = keyboardType
        self.textInputAutocapitalization = textInputAutocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.submitLabel = submitLabel
        self.submitEvent = submitEvent
        self.sensoryFeedback = sensoryFeedback
        self.scrollContentBackground = scrollContentBackground
        self.listRowSeparator = listRowSeparator
        self.listSectionSeparator = listSectionSeparator
        self.listRowInsets = listRowInsets
        self.listRowBackground = listRowBackground
        self.draggable = draggable
        self.dropDestination = dropDestination
        self.swipeActions = swipeActions
        self.contentMargins = contentMargins
        self.imageContentMode = imageContentMode
        self.imageResizable = imageResizable
        self.imageResizableCapInsets = imageResizableCapInsets
        self.imageResizingMode = imageResizingMode
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
        self.lineSpacing = lineSpacing
        self.multilineTextAlignment = multilineTextAlignment
        self.truncationMode = truncationMode
        self.minimumScaleFactor = minimumScaleFactor
        self.presentationDetents = presentationDetents
        self.presentationDragIndicator = presentationDragIndicator
        self.presentationCornerRadius = presentationCornerRadius
        self.presentationBackgroundInteraction = presentationBackgroundInteraction
        self.alert = alert
        self.confirmationDialog = confirmationDialog
        self.contextMenu = contextMenu
        self.onAppearEvent = onAppearEvent
    }
}

public struct SearchFieldPlacementValue: Equatable, Sendable {
    public let kind: SearchFieldPlacementKind
    public let navigationBarDrawerDisplayMode: SearchFieldNavigationBarDrawerDisplayModeKind?

    public init(
        kind: SearchFieldPlacementKind = .automatic,
        navigationBarDrawerDisplayMode: SearchFieldNavigationBarDrawerDisplayModeKind? = nil
    ) {
        self.kind = kind
        self.navigationBarDrawerDisplayMode = navigationBarDrawerDisplayMode
    }
}

public struct SearchableValue: Equatable, Sendable {
    public let text: String
    public let prompt: String?
    public let placement: SearchFieldPlacementValue
    public let isPresented: Bool?
    public let event: SurfaceEvent
    public let presentationEvent: SurfaceEvent?
    public let submitEvent: SurfaceEvent?

    public init(
        text: String,
        prompt: String? = nil,
        placement: SearchFieldPlacementValue = .init(),
        isPresented: Bool? = nil,
        event: SurfaceEvent,
        presentationEvent: SurfaceEvent? = nil,
        submitEvent: SurfaceEvent? = nil
    ) {
        self.text = text
        self.prompt = prompt
        self.placement = placement
        self.isPresented = isPresented
        self.event = event
        self.presentationEvent = presentationEvent
        self.submitEvent = submitEvent
    }
}

public struct SearchSuggestionsValue: Equatable, Sendable {
    public let content: [ViewNode]

    public init(content: [ViewNode]) {
        self.content = content
    }
}

public struct SearchScopesValue: Equatable, Sendable {
    public let selection: PickerSelectionValue
    public let event: SurfaceEvent
    public let content: [ViewNode]

    public init(selection: PickerSelectionValue, event: SurfaceEvent, content: [ViewNode]) {
        self.selection = selection
        self.event = event
        self.content = content
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
    case forEach(
        id: NodeID,
        moveEvent: SurfaceEvent?,
        deleteEvent: SurfaceEvent?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case glassEffectContainer(
        id: NodeID,
        spacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case list(
        id: NodeID,
        selection: Set<PickerSelectionValue>?,
        selectionEvent: SurfaceEvent?,
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
        header: ViewNode?,
        footer: ViewNode?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case navigationStack(
        id: NodeID,
        path: [CustomHostValue]?,
        pathEvent: SurfaceEvent?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case navigationLink(
        id: NodeID,
        modifiers: ViewModifiers,
        destination: ViewNode?,
        value: CustomHostValue?,
        children: [ViewNode]
    )
    case link(
        id: NodeID,
        title: String,
        destination: URL,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case webView(
        id: NodeID,
        url: URL?,
        html: String?,
        baseURL: URL?,
        javaScriptEnabled: Bool,
        allowsBackForwardNavigationGestures: Bool,
        modifiers: ViewModifiers
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
        segments: [TextSegmentValue],
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
    case progressView(
        id: NodeID,
        value: Double?,
        total: Double?,
        label: ViewNode?,
        currentValueLabel: ViewNode?,
        modifiers: ViewModifiers
    )
    case image(
        id: NodeID,
        source: ImageSource,
        modifiers: ViewModifiers
    )
    case asyncImage(
        id: NodeID,
        url: URL,
        placeholder: ViewNode?,
        empty: ViewNode?,
        failure: ViewNode?,
        modifiers: ViewModifiers
    )
    case map(
        id: NodeID,
        latitude: Double,
        longitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double,
        markers: [MapMarkerValue],
        modifiers: ViewModifiers
    )
    case chart(
        id: NodeID,
        data: [ChartPointValue],
        mark: ChartMarkKind,
        modifiers: ViewModifiers
    )
    case videoPlayer(
        id: NodeID,
        url: URL,
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
        role: ButtonRoleKind?,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case editButton(
        id: NodeID,
        modifiers: ViewModifiers
    )
    case shareLink(
        id: NodeID,
        title: String,
        items: [ShareItemValue],
        subject: String?,
        message: String?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case textField(
        id: NodeID,
        title: String,
        text: String,
        prompt: String?,
        textContentType: TextContentTypeKind?,
        event: SurfaceEvent,
        modifiers: ViewModifiers
    )
    case secureField(
        id: NodeID,
        title: String,
        text: String,
        prompt: String?,
        textContentType: TextContentTypeKind?,
        event: SurfaceEvent,
        modifiers: ViewModifiers
    )
    case textEditor(
        id: NodeID,
        text: String,
        event: SurfaceEvent,
        modifiers: ViewModifiers
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
    case groupBox(
        id: NodeID,
        title: String?,
        label: ViewNode?,
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
    case slider(
        id: NodeID,
        title: String,
        value: Double,
        minimumValue: Double,
        maximumValue: Double,
        step: Double?,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case stepper(
        id: NodeID,
        title: String,
        value: Double,
        minimumValue: Double,
        maximumValue: Double,
        step: Double?,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case datePicker(
        id: NodeID,
        title: String,
        selection: Date,
        minimumDate: Date?,
        maximumDate: Date?,
        displayedComponents: DatePickerDisplayedComponentsKind,
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
             let .forEach(id, _, _, _, _),
             let .glassEffectContainer(id, _, _, _),
             let .list(id, _, _, _, _),
             let .form(id, _, _),
             let .section(id, _, _, _, _, _),
             let .navigationStack(id, _, _, _, _),
             let .navigationLink(id, _, _, _, _),
             let .link(id, _, _, _, _),
             let .webView(id, _, _, _, _, _, _),
             let .sheet(id, _, _, _, _, _),
             let .fullScreenCover(id, _, _, _, _, _, _),
             let .tabView(id, _, _, _, _),
             let .tab(id, _, _, _, _, _, _),
             let .navigationSplitView(id, _, _, _),
             let .spacer(id, _),
             let .text(id, _, _, _),
             let .label(id, _, _, _),
             let .contentUnavailable(id, _, _, _, _, _),
             let .progressView(id, _, _, _, _, _),
             let .image(id, _, _),
             let .asyncImage(id, _, _, _, _, _),
             let .map(id, _, _, _, _, _, _),
             let .chart(id, _, _, _),
             let .videoPlayer(id, _, _),
             let .rectangle(id, _, _, _, _),
             let .roundedRectangle(id, _, _, _, _, _),
             let .circle(id, _, _, _, _),
             let .capsule(id, _, _, _, _),
             let .ellipse(id, _, _, _, _),
             let .linearGradient(id, _, _),
             let .radialGradient(id, _, _),
             let .angularGradient(id, _, _),
             let .divider(id, _),
             let .button(id, _, _, _, _, _),
             let .editButton(id, _),
             let .shareLink(id, _, _, _, _, _, _),
             let .textField(id, _, _, _, _, _, _),
             let .secureField(id, _, _, _, _, _, _),
             let .textEditor(id, _, _, _),
             let .menu(id, _, _, _, _),
             let .disclosureGroup(id, _, _, _, _, _, _),
             let .controlGroup(id, _, _),
             let .groupBox(id, _, _, _, _),
             let .picker(id, _, _, _, _, _, _),
             let .slider(id, _, _, _, _, _, _, _, _),
             let .stepper(id, _, _, _, _, _, _, _, _),
             let .datePicker(id, _, _, _, _, _, _, _, _),
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
             let .forEach(_, _, _, modifiers, _),
             let .glassEffectContainer(_, _, modifiers, _),
             let .list(_, _, _, modifiers, _),
             let .form(_, modifiers, _),
             let .section(_, _, _, _, modifiers, _),
             let .navigationStack(_, _, _, modifiers, _),
             let .navigationLink(_, modifiers, _, _, _),
             let .link(_, _, _, modifiers, _),
             let .webView(_, _, _, _, _, _, modifiers),
             let .sheet(_, _, _, modifiers, _, _),
             let .fullScreenCover(_, _, _, _, modifiers, _, _),
             let .tabView(_, _, _, modifiers, _),
             let .tab(_, _, _, _, _, modifiers, _),
             let .navigationSplitView(_, modifiers, _, _),
             let .spacer(_, modifiers),
             let .text(_, _, _, modifiers),
             let .label(_, _, _, modifiers),
             let .contentUnavailable(_, _, _, _, modifiers, _),
             let .progressView(_, _, _, _, _, modifiers),
             let .image(_, _, modifiers),
             let .asyncImage(_, _, _, _, _, modifiers),
             let .map(_, _, _, _, _, _, modifiers),
             let .chart(_, _, _, modifiers),
             let .videoPlayer(_, _, modifiers),
             let .rectangle(_, _, _, _, modifiers),
             let .roundedRectangle(_, _, _, _, _, modifiers),
             let .circle(_, _, _, _, modifiers),
             let .capsule(_, _, _, _, modifiers),
             let .ellipse(_, _, _, _, modifiers),
             let .linearGradient(_, _, modifiers),
             let .radialGradient(_, _, modifiers),
             let .angularGradient(_, _, modifiers),
             let .divider(_, modifiers),
             let .button(_, _, _, _, modifiers, _),
             let .editButton(_, modifiers),
             let .shareLink(_, _, _, _, _, modifiers, _),
             let .textField(_, _, _, _, _, _, modifiers),
             let .secureField(_, _, _, _, _, _, modifiers),
             let .textEditor(_, _, _, modifiers),
             let .menu(_, _, modifiers, _, _),
             let .disclosureGroup(_, _, _, _, modifiers, _, _),
             let .controlGroup(_, modifiers, _),
             let .groupBox(_, _, _, modifiers, _),
             let .picker(_, _, _, _, _, modifiers, _),
             let .slider(_, _, _, _, _, _, _, modifiers, _),
             let .stepper(_, _, _, _, _, _, _, modifiers, _),
             let .datePicker(_, _, _, _, _, _, _, modifiers, _),
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
        case let (.forEach(lID, lMoveEvent, lDeleteEvent, lModifiers, lChildren),
                  .forEach(rID, rMoveEvent, rDeleteEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lMoveEvent == rMoveEvent,
                  lDeleteEvent == rDeleteEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.glassEffectContainer(lID, lSpacing, lModifiers, lChildren),
                  .glassEffectContainer(rID, rSpacing, rModifiers, rChildren)):
            guard lID == rID,
                  lSpacing == rSpacing,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.list(lID, lSelection, lSelectionEvent, lModifiers, lChildren),
                  .list(rID, rSelection, rSelectionEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lSelection == rSelection,
                  lSelectionEvent == rSelectionEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.form(lID, lModifiers, lChildren),
                  .form(rID, rModifiers, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.section(lID, lTitle, lHeader, lFooter, lModifiers, lChildren),
                  .section(rID, rTitle, rHeader, rFooter, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  enqueueOptionalNode(lhs: lHeader, rhs: rHeader, into: &stack),
                  enqueueOptionalNode(lhs: lFooter, rhs: rFooter, into: &stack),
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.navigationStack(lID, lPath, lPathEvent, lModifiers, lChildren),
                  .navigationStack(rID, rPath, rPathEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lPath == rPath,
                  lPathEvent == rPathEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.navigationLink(lID, lModifiers, lDestination, lValue, lChildren),
                  .navigationLink(rID, rModifiers, rDestination, rValue, rChildren)):
            guard lID == rID,
                  lModifiers == rModifiers,
                  lValue == rValue,
                  enqueueOptionalNode(lhs: lDestination, rhs: rDestination, into: &stack),
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.link(lID, lTitle, lDestination, lModifiers, lChildren),
                  .link(rID, rTitle, rDestination, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lDestination == rDestination,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.webView(lID, lURL, lHTML, lBaseURL, lJavaScriptEnabled, lGestures, lModifiers),
                  .webView(rID, rURL, rHTML, rBaseURL, rJavaScriptEnabled, rGestures, rModifiers)):
            guard lID == rID,
                  lURL == rURL,
                  lHTML == rHTML,
                  lBaseURL == rBaseURL,
                  lJavaScriptEnabled == rJavaScriptEnabled,
                  lGestures == rGestures,
                  lModifiers == rModifiers
            else { return false }
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
        case let (.text(lID, lValue, lSegments, lModifiers),
                  .text(rID, rValue, rSegments, rModifiers)):
            guard lID == rID, lValue == rValue, lSegments == rSegments, lModifiers == rModifiers else { return false }
        case let (.label(lID, lTitle, lSource, lModifiers),
                  .label(rID, rTitle, rSource, rModifiers)):
            guard lID == rID, lTitle == rTitle, lSource == rSource, lModifiers == rModifiers else { return false }
        case let (.contentUnavailable(lID, lTitle, lSource, lDescription, lModifiers, lChildren),
                  .contentUnavailable(rID, rTitle, rSource, rDescription, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lSource == rSource,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }

            switch (lDescription, rDescription) {
            case let (.some(lhs), .some(rhs)):
                stack.append(.init(lhs: lhs, rhs: rhs))
            case (nil, nil):
                break
            default:
                return false
            }
        case let (.progressView(lID, lValue, lTotal, lLabel, lCurrentValueLabel, lModifiers),
                  .progressView(rID, rValue, rTotal, rLabel, rCurrentValueLabel, rModifiers)):
            guard lID == rID,
                  lValue == rValue,
                  lTotal == rTotal,
                  lModifiers == rModifiers
            else { return false }

            switch (lLabel, rLabel) {
            case let (.some(lhs), .some(rhs)):
                stack.append(.init(lhs: lhs, rhs: rhs))
            case (nil, nil):
                break
            default:
                return false
            }

            switch (lCurrentValueLabel, rCurrentValueLabel) {
            case let (.some(lhs), .some(rhs)):
                stack.append(.init(lhs: lhs, rhs: rhs))
            case (nil, nil):
                break
            default:
                return false
            }
        case let (.image(lID, lSource, lModifiers),
                  .image(rID, rSource, rModifiers)):
            guard lID == rID, lSource == rSource, lModifiers == rModifiers else { return false }
        case let (.asyncImage(lID, lURL, lPlaceholder, lEmpty, lFailure, lModifiers),
                  .asyncImage(rID, rURL, rPlaceholder, rEmpty, rFailure, rModifiers)):
            guard lID == rID,
                  lURL == rURL,
                  lModifiers == rModifiers,
                  enqueueOptionalNode(lhs: lPlaceholder, rhs: rPlaceholder, into: &stack),
                  enqueueOptionalNode(lhs: lEmpty, rhs: rEmpty, into: &stack),
                  enqueueOptionalNode(lhs: lFailure, rhs: rFailure, into: &stack)
            else { return false }
        case let (.map(lID, lLatitude, lLongitude, lLatitudeDelta, lLongitudeDelta, lMarkers, lModifiers),
                  .map(rID, rLatitude, rLongitude, rLatitudeDelta, rLongitudeDelta, rMarkers, rModifiers)):
            guard lID == rID,
                  lLatitude == rLatitude,
                  lLongitude == rLongitude,
                  lLatitudeDelta == rLatitudeDelta,
                  lLongitudeDelta == rLongitudeDelta,
                  lMarkers == rMarkers,
                  lModifiers == rModifiers
            else { return false }
        case let (.chart(lID, lData, lMark, lModifiers),
                  .chart(rID, rData, rMark, rModifiers)):
            guard lID == rID, lData == rData, lMark == rMark, lModifiers == rModifiers else { return false }
        case let (.videoPlayer(lID, lURL, lModifiers),
                  .videoPlayer(rID, rURL, rModifiers)):
            guard lID == rID, lURL == rURL, lModifiers == rModifiers else { return false }
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
        case let (.button(lID, lTitle, lRole, lEvent, lModifiers, lChildren),
                  .button(rID, rTitle, rRole, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lRole == rRole,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.editButton(lID, lModifiers),
                  .editButton(rID, rModifiers)):
            guard lID == rID, lModifiers == rModifiers else { return false }
        case let (.shareLink(lID, lTitle, lItems, lSubject, lMessage, lModifiers, lChildren),
                  .shareLink(rID, rTitle, rItems, rSubject, rMessage, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lItems == rItems,
                  lSubject == rSubject,
                  lMessage == rMessage,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.textField(lID, lTitle, lText, lPrompt, lTextContentType, lEvent, lModifiers),
                  .textField(rID, rTitle, rText, rPrompt, rTextContentType, rEvent, rModifiers)):
            guard lID == rID,
                  lTitle == rTitle,
                  lText == rText,
                  lPrompt == rPrompt,
                  lTextContentType == rTextContentType,
                  lEvent == rEvent,
                  lModifiers == rModifiers
            else { return false }
        case let (.secureField(lID, lTitle, lText, lPrompt, lTextContentType, lEvent, lModifiers),
                  .secureField(rID, rTitle, rText, rPrompt, rTextContentType, rEvent, rModifiers)):
            guard lID == rID,
                  lTitle == rTitle,
                  lText == rText,
                  lPrompt == rPrompt,
                  lTextContentType == rTextContentType,
                  lEvent == rEvent,
                  lModifiers == rModifiers
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
        case let (.groupBox(lID, lTitle, lLabel, lModifiers, lChildren),
                  .groupBox(rID, rTitle, rLabel, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lModifiers == rModifiers,
                  enqueueOptionalNode(lhs: lLabel, rhs: rLabel, into: &stack),
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
        case let (.slider(lID, lTitle, lValue, lMinimumValue, lMaximumValue, lStep, lEvent, lModifiers, lChildren),
                  .slider(rID, rTitle, rValue, rMinimumValue, rMaximumValue, rStep, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lValue == rValue,
                  lMinimumValue == rMinimumValue,
                  lMaximumValue == rMaximumValue,
                  lStep == rStep,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.stepper(lID, lTitle, lValue, lMinimumValue, lMaximumValue, lStep, lEvent, lModifiers, lChildren),
                  .stepper(rID, rTitle, rValue, rMinimumValue, rMaximumValue, rStep, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lValue == rValue,
                  lMinimumValue == rMinimumValue,
                  lMaximumValue == rMaximumValue,
                  lStep == rStep,
                  lEvent == rEvent,
                  lModifiers == rModifiers,
                  enqueueChildren(lhs: lChildren, rhs: rChildren, into: &stack)
            else { return false }
        case let (.datePicker(lID, lTitle, lSelection, lMinimumDate, lMaximumDate, lDisplayedComponents, lEvent, lModifiers, lChildren),
                  .datePicker(rID, rTitle, rSelection, rMinimumDate, rMaximumDate, rDisplayedComponents, rEvent, rModifiers, rChildren)):
            guard lID == rID,
                  lTitle == rTitle,
                  lSelection == rSelection,
                  lMinimumDate == rMinimumDate,
                  lMaximumDate == rMaximumDate,
                  lDisplayedComponents == rDisplayedComponents,
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

private func enqueueOptionalNode(lhs: ViewNode?, rhs: ViewNode?, into stack: inout [ViewNodePair]) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        stack.append(.init(lhs: lhs, rhs: rhs))
        return true
    case (nil, nil):
        return true
    default:
        return false
    }
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

struct RenderNodeView: View {
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
        case let .scrollView(_, axis, modifiers, children):
            applyCommonModifiers(
                scrollView(axis: axis, modifiers: modifiers, children: children)
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
        case let .forEach(_, moveEvent, deleteEvent, _, children):
            applyCommonModifiers(
                forEachView(children: children, moveEvent: moveEvent, deleteEvent: deleteEvent)
            )
        case let .glassEffectContainer(_, spacing, _, children):
            applyCommonModifiers(
                glassEffectContainerView(spacing: spacing, children: children)
            )
        case let .list(_, selection, selectionEvent, modifiers, children):
            listView(
                selection: selection,
                selectionEvent: selectionEvent,
                children: children,
                modifiers: modifiers
            )
        case let .form(_, modifiers, children):
            applyCommonModifiers(
                formView(children: children, modifiers: modifiers)
            )
        case let .section(_, title, header, footer, _, children):
            applyCommonModifiers(
                sectionView(title: title, header: header, footer: footer, children: children)
            )
        case let .navigationStack(id, path, pathEvent, modifiers, children):
            applyCommonModifiers(
                navigationStackView(id: id, path: path, pathEvent: pathEvent, children: children, modifiers: modifiers),
                appliesNavigationChrome: false
            )
        case let .navigationLink(_, modifiers, destination, value, children):
            applyCommonModifiers(
                navigationLinkView(destination: destination, value: value, modifiers: modifiers, children: children)
            )
        case let .link(_, title, destination, modifiers, children):
            applyCommonModifiers(
                linkView(title, destination: destination, modifiers: modifiers, children: children)
            )
        case let .webView(_, url, html, baseURL, javaScriptEnabled, allowsBackForwardNavigationGestures, modifiers):
            applyCommonModifiers(
                webView(
                    url: url,
                    html: html,
                    baseURL: baseURL,
                    javaScriptEnabled: javaScriptEnabled,
                    allowsBackForwardNavigationGestures: allowsBackForwardNavigationGestures,
                    modifiers: modifiers
                )
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
        case let .navigationSplitView(_, modifiers, sidebar, detail):
            applyCommonModifiers(
                navigationSplitView(sidebar: sidebar, detail: detail, modifiers: modifiers)
            )
        case .spacer:
            applyCommonModifiers(Spacer())
        case let .text(_, value, segments, modifiers):
            applyCommonModifiers(
                textView(value, segments: segments, modifiers: modifiers)
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
        case let .progressView(_, value, total, label, currentValueLabel, modifiers):
            applyCommonModifiers(
                progressView(
                    value: value,
                    total: total,
                    label: label,
                    currentValueLabel: currentValueLabel,
                    modifiers: modifiers
                )
            )
        case let .image(_, source, modifiers):
            applyCommonModifiers(
                imageView(source, modifiers: modifiers)
            )
        case let .asyncImage(_, url, placeholder, empty, failure, modifiers):
            applyCommonModifiers(
                asyncImageView(url: url, placeholder: placeholder, empty: empty, failure: failure, modifiers: modifiers)
            )
        case let .map(_, latitude, longitude, latitudeDelta, longitudeDelta, markers, modifiers):
            applyCommonModifiers(
                mapView(
                    latitude: latitude,
                    longitude: longitude,
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta,
                    markers: markers,
                    modifiers: modifiers
                )
            )
        case let .chart(_, data, mark, modifiers):
            applyCommonModifiers(
                chartView(data: data, mark: mark, modifiers: modifiers)
            )
        case let .videoPlayer(_, url, modifiers):
            applyCommonModifiers(
                videoPlayerView(url: url, modifiers: modifiers)
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
        case let .button(_, title, role, event, modifiers, children):
            applyCommonModifiers(
                buttonView(title, role: role, event: event, modifiers: modifiers, children: children)
            )
        case let .editButton(_, modifiers):
            applyCommonModifiers(
                editButtonView(modifiers: modifiers)
            )
        case let .shareLink(_, title, items, subject, message, modifiers, children):
            applyCommonModifiers(
                shareLinkView(title, items: items, subject: subject, message: message, modifiers: modifiers, children: children)
            )
        case let .textField(_, title, text, prompt, textContentType, event, modifiers):
            applyCommonModifiers(
                textFieldView(title: title, text: text, prompt: prompt, textContentType: textContentType, event: event, modifiers: modifiers)
            )
        case let .secureField(_, title, text, prompt, textContentType, event, modifiers):
            applyCommonModifiers(
                secureFieldView(title: title, text: text, prompt: prompt, textContentType: textContentType, event: event, modifiers: modifiers)
            )
        case let .textEditor(_, text, event, modifiers):
            applyCommonModifiers(
                textEditorView(text: text, event: event, modifiers: modifiers)
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
        case let .groupBox(_, title, label, modifiers, children):
            applyCommonModifiers(
                groupBoxView(title: title, label: label, modifiers: modifiers, children: children)
            )
        case let .picker(_, title, selection, options, event, modifiers, children):
            applyCommonModifiers(
                pickerView(title, selection: selection, options: options, event: event, modifiers: modifiers, children: children)
            )
        case let .slider(_, title, value, minimumValue, maximumValue, step, event, modifiers, children):
            applyCommonModifiers(
                sliderView(
                    title,
                    value: value,
                    minimumValue: minimumValue,
                    maximumValue: maximumValue,
                    step: step,
                    event: event,
                    modifiers: modifiers,
                    children: children
                )
            )
        case let .stepper(_, title, value, minimumValue, maximumValue, step, event, modifiers, children):
            applyCommonModifiers(
                stepperView(
                    title,
                    value: value,
                    minimumValue: minimumValue,
                    maximumValue: maximumValue,
                    step: step,
                    event: event,
                    modifiers: modifiers,
                    children: children
                )
            )
        case let .datePicker(_, title, selection, minimumDate, maximumDate, displayedComponents, event, modifiers, children):
            applyCommonModifiers(
                datePickerView(
                    title,
                    selection: selection,
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    displayedComponents: displayedComponents,
                    event: event,
                    modifiers: modifiers,
                    children: children
                )
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
    private func scrollView(axis: AxisKind, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        if axis == .horizontal {
            searchableStyled(
                ScrollView(axis.swiftUIAxisSet) {
                    HStack(spacing: 0) {
                        ForEach(children) { child in
                            RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        }
                    }
                },
                modifiers: modifiers
            )
        } else {
            GeometryReader { geometry in
                searchableStyled(
                    ScrollView(axis.swiftUIAxisSet) {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(children) { child in
                                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                            }
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                    },
                    modifiers: modifiers
                )
            }
        }
    }

    @ViewBuilder
    private func searchableStyled<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        content
            .modifier(OptionalSearchableModifier(searchable: modifiers.searchable, onEvent: onEvent))
            .modifier(
                OptionalSearchSuggestionsModifier(
                    suggestions: modifiers.searchSuggestions,
                    onEvent: onEvent,
                    customHostRegistry: customHostRegistry
                )
            )
            .modifier(
                OptionalSearchScopesModifier(
                    searchScopes: modifiers.searchScopes,
                    onEvent: onEvent,
                    customHostRegistry: customHostRegistry
                )
            )
    }

    private func textView(_ value: String, segments: [TextSegmentValue], modifiers: ViewModifiers) -> some View {
        formattedText(value, segments: segments)
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    private func formattedText(_ value: String, segments: [TextSegmentValue]) -> Text {
        guard let first = segments.first else {
            return Text(value)
        }

        return segments.dropFirst().reduce(textSegment(first)) { partialResult, segment in
            partialResult + textSegment(segment)
        }
    }

    private func textSegment(_ segment: TextSegmentValue) -> Text {
        var text = Text(segment.text)

        if let font = swiftUIFont(style: segment.fontName, size: segment.fontSize) {
            text = text.font(font)
        }

        if let fontWeight = segment.fontWeight?.swiftUIFontWeight {
            text = text.fontWeight(fontWeight)
        }

        if let foregroundStyle = segment.foregroundStyle?.swiftUIShapeStyle {
            text = text.foregroundStyle(foregroundStyle)
        } else if let color = segment.foregroundColor.flatMap(Color.named(_:)) {
            text = text.foregroundStyle(color)
        }

        return text
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
    private func progressView(
        value: Double?,
        total: Double?,
        label: ViewNode?,
        currentValueLabel: ViewNode?,
        modifiers: ViewModifiers
    ) -> some View {
        Group {
            if let value {
                if label != nil || currentValueLabel != nil {
                    ProgressView(value: value, total: total ?? 1) {
                        if let label {
                            RenderNodeView(node: label, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        }
                    } currentValueLabel: {
                        if let currentValueLabel {
                            RenderNodeView(node: currentValueLabel, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        }
                    }
                } else {
                    ProgressView(value: value, total: total ?? 1)
                }
            } else if let label {
                ProgressView {
                    RenderNodeView(node: label, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            } else {
                ProgressView()
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    @ViewBuilder
    private func buttonView(_ title: String, role: ButtonRoleKind?, event: SurfaceEvent, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        let button = Button(role: role?.swiftUIRole) {
            onEvent(event)
        } label: {
            controlLabel(title, fallback: title, children: children)
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)

        styledControl(button, modifiers: modifiers)
    }

    @ViewBuilder
    private func editButtonView(modifiers: ViewModifiers) -> some View {
        let button = SwiftUI.EditButton()
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
            .disabled(modifiers.isDisabled)

        styledControl(button, modifiers: modifiers)
    }

    @ViewBuilder
    private func linkView(_ title: String, destination: URL, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        let link = Link(destination: destination) {
            controlLabel(title, fallback: destination.absoluteString, children: children)
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)

        styledControl(link, modifiers: modifiers)
    }

    @ViewBuilder
    private func webView(
        url: URL?,
        html: String?,
        baseURL: URL?,
        javaScriptEnabled: Bool,
        allowsBackForwardNavigationGestures: Bool,
        modifiers: ViewModifiers
    ) -> some View {
        SwiftJSWebView(
            url: url,
            html: html,
            baseURL: baseURL,
            javaScriptEnabled: javaScriptEnabled,
            allowsBackForwardNavigationGestures: allowsBackForwardNavigationGestures
        )
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
            .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func shareLinkView(
        _ title: String,
        items: [ShareItemValue],
        subject: String?,
        message: String?,
        modifiers: ViewModifiers,
        children: [ViewNode]
    ) -> some View {
        switch shareLinkPayload(items) {
        case let .text(text):
            let link = ShareLink(item: text, subject: subject.map(Text.init), message: message.map(Text.init)) {
                controlLabel(title, fallback: "Share", children: children)
            }
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
            .disabled(modifiers.isDisabled)

            styledControl(link, modifiers: modifiers)
        case let .texts(texts):
            let link = ShareLink(items: texts, subject: subject.map(Text.init), message: message.map(Text.init)) {
                controlLabel(title, fallback: "Share", children: children)
            }
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
            .disabled(modifiers.isDisabled)

            styledControl(link, modifiers: modifiers)
        case let .url(url):
            let link = ShareLink(item: url, subject: subject.map(Text.init), message: message.map(Text.init)) {
                controlLabel(title, fallback: "Share", children: children)
            }
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
            .disabled(modifiers.isDisabled)

            styledControl(link, modifiers: modifiers)
        case let .urls(urls):
            let link = ShareLink(items: urls, subject: subject.map(Text.init), message: message.map(Text.init)) {
                controlLabel(title, fallback: "Share", children: children)
            }
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
            .disabled(modifiers.isDisabled)

            styledControl(link, modifiers: modifiers)
        }
    }

    @ViewBuilder
    private func textFieldView(title: String, text: String, prompt: String?, textContentType: TextContentTypeKind?, event: SurfaceEvent, modifiers: ViewModifiers) -> some View {
        TextField(
            title,
            text: Binding(
                get: { text },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: nextValue.payloadJSON))
                }
            ),
            prompt: prompt.map(Text.init)
        )
        .modifier(OptionalTextContentTypeModifier(textContentType: textContentType))
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func secureFieldView(title: String, text: String, prompt: String?, textContentType: TextContentTypeKind?, event: SurfaceEvent, modifiers: ViewModifiers) -> some View {
        SecureField(
            title,
            text: Binding(
                get: { text },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: nextValue.payloadJSON))
                }
            ),
            prompt: prompt.map(Text.init)
        )
        .modifier(OptionalTextContentTypeModifier(textContentType: textContentType))
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func textEditorView(text: String, event: SurfaceEvent, modifiers: ViewModifiers) -> some View {
        TextEditor(
            text: Binding(
                get: { text },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: nextValue.payloadJSON))
                }
            )
        )
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
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
        .modifier(OptionalPickerStyleModifier(style: modifiers.pickerStyle))
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
            imageContent(Image(systemName: systemName), modifiers: modifiers)
        case let .asset(name):
            imageContent(Image(name), modifiers: modifiers)
        }
    }

    @ViewBuilder
    private func asyncImageView(url: URL, placeholder: ViewNode?, empty: ViewNode?, failure: ViewNode?, modifiers: ViewModifiers) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case let .success(image):
                imageContent(image, modifiers: modifiers, appliesAppearance: false)
            case .failure:
                if let failure {
                    RenderNodeView(node: failure, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } else if let placeholder {
                    RenderNodeView(node: placeholder, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } else {
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)
                }
            case .empty:
                if let empty {
                    RenderNodeView(node: empty, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } else if let placeholder {
                    RenderNodeView(node: placeholder, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } else {
                    ProgressView()
                }
            @unknown default:
                EmptyView()
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    private func mapView(
        latitude: Double,
        longitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double,
        markers: [MapMarkerValue],
        modifiers: ViewModifiers
    ) -> some View {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        )

        return Map(initialPosition: .region(region)) {
            ForEach(Array(markers.enumerated()), id: \.offset) { entry in
                let marker = entry.element
                let coordinate = CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longitude)
                if let systemName = marker.systemName {
                    Marker(marker.title, systemImage: systemName, coordinate: coordinate)
                } else {
                    Marker(marker.title, coordinate: coordinate)
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    @ViewBuilder
    private func chartView(data: [ChartPointValue], mark: ChartMarkKind, modifiers: ViewModifiers) -> some View {
        Chart(data) { point in
            switch mark {
            case .bar:
                if let series = point.series {
                    BarMark(x: .value("Label", point.label), y: .value("Value", point.value))
                        .foregroundStyle(by: .value("Series", series))
                } else {
                    BarMark(x: .value("Label", point.label), y: .value("Value", point.value))
                }
            case .line:
                if let series = point.series {
                    LineMark(x: .value("Label", point.label), y: .value("Value", point.value))
                        .foregroundStyle(by: .value("Series", series))
                } else {
                    LineMark(x: .value("Label", point.label), y: .value("Value", point.value))
                }
            case .point:
                if let series = point.series {
                    PointMark(x: .value("Label", point.label), y: .value("Value", point.value))
                        .foregroundStyle(by: .value("Series", series))
                } else {
                    PointMark(x: .value("Label", point.label), y: .value("Value", point.value))
                }
            case .area:
                if let series = point.series {
                    AreaMark(x: .value("Label", point.label), y: .value("Value", point.value))
                        .foregroundStyle(by: .value("Series", series))
                } else {
                    AreaMark(x: .value("Label", point.label), y: .value("Value", point.value))
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    private func videoPlayerView(url: URL, modifiers: ViewModifiers) -> some View {
        VideoPlayer(player: AVPlayer(url: url))
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    @ViewBuilder
    private func imageContent(_ image: Image, modifiers: ViewModifiers, appliesAppearance: Bool = true) -> some View {
        if modifiers.imageResizable {
            let image = interpolationStyled(
                image.resizable(
                    capInsets: swiftUIEdgeInsets(modifiers.imageResizableCapInsets),
                    resizingMode: modifiers.imageResizingMode?.swiftUIResizingMode ?? .stretch
                ),
                interpolation: modifiers.imageInterpolation?.swiftUIImageInterpolation
            )

            switch modifiers.imageContentMode ?? .fit {
            case .fit:
                if appliesAppearance {
                    image.scaledToFit()
                        .modifier(NodeAppearanceModifier(modifiers: modifiers))
                } else {
                    image.scaledToFit()
                }
            case .fill:
                if appliesAppearance {
                    image.scaledToFill()
                        .modifier(NodeAppearanceModifier(modifiers: modifiers))
                } else {
                    image.scaledToFill()
                }
            }
        } else {
            if appliesAppearance {
                interpolationStyled(image, interpolation: modifiers.imageInterpolation?.swiftUIImageInterpolation)
                    .modifier(NodeAppearanceModifier(modifiers: modifiers))
            } else {
                interpolationStyled(image, interpolation: modifiers.imageInterpolation?.swiftUIImageInterpolation)
            }
        }
    }

    private func swiftUIEdgeInsets(_ value: EdgeInsetsValue?) -> EdgeInsets {
        guard let value else {
            return EdgeInsets()
        }

        return EdgeInsets(
            top: CGFloat(value.top ?? 0),
            leading: CGFloat(value.leading ?? 0),
            bottom: CGFloat(value.bottom ?? 0),
            trailing: CGFloat(value.trailing ?? 0)
        )
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
    private func forEachView(children: [ViewNode], moveEvent: SurfaceEvent?, deleteEvent: SurfaceEvent?) -> some View {
        editableContent(children: children, moveEvent: moveEvent, deleteEvent: deleteEvent)
    }

    private func glassEffectContainerView(spacing: Double, children: [ViewNode]) -> some View {
        GlassEffectContainer(spacing: spacing) {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func sectionView(title: String?, header: ViewNode?, footer: ViewNode?, children: [ViewNode]) -> some View {
        if header != nil || footer != nil {
            Section {
                sectionContent(children: children)
            } header: {
                sectionHeader(title: title, header: header)
            } footer: {
                sectionFooter(footer)
            }
        } else if let title, !title.isEmpty {
            Section(title) {
                sectionContent(children: children)
            }
        } else {
            Section {
                sectionContent(children: children)
            }
        }
    }

    @ViewBuilder
    private func sectionContent(children: [ViewNode]) -> some View {
        ForEach(children) { child in
            RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
        }
    }

    @ViewBuilder
    private func editableContent(children: [ViewNode], moveEvent: SurfaceEvent?, deleteEvent: SurfaceEvent?) -> some View {
        if let moveEvent, let deleteEvent {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
            .onDelete { offsets in
                let payload = DeleteActionValue(offsets: Array(offsets))
                onEvent(SurfaceEvent(deleteEvent.name, payloadJSON: payload.payloadJSON))
            }
            .onMove { fromOffsets, toOffset in
                let payload = MoveActionValue(fromOffsets: Array(fromOffsets), toOffset: toOffset)
                onEvent(SurfaceEvent(moveEvent.name, payloadJSON: payload.payloadJSON))
            }
        } else if let deleteEvent {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
            .onDelete { offsets in
                let payload = DeleteActionValue(offsets: Array(offsets))
                onEvent(SurfaceEvent(deleteEvent.name, payloadJSON: payload.payloadJSON))
            }
        } else if let moveEvent {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
            .onMove { fromOffsets, toOffset in
                let payload = MoveActionValue(fromOffsets: Array(fromOffsets), toOffset: toOffset)
                onEvent(SurfaceEvent(moveEvent.name, payloadJSON: payload.payloadJSON))
            }
        } else {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    @ViewBuilder
    private func sectionHeader(title: String?, header: ViewNode?) -> some View {
        if let header {
            RenderNodeView(node: header, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } else if let title, !title.isEmpty {
            Text(title)
        }
    }

    @ViewBuilder
    private func sectionFooter(_ footer: ViewNode?) -> some View {
        if let footer {
            RenderNodeView(node: footer, onEvent: onEvent, customHostRegistry: customHostRegistry)
        }
    }

    @ViewBuilder
    private func listView(
        selection: Set<PickerSelectionValue>?,
        selectionEvent: SurfaceEvent?,
        children: [ViewNode],
        modifiers: ViewModifiers
    ) -> some View {
        let list = Group {
            if let selection {
                if let selectionEvent {
                    List(
                        selection: Binding(
                            get: { selection },
                            set: { nextValue in
                                let orderedSelection = Array(nextValue).sorted { $0.stableSortKey < $1.stableSortKey }
                                onEvent(SurfaceEvent(selectionEvent.name, payloadJSON: orderedSelection.payloadJSON))
                            }
                        )
                    ) {
                        ForEach(children) { child in
                            RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        }
                    }
                } else {
                    List(selection: .constant(selection)) {
                        ForEach(children) { child in
                            RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                        }
                    }
                }
            } else {
                List {
                    ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
            }
        }
        let searchableList = searchableStyled(list, modifiers: modifiers)

        switch modifiers.listStyle ?? .automatic {
        case .automatic:
            applyCommonModifiers(searchableList)
        case .plain:
            applyCommonModifiers(searchableList.listStyle(.plain))
        case .grouped:
            applyCommonModifiers(searchableList.listStyle(.grouped))
        case .inset:
            applyCommonModifiers(searchableList.listStyle(.inset))
        case .insetGrouped:
            applyCommonModifiers(searchableList.listStyle(.insetGrouped))
        case .sidebar:
            applyCommonModifiers(searchableList.listStyle(.sidebar))
        }
    }

    @ViewBuilder
    private func formView(children: [ViewNode], modifiers: ViewModifiers) -> some View {
        searchableStyled(
            Form {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            },
            modifiers: modifiers
        )
    }

    @ViewBuilder
    private func navigationStackView(
        id: NodeID,
        path: [CustomHostValue]?,
        pathEvent: SurfaceEvent?,
        children: [ViewNode],
        modifiers: ViewModifiers
    ) -> some View {
        NavigationStackHost(
            id: id,
            path: path,
            pathEvent: pathEvent,
            modifiers: modifiers,
            children: children,
            onEvent: onEvent,
            customHostRegistry: customHostRegistry
        )
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
        if case let .tab(_, title, source, badge, selection, modifiers, children) = node {
            let content = tabContent(children: children)

            if let tabRole = modifiers.tabRole {
                roleTabItemView(
                    content: content,
                    title: title,
                    source: source,
                    badge: badge,
                    selection: selection,
                    role: tabRole
                )
            } else {
                content
                    .modifier(TabItemLabelModifier(title: title, source: source))
                    .modifier(TabBadgeModifier(badge: badge))
                    .modifier(TabTagModifier(selection: selection))
            }
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func roleTabItemView<Content: View>(
        content: Content,
        title: String,
        source: ImageSource?,
        badge: BadgeValue?,
        selection: PickerSelectionValue?,
        role: TabRoleKind
    ) -> some View {
        roleTabItem(content: content, title: title, source: source, badge: badge, selection: selection, role: role)
    }

    @ViewBuilder
    private func roleTabItem<Content: View>(
        content: Content,
        title: String,
        source: ImageSource?,
        badge: BadgeValue?,
        selection: PickerSelectionValue?,
        role: TabRoleKind
    ) -> some View {
        let swiftUIRole = role.swiftUIRole

        if !title.isEmpty {
            if let source {
                switch source {
                case .system(let systemName):
                    if let selection {
                        roleTabView(Tab(title, systemImage: systemName, value: selection, role: swiftUIRole) {
                            content
                        }, badge: badge)
                    } else {
                        roleTabView(Tab(title, systemImage: systemName, role: swiftUIRole) {
                            content
                        }, badge: badge)
                    }
                case .asset(let imageName):
                    if let selection {
                        roleTabView(Tab(title, image: imageName, value: selection, role: swiftUIRole) {
                            content
                        }, badge: badge)
                    } else {
                        roleTabView(Tab(title, image: imageName, role: swiftUIRole) {
                            content
                        }, badge: badge)
                    }
                }
            } else {
                if let selection {
                    roleTabView(Tab(value: selection, role: swiftUIRole) {
                        content
                    } label: {
                        Text(title)
                    }, badge: badge)
                } else {
                    roleTabView(Tab(role: swiftUIRole) {
                        content
                    } label: {
                        Text(title)
                    }, badge: badge)
                }
            }
        } else {
            if let selection {
                roleTabView(Tab(value: selection, role: swiftUIRole) {
                    content
                }, badge: badge)
            } else {
                roleTabView(Tab(role: swiftUIRole) {
                    content
                }, badge: badge)
            }
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
    private func navigationLinkView(destination: ViewNode?, value: CustomHostValue?, modifiers _: ViewModifiers, children: [ViewNode]) -> some View {
        if let destination {
            NavigationLink {
                RenderNodeView(node: destination, onEvent: onEvent, customHostRegistry: customHostRegistry)
            } label: {
                controlLabel("", fallback: "Open", children: children)
            }
        } else if let value {
            NavigationLink(value: value) {
                controlLabel("", fallback: "Open", children: children)
            }
        } else {
            controlLabel("", fallback: "Open", children: children)
        }
    }

    @ViewBuilder
    private func controlLabel(_ title: String, fallback: String, children: [ViewNode]) -> some View {
        if children.isEmpty {
            Text(title.isEmpty ? fallback : title)
        } else {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    private func shareLinkPayload(_ items: [ShareItemValue]) -> ShareLinkPayload {
        if items.count == 1 {
            switch items[0] {
            case let .text(value):
                return .text(value)
            case let .url(value):
                return .url(value)
            }
        }

        let texts = items.compactMap { item -> String? in
            if case let .text(value) = item {
                return value
            }

            return nil
        }

        if texts.count == items.count {
            return .texts(texts)
        }

        let urls = items.compactMap { item -> URL? in
            if case let .url(value) = item {
                return value
            }

            return nil
        }

        return .urls(urls)
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
    private func groupBoxView(title: String?, label: ViewNode?, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        GroupBox {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        } label: {
            if let label {
                RenderNodeView(node: label, onEvent: onEvent, customHostRegistry: customHostRegistry)
            } else if let title, !title.isEmpty {
                Text(title)
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
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
    private func sliderView(
        _ title: String,
        value: Double,
        minimumValue: Double,
        maximumValue: Double,
        step: Double?,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    ) -> some View {
        let binding = Binding(
            get: { value },
            set: { nextValue in
                onEvent(SurfaceEvent(event.name, payloadJSON: String(nextValue)))
            }
        )

        Group {
            if let step {
                Slider(value: binding, in: minimumValue ... maximumValue, step: step) {
                    controlLabel(title, fallback: "", children: children)
                }
            } else {
                Slider(value: binding, in: minimumValue ... maximumValue) {
                    controlLabel(title, fallback: "", children: children)
                }
            }
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func stepperView(
        _ title: String,
        value: Double,
        minimumValue: Double,
        maximumValue: Double,
        step: Double?,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    ) -> some View {
        Stepper(
            value: Binding(
                get: { value },
                set: { nextValue in
                    onEvent(SurfaceEvent(event.name, payloadJSON: String(nextValue)))
                }
            ),
            in: minimumValue ... maximumValue,
            step: step ?? 1
        ) {
            controlLabel(title, fallback: String(value), children: children)
        }
        .modifier(NodeAppearanceModifier(modifiers: modifiers))
        .disabled(modifiers.isDisabled)
    }

    @ViewBuilder
    private func datePickerView(
        _ title: String,
        selection: Date,
        minimumDate: Date?,
        maximumDate: Date?,
        displayedComponents: DatePickerDisplayedComponentsKind,
        event: SurfaceEvent,
        modifiers: ViewModifiers,
        children: [ViewNode]
    ) -> some View {
        let binding = Binding(
            get: { selection },
            set: { nextValue in
                onEvent(SurfaceEvent(event.name, payloadJSON: HostDateValue.stringify(nextValue).payloadJSON))
            }
        )

        datePicker(
            selection: binding,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            displayedComponents: displayedComponents,
            title: title,
            children: children
        )
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

    @ViewBuilder
    private func datePicker(
        selection: Binding<Date>,
        minimumDate: Date?,
        maximumDate: Date?,
        displayedComponents: DatePickerDisplayedComponentsKind,
        title: String,
        children: [ViewNode]
    ) -> some View {
        switch (minimumDate, maximumDate) {
        case let (.some(minimumDate), .some(maximumDate)):
            SwiftUI.DatePicker(
                selection: selection,
                in: minimumDate ... maximumDate,
                displayedComponents: displayedComponents.swiftUIDatePickerComponents
            ) {
                datePickerLabel(title: title, children: children)
            }
        case let (.some(minimumDate), nil):
            SwiftUI.DatePicker(
                selection: selection,
                in: minimumDate...,
                displayedComponents: displayedComponents.swiftUIDatePickerComponents
            ) {
                datePickerLabel(title: title, children: children)
            }
        case let (nil, .some(maximumDate)):
            SwiftUI.DatePicker(
                selection: selection,
                in: ...maximumDate,
                displayedComponents: displayedComponents.swiftUIDatePickerComponents
            ) {
                datePickerLabel(title: title, children: children)
            }
        case (nil, nil):
            SwiftUI.DatePicker(
                selection: selection,
                displayedComponents: displayedComponents.swiftUIDatePickerComponents
            ) {
                datePickerLabel(title: title, children: children)
            }
        }
    }

    @ViewBuilder
    private func datePickerLabel(title: String, children: [ViewNode]) -> some View {
        if children.isEmpty {
            Text(title)
        } else {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
    }

    private func applyCommonModifiers<Content: View>(_ content: Content, appliesNavigationChrome: Bool = true) -> some View {
        content.modifier(
            CommonNodeModifier(
                modifiers: node.modifiers,
                onEvent: onEvent,
                customHostRegistry: customHostRegistry,
                appliesNavigationChrome: appliesNavigationChrome
            )
        )
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
    private func navigationSplitView(sidebar: ViewNode, detail: ViewNode, modifiers: ViewModifiers) -> some View {
        if horizontalSizeClass == .compact {
            searchableStyled(
                CompactNavigationSplitHost(sidebar: sidebar, detail: detail, onEvent: onEvent, customHostRegistry: customHostRegistry),
                modifiers: modifiers
            )
        } else {
            searchableStyled(
                NavigationSplitView {
                    RenderNodeView(node: sidebar, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } detail: {
                    RenderNodeView(node: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
                },
                modifiers: modifiers
            )
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

struct JavaScriptLayoutSize: Codable {
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

struct JavaScriptLayoutBounds: Codable {
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

struct JavaScriptSubviewPlacement: Codable {
    let x: Double
    let y: Double
    let anchor: ContentAlignment
    let width: Double?
    let height: Double?
}

final class JavaScriptLayoutBridge: @unchecked Sendable {
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

final class GeometryReaderBridge: @unchecked Sendable {
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

final class NavigationDestinationBridge: @unchecked Sendable {
    let hasHandler: (_ id: NodeID) -> Bool
    let render: (_ id: NodeID, _ value: CustomHostValue) -> ViewNode?

    init(
        hasHandler: @escaping (_ id: NodeID) -> Bool,
        render: @escaping (_ id: NodeID, _ value: CustomHostValue) -> ViewNode?
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

private struct NavigationStackHost: View {
    let id: NodeID
    let path: [CustomHostValue]?
    let pathEvent: SurfaceEvent?
    let modifiers: ViewModifiers
    let children: [ViewNode]
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @State private var localPath: [CustomHostValue]

    init(
        id: NodeID,
        path: [CustomHostValue]?,
        pathEvent: SurfaceEvent?,
        modifiers: ViewModifiers,
        children: [ViewNode],
        onEvent: @escaping (SurfaceEvent) -> Void,
        customHostRegistry: CustomHostRegistry
    ) {
        self.id = id
        self.path = path
        self.pathEvent = pathEvent
        self.modifiers = modifiers
        self.children = children
        self.onEvent = onEvent
        self.customHostRegistry = customHostRegistry
        _localPath = State(initialValue: path ?? [])
    }

    var body: some View {
        NavigationStack(path: pathBinding) {
            navigationContent
        }
        .onChange(of: path ?? []) { _, nextPath in
            guard localPath != nextPath else {
                return
            }

            localPath = nextPath
        }
    }

    @ViewBuilder
    private var navigationContent: some View {
        searchableStyled(
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
            .modifier(NavigationDestinationModifier(id: id, onEvent: onEvent, customHostRegistry: customHostRegistry))
            .modifier(NavigationChromeModifier(isEnabled: true, modifiers: modifiers, onEvent: onEvent, customHostRegistry: customHostRegistry)),
            modifiers: modifiers
        )
    }

    private var pathBinding: Binding<[CustomHostValue]> {
        Binding(
            get: { localPath },
            set: { nextPath in
                localPath = nextPath

                if let pathEvent {
                    onEvent(SurfaceEvent(pathEvent.name, payloadJSON: nextPath.payloadJSON))
                }
            }
        )
    }

    @ViewBuilder
    private func searchableStyled<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        content
            .modifier(OptionalSearchableModifier(searchable: modifiers.searchable, onEvent: onEvent))
            .modifier(
                OptionalSearchSuggestionsModifier(
                    suggestions: modifiers.searchSuggestions,
                    onEvent: onEvent,
                    customHostRegistry: customHostRegistry
                )
            )
            .modifier(
                OptionalSearchScopesModifier(
                    searchScopes: modifiers.searchScopes,
                    onEvent: onEvent,
                    customHostRegistry: customHostRegistry
                )
            )
    }
}

private struct NavigationDestinationModifier: ViewModifier {
    let id: NodeID
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    @ViewBuilder
    func body(content: Content) -> some View {
        if let bridge = customHostRegistry.navigationDestinationBridge, bridge.hasHandler(id) {
            content.navigationDestination(for: CustomHostValue.self) { value in
                if let node = bridge.render(id, value) {
                    RenderNodeView(node: node, onEvent: onEvent, customHostRegistry: customHostRegistry)
                } else {
                    EmptyView()
                }
            }
        } else {
            content
        }
    }
}

private enum ShareLinkPayload {
    case text(String)
    case texts([String])
    case url(URL)
    case urls([URL])
}

private extension RenderNodeView {
    @ViewBuilder
    func styledControl<Content: View>(_ content: Content, modifiers: ViewModifiers) -> some View {
        switch modifiers.buttonStyle ?? .automatic {
        case .automatic:
            shapedButton(content, modifiers: modifiers)
        case .borderless:
            shapedButton(content.buttonStyle(.borderless), modifiers: modifiers)
        case .plain:
            shapedButton(content.buttonStyle(.plain), modifiers: modifiers)
        case .bordered:
            shapedButton(content.buttonStyle(.bordered), modifiers: modifiers)
        case .borderedProminent:
            shapedButton(content.buttonStyle(.borderedProminent), modifiers: modifiers)
        case .glass:
            shapedButton(content.buttonStyle(.glass(glassValue(for: modifiers))), modifiers: modifiers)
        case .glassProminent:
            shapedButton(content.buttonStyle(.glassProminent), modifiers: modifiers)
        }
    }

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

struct HostToolbarItem: Decodable {
    let kind: ToolbarContentKind?
    let placement: ToolbarItemPlacementKind
    let content: HostNode?
    let sizing: ToolbarSpacerSizingKind?
}

struct HostSafeAreaInset: Decodable {
    let edge: EdgeKind
    let spacing: Double?
    let content: HostNode
}

enum HostShareItemKind: String, Decodable {
    case text
    case url
}

struct HostShareItem: Decodable {
    let kind: HostShareItemKind
    let value: String
}

struct HostSwipeActions: Decodable {
    let items: [HostNode]
    let edge: HorizontalEdgeKind?
    let allowsFullSwipe: Bool?

    func makeValue() throws -> SwipeActionsValue {
        SwipeActionsValue(
            items: try items.map { try $0.makeViewNode() },
            edge: edge ?? .trailing,
            allowsFullSwipe: allowsFullSwipe ?? true
        )
    }
}

final class HostNode: Decodable {
    let type: HostComponentType
    let id: String
    let alignment: ContentAlignment?
    let viewIdentity: CustomHostValue?
    let tag: PickerSelectionValue?
    let accessibilityLabel: String?
    let accessibilityHint: String?
    let accessibilityValue: String?
    let accessibilityAddTraits: [AccessibilityTraitKind]?
    let accessibilityRemoveTraits: [AccessibilityTraitKind]?
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
    let viewBadge: BadgeValue?
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
    let buttonSizing: ButtonSizingKind?
    let contentShape: ContentShapeKind?
    let clipShape: ShapeValue?
    let clipped: Bool?
    let isDisabled: Bool?
    let moveDisabled: Bool?
    let glassEffect: Bool?
    let glassVariant: GlassVariantKind?
    let glassTint: String?
    let glassShape: ShapeValue?
    let glassInteractive: Bool?
    let glassID: String?
    let glassUnionID: String?
    let scrollEdgeEffectStyle: ScrollEdgeEffectStyleKind?
    let scrollEdgeEffectEdge: EdgeKind?
    let editMode: EditModeKind?
    let editModeEvent: String?
    let navigationTitle: String?
    let navigationBarTitleDisplayMode: NavigationBarTitleDisplayModeKind?
    let navigationLinkIndicatorVisibility: VisibilityKind?
    let tabBarMinimizeBehavior: TabBarMinimizeBehaviorKind?
    let tabViewBottomAccessoryEnabled: Bool?
    let tabViewBottomAccessory: HostNode?
    let toolbarRole: ToolbarRoleKind?
    let searchableText: String?
    let searchablePrompt: String?
    let searchableEvent: String?
    let searchableIsPresented: Bool?
    let searchablePresentationEvent: String?
    let searchableSubmitEvent: String?
    let searchSuggestionsContent: [HostNode]?
    let searchScopesSelection: PickerSelectionValue?
    let searchScopesEvent: String?
    let searchScopesContent: [HostNode]?
    let searchCompletion: String?
    let tabRole: String?
    let searchablePlacement: SearchFieldPlacementKind?
    let searchablePlacementNavigationBarDrawerDisplayMode: SearchFieldNavigationBarDrawerDisplayModeKind?
    let searchPresentationToolbarBehavior: SearchPresentationToolbarBehaviorKind?
    let searchToolbarBehavior: SearchToolbarBehaviorKind?
    let toolbarItems: [HostToolbarItem]?
    let toolbarBackgroundVisibility: VisibilityKind?
    let toolbarColorScheme: ColorSchemeKind?
    let listStyle: ListStyleKind?
    let pickerStyle: PickerStyleKind?
    let keyboardType: KeyboardTypeKind?
    let textInputAutocapitalization: TextInputAutocapitalizationKind?
    let autocorrectionDisabled: Bool?
    let submitLabel: SubmitLabelKind?
    let submitEvent: String?
    let sensoryFeedback: SensoryFeedbackKind?
    let sensoryFeedbackTrigger: CustomHostValue?
    let sensoryFeedbackWeight: SensoryFeedbackWeightKind?
    let sensoryFeedbackFlexibility: SensoryFeedbackFlexibilityKind?
    let sensoryFeedbackIntensity: Double?
    let sensoryFeedbackIsEnabled: Bool?
    let scrollContentBackground: VisibilityKind?
    let listRowSeparator: VisibilityKind?
    let listSectionSeparator: VisibilityKind?
    let listRowInsetTop: Double?
    let listRowInsetLeading: Double?
    let listRowInsetBottom: Double?
    let listRowInsetTrailing: Double?
    let listRowBackground: ShapeStyleValue?
    let draggable: TransferItemValue?
    let dropDestinationContentTypes: [String]?
    let dropDestinationEvent: String?
    let dropDestinationTargetedEvent: String?
    let swipeActions: [HostSwipeActions]?
    let contentMargins: [ContentMarginsValue]?
    let imageContentMode: ImageContentMode?
    let imageResizable: Bool?
    let imageResizableCapInsetTop: Double?
    let imageResizableCapInsetLeading: Double?
    let imageResizableCapInsetBottom: Double?
    let imageResizableCapInsetTrailing: Double?
    let imageResizingMode: ImageResizingModeKind?
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
    let textLineSpacing: Double?
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
    let contextMenuActions: [DialogActionValue]?
    let contextMenuPreview: HostNode?
    let role: ButtonRoleKind?
    let onAppearEvent: String?
    let value: String?
    let textSegments: [TextSegmentValue]?
    let prompt: String?
    let textContentType: TextContentTypeKind?
    let systemName: String?
    let name: String?
    let title: String?
    let header: HostNode?
    let footer: HostNode?
    let description: HostNode?
    let label: HostNode?
    let placeholder: HostNode?
    let empty: HostNode?
    let failure: HostNode?
    let currentValueLabel: HostNode?
    let event: String?
    let onDismiss: String?
    let isOn: Bool?
    let isPresented: Bool?
    let path: [CustomHostValue]?
    let pathEvent: String?
    let progressValue: Double?
    let progressTotal: Double?
    let numericValue: Double?
    let minimumValue: Double?
    let maximumValue: Double?
    let step: Double?
    let selectionValues: [PickerSelectionValue]?
    let selectionEvent: String?
    let moveEvent: String?
    let selection: PickerSelectionValue?
    let dateSelection: String?
    let minimumDate: String?
    let maximumDate: String?
    let displayedComponents: DatePickerDisplayedComponentsKind?
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
    let destinationURL: String?
    let url: String?
    let html: String?
    let baseURL: String?
    let webJavaScriptEnabled: Bool?
    let webAllowsBackForwardNavigationGestures: Bool?
    let latitude: Double?
    let longitude: Double?
    let latitudeDelta: Double?
    let longitudeDelta: Double?
    let mapMarkers: [MapMarkerValue]?
    let chartData: [ChartPointValue]?
    let chartMark: ChartMarkKind?
    let deleteEvent: String?
    let shareItem: HostShareItem?
    let shareItems: [HostShareItem]?
    let shareSubject: String?
    let shareMessage: String?
    let destination: HostNode?
    let navigationValue: CustomHostValue?
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
        case .forEach:
            return .forEach(
                id: NodeID(id),
                moveEvent: moveEvent.map { SurfaceEvent($0) },
                deleteEvent: deleteEvent.map { SurfaceEvent($0) },
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .glassEffectContainer:
            return .glassEffectContainer(
                id: NodeID(id),
                spacing: spacing ?? 16,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .list:
            return .list(
                id: NodeID(id),
                selection: selectionValues.map(Set.init),
                selectionEvent: selectionEvent.map { SurfaceEvent($0) },
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
                header: try header?.makeViewNode(),
                footer: try footer?.makeViewNode(),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .navigationStack:
            return .navigationStack(
                id: NodeID(id),
                path: path,
                pathEvent: pathEvent.map { SurfaceEvent($0) },
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .navigationLink:
            if destination == nil, navigationValue == nil {
                throw JSSurfaceError.invalidTree("NavigationLink node '\(id)' is missing a destination or value")
            }

            return .navigationLink(
                id: NodeID(id),
                modifiers: modifiers,
                destination: try destination?.makeViewNode(),
                value: navigationValue,
                children: try mapChildren()
            )
        case .link:
            return .link(
                id: NodeID(id),
                title: title ?? "",
                destination: try makeURL(destinationURL, name: "destination"),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .webView:
            let parsedURL = try makeOptionalURL(url, name: "url")
            let parsedBaseURL = try makeOptionalURL(baseURL, name: "baseURL")
            if parsedURL == nil, html == nil {
                throw JSSurfaceError.invalidTree("WebView node '\(id)' is missing url or html")
            }

            return .webView(
                id: NodeID(id),
                url: parsedURL,
                html: html,
                baseURL: parsedBaseURL,
                javaScriptEnabled: webJavaScriptEnabled ?? true,
                allowsBackForwardNavigationGestures: webAllowsBackForwardNavigationGestures ?? false,
                modifiers: modifiers
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
                segments: textSegments ?? [],
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
        case .progressView:
            return .progressView(
                id: NodeID(id),
                value: progressValue,
                total: progressTotal,
                label: try label?.makeViewNode(),
                currentValueLabel: try currentValueLabel?.makeViewNode(),
                modifiers: modifiers
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
        case .asyncImage:
            return .asyncImage(
                id: NodeID(id),
                url: try makeURL(url, name: "url"),
                placeholder: try placeholder?.makeViewNode(),
                empty: try empty?.makeViewNode(),
                failure: try failure?.makeViewNode(),
                modifiers: modifiers
            )
        case .map:
            guard let latitude, let longitude else {
                throw JSSurfaceError.invalidTree("Map node '\(id)' is missing latitude or longitude")
            }

            return .map(
                id: NodeID(id),
                latitude: latitude,
                longitude: longitude,
                latitudeDelta: latitudeDelta ?? 0.01,
                longitudeDelta: longitudeDelta ?? 0.01,
                markers: mapMarkers ?? [],
                modifiers: modifiers
            )
        case .chart:
            guard let chartData, !chartData.isEmpty else {
                throw JSSurfaceError.invalidTree("Chart node '\(id)' is missing data")
            }

            return .chart(
                id: NodeID(id),
                data: chartData,
                mark: chartMark ?? .bar,
                modifiers: modifiers
            )
        case .videoPlayer:
            return .videoPlayer(
                id: NodeID(id),
                url: try makeURL(url, name: "url"),
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
                role: role,
                event: SurfaceEvent(event),
                modifiers: modifiers,
                children: childNodes
            )
        case .editButton:
            return .editButton(
                id: NodeID(id),
                modifiers: modifiers
            )
        case .shareLink:
            let childNodes = try mapChildren()
            return .shareLink(
                id: NodeID(id),
                title: title ?? "",
                items: try makeShareItems(),
                subject: shareSubject,
                message: shareMessage,
                modifiers: modifiers,
                children: childNodes
            )
        case .textField:
            guard let event else {
                throw JSSurfaceError.invalidTree("TextField node '\(id)' is missing an onChange event")
            }

            guard let value else {
                throw JSSurfaceError.invalidTree("TextField node '\(id)' is missing a text value")
            }

            return .textField(
                id: NodeID(id),
                title: title ?? "",
                text: value,
                prompt: prompt,
                textContentType: textContentType,
                event: SurfaceEvent(event),
                modifiers: modifiers
            )
        case .secureField:
            guard let event else {
                throw JSSurfaceError.invalidTree("SecureField node '\(id)' is missing an onChange event")
            }

            guard let value else {
                throw JSSurfaceError.invalidTree("SecureField node '\(id)' is missing a text value")
            }

            return .secureField(
                id: NodeID(id),
                title: title ?? "",
                text: value,
                prompt: prompt,
                textContentType: textContentType,
                event: SurfaceEvent(event),
                modifiers: modifiers
            )
        case .textEditor:
            guard let event else {
                throw JSSurfaceError.invalidTree("TextEditor node '\(id)' is missing an onChange event")
            }

            guard let value else {
                throw JSSurfaceError.invalidTree("TextEditor node '\(id)' is missing a text value")
            }

            return .textEditor(
                id: NodeID(id),
                text: value,
                event: SurfaceEvent(event),
                modifiers: modifiers
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
        case .groupBox:
            return .groupBox(
                id: NodeID(id),
                title: title,
                label: try label?.makeViewNode(),
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
                children: try label.map { [try $0.makeViewNode()] } ?? mapChildren()
            )
        case .slider:
            guard let event else {
                throw JSSurfaceError.invalidTree("Slider node '\(id)' is missing an onChange event")
            }

            guard let numericValue else {
                throw JSSurfaceError.invalidTree("Slider node '\(id)' is missing a value")
            }

            guard let minimumValue, let maximumValue else {
                throw JSSurfaceError.invalidTree("Slider node '\(id)' is missing range bounds")
            }

            return .slider(
                id: NodeID(id),
                title: title ?? "",
                value: numericValue,
                minimumValue: minimumValue,
                maximumValue: maximumValue,
                step: step,
                event: SurfaceEvent(event),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .stepper:
            guard let event else {
                throw JSSurfaceError.invalidTree("Stepper node '\(id)' is missing an onChange event")
            }

            guard let numericValue else {
                throw JSSurfaceError.invalidTree("Stepper node '\(id)' is missing a value")
            }

            guard let minimumValue, let maximumValue else {
                throw JSSurfaceError.invalidTree("Stepper node '\(id)' is missing range bounds")
            }

            return .stepper(
                id: NodeID(id),
                title: title ?? "",
                value: numericValue,
                minimumValue: minimumValue,
                maximumValue: maximumValue,
                step: step,
                event: SurfaceEvent(event),
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .datePicker:
            guard let event else {
                throw JSSurfaceError.invalidTree("DatePicker node '\(id)' is missing an onChange event")
            }

            guard let dateSelection else {
                throw JSSurfaceError.invalidTree("DatePicker node '\(id)' is missing a selection value")
            }

            guard let selection = HostDateValue.parse(dateSelection) else {
                throw JSSurfaceError.invalidTree("DatePicker node '\(id)' has an invalid selection value '\(dateSelection)'")
            }

            let parsedMinimumDate = minimumDate.flatMap(HostDateValue.parse)
            if minimumDate != nil, parsedMinimumDate == nil {
                throw JSSurfaceError.invalidTree("DatePicker node '\(id)' has an invalid minimumDate value '\(minimumDate!)'")
            }

            let parsedMaximumDate = maximumDate.flatMap(HostDateValue.parse)
            if maximumDate != nil, parsedMaximumDate == nil {
                throw JSSurfaceError.invalidTree("DatePicker node '\(id)' has an invalid maximumDate value '\(maximumDate!)'")
            }

            if let parsedMinimumDate, let parsedMaximumDate, parsedMinimumDate > parsedMaximumDate {
                throw JSSurfaceError.invalidTree("DatePicker node '\(id)' has a minimumDate later than maximumDate")
            }

            return .datePicker(
                id: NodeID(id),
                title: title ?? "",
                selection: selection,
                minimumDate: parsedMinimumDate,
                maximumDate: parsedMaximumDate,
                displayedComponents: displayedComponents ?? .dateAndTime,
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
            tag: tag,
            accessibilityLabel: accessibilityLabel,
            accessibilityHint: accessibilityHint,
            accessibilityValue: accessibilityValue,
            accessibilityAddTraits: accessibilityAddTraits ?? [],
            accessibilityRemoveTraits: accessibilityRemoveTraits ?? [],
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
            badge: viewBadge,
            cornerRadius: cornerRadius,
            fontStyle: fontName,
            fontSize: fontSize,
            fontWeight: fontWeight,
            symbolRenderingMode: symbolRenderingMode,
            buttonStyle: buttonStyle,
            buttonBorderShape: buttonBorderShape,
            buttonSizing: buttonSizing,
            contentShape: contentShape,
            clipShape: clipShape,
            clipped: clipped ?? false,
            isDisabled: isDisabled ?? false,
            moveDisabled: moveDisabled ?? false,
            glassEffect: glassEffect ?? false,
            glassVariant: glassVariant ?? .regular,
            glassTint: glassTint,
            glassShape: glassShape,
            glassInteractive: glassInteractive ?? false,
            glassID: glassID,
            glassUnionID: glassUnionID,
            scrollEdgeEffectStyle: scrollEdgeEffectStyle,
            scrollEdgeEffectEdge: scrollEdgeEffectEdge ?? .top,
            editMode: editMode,
            editModeEvent: editModeEvent.map { SurfaceEvent($0) },
            navigationTitle: navigationTitle,
            navigationBarTitleDisplayMode: navigationBarTitleDisplayMode,
            navigationLinkIndicatorVisibility: navigationLinkIndicatorVisibility,
            tabBarMinimizeBehavior: tabBarMinimizeBehavior,
            tabViewBottomAccessory: try makeTabViewBottomAccessory(),
            toolbarRole: toolbarRole,
            searchable: makeSearchable(),
            searchSuggestions: try makeSearchSuggestions(),
            searchScopes: try makeSearchScopes(),
            searchCompletion: searchCompletion,
            tabRole: try makeTabRole(),
            searchPresentationToolbarBehavior: searchPresentationToolbarBehavior,
            searchToolbarBehavior: searchToolbarBehavior,
            toolbarItems: try mapToolbarItems(),
            toolbarBackgroundVisibility: toolbarBackgroundVisibility,
            toolbarColorScheme: toolbarColorScheme,
            listStyle: listStyle,
            pickerStyle: pickerStyle,
            keyboardType: keyboardType,
            textInputAutocapitalization: textInputAutocapitalization,
            autocorrectionDisabled: autocorrectionDisabled,
            submitLabel: submitLabel,
            submitEvent: submitEvent.map { SurfaceEvent($0) },
            sensoryFeedback: try makeSensoryFeedback(),
            scrollContentBackground: scrollContentBackground,
            listRowSeparator: listRowSeparator,
            listSectionSeparator: listSectionSeparator,
            listRowInsets: makeListRowInsets(),
            listRowBackground: listRowBackground,
            draggable: draggable,
            dropDestination: try makeDropDestination(),
            swipeActions: try mapSwipeActions(),
            contentMargins: contentMargins ?? [],
            imageContentMode: imageContentMode,
            imageResizable: imageResizable ?? false,
            imageResizableCapInsets: makeImageResizableCapInsets(),
            imageResizingMode: imageResizingMode,
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
            lineSpacing: textLineSpacing,
            multilineTextAlignment: multilineTextAlignment,
            truncationMode: truncationMode,
            minimumScaleFactor: minimumScaleFactor,
            presentationDetents: presentationDetents ?? [],
            presentationDragIndicator: presentationDragIndicator,
            presentationCornerRadius: presentationCornerRadius,
            presentationBackgroundInteraction: makePresentationBackgroundInteraction(),
            alert: try makeAlert(),
            confirmationDialog: try makeConfirmationDialog(),
            contextMenu: try makeContextMenu(),
            onAppearEvent: onAppearEvent.map { SurfaceEvent($0) }
        )
    }

    private func mapToolbarItems() throws -> [ToolbarItemValue] {
        try (toolbarItems ?? []).map { item in
            let kind = item.kind ?? .item
            switch kind {
            case .item:
                guard let content = item.content else {
                    throw JSSurfaceError.invalidTree("Toolbar item on node '\(id)' is missing content")
                }

                return ToolbarItemValue(
                    kind: .item,
                    placement: item.placement,
                    content: try content.makeViewNode(),
                    sizing: nil
                )
            case .spacer:
                return ToolbarItemValue(
                    kind: .spacer,
                    placement: item.placement,
                    content: nil,
                    sizing: item.sizing ?? .flexible
                )
            }
        }
    }

    private func mapSwipeActions() throws -> [SwipeActionsValue] {
        try (swipeActions ?? []).map { try $0.makeValue() }
    }

    private func makeDropDestination() throws -> DropDestinationValue? {
        if dropDestinationContentTypes == nil, dropDestinationEvent == nil, dropDestinationTargetedEvent == nil {
            return nil
        }

        guard let dropDestinationEvent else {
            throw JSSurfaceError.invalidTree("Node '\(id)' is missing a drop destination action")
        }

        return DropDestinationValue(
            contentTypes: dropDestinationContentTypes,
            event: SurfaceEvent(dropDestinationEvent),
            targetedEvent: dropDestinationTargetedEvent.map { SurfaceEvent($0) }
        )
    }

    private func makeSearchable() -> SearchableValue? {
        guard let searchableText, let searchableEvent else {
            return nil
        }

        return SearchableValue(
            text: searchableText,
            prompt: searchablePrompt,
            placement: SearchFieldPlacementValue(
                kind: searchablePlacement ?? .automatic,
                navigationBarDrawerDisplayMode: searchablePlacementNavigationBarDrawerDisplayMode
            ),
            isPresented: searchableIsPresented,
            event: SurfaceEvent(searchableEvent),
            presentationEvent: searchablePresentationEvent.map { SurfaceEvent($0) },
            submitEvent: searchableSubmitEvent.map { SurfaceEvent($0) }
        )
    }

    private func makeSearchSuggestions() throws -> SearchSuggestionsValue? {
        guard let searchSuggestionsContent else {
            return nil
        }

        return SearchSuggestionsValue(content: try searchSuggestionsContent.map { try $0.makeViewNode() })
    }

    private func makeSearchScopes() throws -> SearchScopesValue? {
        if searchScopesSelection == nil, searchScopesEvent == nil, searchScopesContent == nil {
            return nil
        }

        guard let searchScopesSelection else {
            throw JSSurfaceError.invalidTree("Node '\(id)' is missing a search scopes selection")
        }

        guard let searchScopesEvent else {
            throw JSSurfaceError.invalidTree("Node '\(id)' is missing a search scopes event")
        }

        guard let searchScopesContent else {
            throw JSSurfaceError.invalidTree("Node '\(id)' is missing search scopes content")
        }

        return SearchScopesValue(
            selection: searchScopesSelection,
            event: SurfaceEvent(searchScopesEvent),
            content: try searchScopesContent.map { try $0.makeViewNode() }
        )
    }

    private func makeTabViewBottomAccessory() throws -> TabViewBottomAccessoryValue? {
        guard let tabViewBottomAccessory else {
            return nil
        }

        return TabViewBottomAccessoryValue(
            isEnabled: tabViewBottomAccessoryEnabled ?? true,
            content: try tabViewBottomAccessory.makeViewNode()
        )
    }

    private func makeSensoryFeedback() throws -> SensoryFeedbackValue? {
        guard let sensoryFeedback else {
            return nil
        }

        guard let sensoryFeedbackTrigger else {
            throw JSSurfaceError.invalidTree("Node '\(id)' has sensoryFeedback without a trigger")
        }

        return SensoryFeedbackValue(
            feedback: sensoryFeedback,
            trigger: sensoryFeedbackTrigger,
            weight: sensoryFeedbackWeight,
            flexibility: sensoryFeedbackFlexibility,
            intensity: sensoryFeedbackIntensity,
            isEnabled: sensoryFeedbackIsEnabled ?? true
        )
    }

    private func makeTabRole() throws -> TabRoleKind? {
        guard let tabRole else {
            return nil
        }

        guard let role = TabRoleKind(rawValue: tabRole) else {
            throw JSSurfaceError.invalidTree("Node '\(id)' has an invalid tab role '\(tabRole)'")
        }

        return role
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

    private func makeImageResizableCapInsets() -> EdgeInsetsValue? {
        if imageResizableCapInsetTop == nil,
           imageResizableCapInsetLeading == nil,
           imageResizableCapInsetBottom == nil,
           imageResizableCapInsetTrailing == nil {
            return nil
        }

        return EdgeInsetsValue(
            top: imageResizableCapInsetTop,
            leading: imageResizableCapInsetLeading,
            bottom: imageResizableCapInsetBottom,
            trailing: imageResizableCapInsetTrailing
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

    private func makeContextMenu() throws -> ContextMenuValue? {
        guard contextMenuActions != nil || contextMenuPreview != nil else {
            return nil
        }

        return ContextMenuValue(
            actions: contextMenuActions ?? [],
            preview: try contextMenuPreview?.makeViewNode()
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

    private func makeURL(_ value: String?, name: String) throws -> URL {
        guard let value, let url = URL(string: value), url.scheme != nil else {
            throw JSSurfaceError.invalidTree("\(type.rawValue) node '\(id)' has an invalid \(name) URL")
        }

        return url
    }

    private func makeOptionalURL(_ value: String?, name: String) throws -> URL? {
        guard let value else { return nil }
        guard let url = URL(string: value), url.scheme != nil else {
            throw JSSurfaceError.invalidTree("\(type.rawValue) node '\(id)' has an invalid \(name) URL")
        }

        return url
    }

    private func makeShareItems() throws -> [ShareItemValue] {
        if shareItem != nil, shareItems != nil {
            throw JSSurfaceError.invalidTree("ShareLink node '\(id)' cannot define both item and items")
        }

        let serializedItems: [HostShareItem]
        if let shareItem {
            serializedItems = [shareItem]
        } else if let shareItems, !shareItems.isEmpty {
            serializedItems = shareItems
        } else {
            throw JSSurfaceError.invalidTree("ShareLink node '\(id)' is missing an item")
        }

        let items = try serializedItems.map { item in
            switch item.kind {
            case .text:
                return ShareItemValue.text(item.value)
            case .url:
                return ShareItemValue.url(try makeURL(item.value, name: "item"))
            }
        }

        let hasText = items.contains { item in
            if case .text = item {
                return true
            }

            return false
        }

        let hasURL = items.contains { item in
            if case .url = item {
                return true
            }

            return false
        }

        if hasText, hasURL {
            throw JSSurfaceError.invalidTree("ShareLink node '\(id)' cannot mix text and URL items")
        }

        return items
    }

    private func required<Value>(_ value: Value?, name: String) throws -> Value {
        guard let value else {
            throw JSSurfaceError.invalidTree("\(type.rawValue) node '\(id)' is missing a \(name)")
        }

        return value
    }
}

enum HostComponentType: String, Decodable {
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
    case forEach = "ForEach"
    case glassEffectContainer = "GlassEffectContainer"
    case list = "List"
    case form = "Form"
    case section = "Section"
    case navigationStack = "NavigationStack"
    case navigationLink = "NavigationLink"
    case link = "Link"
    case webView = "WebView"
    case sheet = "Sheet"
    case fullScreenCover = "FullScreenCover"
    case tabView = "TabView"
    case tab = "Tab"
    case navigationSplitView = "NavigationSplitView"
    case spacer = "Spacer"
    case text = "Text"
    case label = "Label"
    case contentUnavailable = "ContentUnavailableView"
    case progressView = "ProgressView"
    case image = "Image"
    case asyncImage = "AsyncImage"
    case map = "Map"
    case chart = "Chart"
    case videoPlayer = "VideoPlayer"
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
    case editButton = "EditButton"
    case shareLink = "ShareLink"
    case textField = "TextField"
    case secureField = "SecureField"
    case textEditor = "TextEditor"
    case menu = "Menu"
    case disclosureGroup = "DisclosureGroup"
    case controlGroup = "ControlGroup"
    case groupBox = "GroupBox"
    case picker = "Picker"
    case slider = "Slider"
    case stepper = "Stepper"
    case datePicker = "DatePicker"
    case toggle = "Toggle"
}

private struct SwiftJSWebView: UIViewRepresentable {
    let url: URL?
    let html: String?
    let baseURL: URL?
    let javaScriptEnabled: Bool
    let allowsBackForwardNavigationGestures: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = javaScriptEnabled
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures
        load(webView, coordinator: context.coordinator)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures
        guard context.coordinator.loadedURL != url ||
            context.coordinator.loadedHTML != html ||
            context.coordinator.loadedBaseURL != baseURL else { return }
        load(webView, coordinator: context.coordinator)
    }

    private func load(_ webView: WKWebView, coordinator: Coordinator) {
        coordinator.loadedURL = url
        coordinator.loadedHTML = html
        coordinator.loadedBaseURL = baseURL
        if let url {
            webView.load(URLRequest(url: url))
        } else {
            webView.loadHTMLString(html ?? "", baseURL: baseURL)
        }
    }

    final class Coordinator {
        var loadedURL: URL?
        var loadedHTML: String?
        var loadedBaseURL: URL?
    }
}

enum JSSurfaceError: LocalizedError {
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
