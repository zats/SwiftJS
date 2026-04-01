import Foundation
import JavaScriptCore
import Observation
import SwiftUI

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
    case headline
    case subheadline
    case body
    case caption
    case footnote
}

public enum FontWeight: String, Codable, Equatable, Sendable {
    case regular
    case medium
    case semibold
    case bold
}

public enum SymbolRenderingMode: String, Codable, Equatable, Sendable {
    case monochrome
    case hierarchical
    case multicolor
}

public enum ButtonStyle: String, Codable, Equatable, Sendable {
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

public enum ListStyleKind: String, Codable, Equatable, Sendable {
    case automatic
    case plain
    case insetGrouped
    case sidebar
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
    public var background: String?
    public var foregroundColor: String?
    public var cornerRadius: Double?
    public var fontStyle: TextStyle?
    public var fontSize: Double?
    public var fontWeight: FontWeight?
    public var symbolRenderingMode: SymbolRenderingMode?
    public var buttonStyle: ButtonStyle?
    public var buttonBorderShape: ButtonBorderShape?
    public var isDisabled: Bool
    public var glassEffect: Bool
    public var glassTint: String?
    public var navigationTitle: String?
    public var listStyle: ListStyleKind?
    public var imageContentMode: ImageContentMode?
    public var imageInterpolation: ImageInterpolation?
    public var aspectRatio: Double?
    public var aspectRatioContentMode: ImageContentMode?
    public var fixedSizeHorizontal: Bool
    public var fixedSizeVertical: Bool
    public var compactVertical: Bool
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
        background: String? = nil,
        foregroundColor: String? = nil,
        cornerRadius: Double? = nil,
        fontStyle: TextStyle? = nil,
        fontSize: Double? = nil,
        fontWeight: FontWeight? = nil,
        symbolRenderingMode: SymbolRenderingMode? = nil,
        buttonStyle: ButtonStyle? = nil,
        buttonBorderShape: ButtonBorderShape? = nil,
        isDisabled: Bool = false,
        glassEffect: Bool = false,
        glassTint: String? = nil,
        navigationTitle: String? = nil,
        listStyle: ListStyleKind? = nil,
        imageContentMode: ImageContentMode? = nil,
        imageInterpolation: ImageInterpolation? = nil,
        aspectRatio: Double? = nil,
        aspectRatioContentMode: ImageContentMode? = nil,
        fixedSizeHorizontal: Bool = false,
        fixedSizeVertical: Bool = false,
        compactVertical: Bool = false,
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
        self.cornerRadius = cornerRadius
        self.fontStyle = fontStyle
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.symbolRenderingMode = symbolRenderingMode
        self.buttonStyle = buttonStyle
        self.buttonBorderShape = buttonBorderShape
        self.isDisabled = isDisabled
        self.glassEffect = glassEffect
        self.glassTint = glassTint
        self.navigationTitle = navigationTitle
        self.listStyle = listStyle
        self.imageContentMode = imageContentMode
        self.imageInterpolation = imageInterpolation
        self.aspectRatio = aspectRatio
        self.aspectRatioContentMode = aspectRatioContentMode
        self.fixedSizeHorizontal = fixedSizeHorizontal
        self.fixedSizeVertical = fixedSizeVertical
        self.compactVertical = compactVertical
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
    case image(
        id: NodeID,
        source: ImageSource,
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
             let .navigationSplitView(id, _, _, _),
             let .spacer(id, _),
             let .text(id, _, _),
             let .label(id, _, _, _),
             let .image(id, _, _),
             let .divider(id, _),
             let .button(id, _, _, _, _),
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
             let .navigationSplitView(_, modifiers, _, _),
             let .spacer(_, modifiers),
             let .text(_, _, modifiers),
             let .label(_, _, _, modifiers),
             let .image(_, _, modifiers),
             let .divider(_, modifiers),
             let .button(_, _, _, modifiers, _),
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

    fileprivate var isCompactVerticalGridRow: Bool {
        if case let .gridRow(_, _, modifiers, _) = self {
            return modifiers.compactVertical
        }

        return false
    }

    fileprivate var gridRowChildren: [ViewNode] {
        if case let .gridRow(_, _, _, children) = self {
            return children
        }

        return [self]
    }
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

public struct JSSurfaceView: View {
    @Bindable private var runtime: JSSurfaceRuntime

    public init(runtime: JSSurfaceRuntime) {
        self.runtime = runtime
    }

    public var body: some View {
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
public final class JSSurfaceRuntime {
    public private(set) var rootNode: ViewNode?
    public private(set) var errorMessage: String?
    public private(set) var customHostRegistry: CustomHostRegistry

    private let source: JSScriptSource
    private var context: JSContext
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private var didStart = false
    private var activeLayoutMeasurementStack: [(Int, ProposedViewSize) -> CGSize] = []

    public init(source: JSScriptSource, customHostRegistry: CustomHostRegistry = .init()) {
        self.source = source
        self.customHostRegistry = customHostRegistry
        self.context = Self.makeContext()
        installBridge()
        installGeometryReaderBridge()
        installJavaScriptLayoutBridge()
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
        rootNode = nil
        errorMessage = nil
        didStart = false
        context = Self.makeContext()
        installBridge()
        installGeometryReaderBridge()
        installJavaScriptLayoutBridge()
        start()
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

        let console = JSValue(newObjectIn: context)
        console?.setObject(log, forKeyedSubscript: "log" as NSString)

        context.setObject(commit, forKeyedSubscript: "__swiftjs_commit" as NSString)
        context.setObject(report, forKeyedSubscript: "__swiftjs_reportError" as NSString)
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
        do {
            let data = Data(payload.utf8)
            let hostNode = try decoder.decode(HostNode.self, from: data)
            rootNode = try hostNode.makeViewNode()
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

private struct RenderNodeView: View {
    let node: ViewNode
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry
    #if canImport(UIKit)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

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
        case let .image(_, source, modifiers):
            applyCommonModifiers(
                imageView(source, modifiers: modifiers)
            )
        case .divider:
            applyCommonModifiers(Divider())
        case let .button(_, title, event, modifiers, children):
            applyCommonModifiers(
                buttonView(title, event: event, modifiers: modifiers, children: children)
            )
        case let .toggle(_, title, isOn, event, modifiers, children):
            applyCommonModifiers(
                toggleView(title, isOn: isOn, event: event, modifiers: modifiers, children: children)
            )
        }
    }

    @ViewBuilder
    private func gridRowView(alignment: ContentAlignment, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        #if canImport(UIKit)
        if horizontalSizeClass == .compact && modifiers.compactVertical {
            GridRow {
                VStack(alignment: alignment.swiftUIHorizontalAlignment, spacing: 12) {
                    ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .gridCellColumns(max(children.count, 1))
            }
        } else {
            GridRow {
                ForEach(children) { child in
                    RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
        }
        #else
        GridRow {
            ForEach(children) { child in
                RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
        #endif
    }

    @ViewBuilder
    private func gridView(horizontalSpacing: Double, verticalSpacing: Double, children: [ViewNode]) -> some View {
        #if canImport(UIKit)
        if horizontalSizeClass == .compact, children.allSatisfy(\.isCompactVerticalGridRow) {
            VStack(alignment: .leading, spacing: verticalSpacing) {
                ForEach(children.flatMap(\.gridRowChildren)) { child in
            RenderNodeView(node: child, onEvent: onEvent, customHostRegistry: customHostRegistry)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else {
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
        #else
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
        #endif
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

        switch modifiers.buttonStyle ?? .plain {
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
        content.modifier(CommonNodeModifier(modifiers: node.modifiers, onEvent: onEvent))
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
    private func hStackView(alignment: ContentAlignment, distribution: StackDistribution, spacing: Double, modifiers: ViewModifiers, children: [ViewNode]) -> some View {
        #if canImport(UIKit)
        if horizontalSizeClass == .compact && modifiers.compactVertical {
            VStack(alignment: alignment.swiftUIHorizontalAlignment, spacing: spacing) {
                ForEach(children) { child in
                    stackItemView(child, axis: .vertical, distribution: distribution, alignment: alignment)
                }
            }
        } else {
            HStack(alignment: alignment.swiftUIVerticalAlignment, spacing: spacing) {
                ForEach(children) { child in
                    stackItemView(child, axis: .horizontal, distribution: distribution, alignment: alignment)
                }
            }
        }
        #else
        HStack(alignment: alignment.swiftUIVerticalAlignment, spacing: spacing) {
            ForEach(children) { child in
                stackItemView(child, axis: .horizontal, distribution: distribution, alignment: alignment)
            }
        }
        #endif
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
        #if canImport(UIKit)
        if horizontalSizeClass == .compact {
            CompactNavigationSplitHost(sidebar: sidebar, detail: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } else {
            NavigationSplitView {
                RenderNodeView(node: sidebar, onEvent: onEvent, customHostRegistry: customHostRegistry)
            } detail: {
                RenderNodeView(node: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
            }
        }
        #else
        NavigationSplitView {
            RenderNodeView(node: sidebar, onEvent: onEvent, customHostRegistry: customHostRegistry)
        } detail: {
            RenderNodeView(node: detail, onEvent: onEvent, customHostRegistry: customHostRegistry)
        }
        #endif
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

private struct NodeAppearanceModifier: ViewModifier {
    let modifiers: ViewModifiers

    @ViewBuilder
    func body(content: Content) -> some View {
        let styled = content
            .font(modifiers.swiftUIFont)
            .fontWeight(modifiers.swiftUIFontWeight)
            .symbolRenderingMode(modifiers.swiftUISymbolRenderingMode)

        if let foregroundColor = modifiers.swiftUIColor {
            styled.foregroundStyle(foregroundColor)
        } else {
            styled
        }
    }
}

private struct CommonNodeModifier: ViewModifier {
    let modifiers: ViewModifiers
    let onEvent: (SurfaceEvent) -> Void

    @ViewBuilder
    func body(content: Content) -> some View {
        let minWidth = modifiers.frameMinWidth.map { CGFloat($0) }
        let minHeight = modifiers.frameMinHeight.map { CGFloat($0) }
        let width = modifiers.frameWidth.map { CGFloat($0) }
        let height = modifiers.frameHeight.map { CGFloat($0) }
        let maxWidth = modifiers.frameMaxWidth ? CGFloat.infinity : modifiers.frameMaxWidthValue.map { CGFloat($0) }
        let maxHeight = modifiers.frameMaxHeight ? CGFloat.infinity : modifiers.frameMaxHeightValue.map { CGFloat($0) }
        let aspectRatio = modifiers.aspectRatio.map { CGFloat($0) }

        let base = content
            .padding(modifiers.padding ?? 0)
            .padding(.top, modifiers.paddingTop ?? 0)
            .fixedSize(horizontal: modifiers.fixedSizeHorizontal, vertical: modifiers.fixedSizeVertical)
        let sized = aspectRatioStyled(base, aspectRatio: aspectRatio)
        let laidOut = sized
            .frame(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight, alignment: modifiers.swiftUIAlignment)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: modifiers.swiftUIAlignment)
            .frame(width: width, height: height, alignment: modifiers.swiftUIAlignment)

        let styledBackground = backgroundStyled(laidOut)
        let styledGlass = glassStyled(styledBackground)
        let titled = titleStyled(styledGlass)
        let identified = identityStyled(titled)

        if let onAppearEvent = modifiers.onAppearEvent {
            identified.onAppear {
                onEvent(onAppearEvent)
            }
        } else {
            identified
        }
    }

    @ViewBuilder
    private func backgroundStyled<Content: View>(_ content: Content) -> some View {
        if let background = modifiers.backgroundColor {
            clipped(content.background(background))
        } else {
            clipped(content)
        }
    }

    @ViewBuilder
    private func clipped<Content: View>(_ content: Content) -> some View {
        if let cornerRadius = modifiers.cornerRadius {
            content.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else if modifiers.imageContentMode == .fill {
            content.clipped()
        } else {
            content
        }
    }

    @ViewBuilder
    private func glassStyled<Content: View>(_ content: Content) -> some View {
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

    @ViewBuilder
    private func titleStyled<Content: View>(_ content: Content) -> some View {
        if let navigationTitle = modifiers.navigationTitle {
            content.navigationTitle(navigationTitle)
        } else {
            content
        }
    }

    @ViewBuilder
    private func identityStyled<Content: View>(_ content: Content) -> some View {
        if let viewIdentity = modifiers.viewIdentity {
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

    @ViewBuilder
    private func aspectRatioStyled<Content: View>(_ content: Content, aspectRatio: CGFloat?) -> some View {
        if let aspectRatio {
            content.aspectRatio(aspectRatio, contentMode: modifiers.swiftUIAspectRatioContentMode)
        } else {
            content
        }
    }
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
    let background: String?
    let foregroundColor: String?
    let cornerRadius: Double?
    let fontName: TextStyle?
    let fontSize: Double?
    let fontWeight: FontWeight?
    let symbolRenderingMode: SymbolRenderingMode?
    let buttonStyle: ButtonStyle?
    let buttonBorderShape: ButtonBorderShape?
    let isDisabled: Bool?
    let glassEffect: Bool?
    let glassTint: String?
    let navigationTitle: String?
    let listStyle: ListStyleKind?
    let imageContentMode: ImageContentMode?
    let imageInterpolation: ImageInterpolation?
    let aspectRatio: Double?
    let aspectRatioContentMode: ImageContentMode?
    let fixedSizeHorizontal: Bool?
    let fixedSizeVertical: Bool?
    let compactVertical: Bool?
    let onAppearEvent: String?
    let value: String?
    let systemName: String?
    let name: String?
    let title: String?
    let event: String?
    let isOn: Bool?
    let destination: HostNode?
    let customName: String?
    let customValues: [String: CustomHostValue]?
    let children: [HostNode]?
    let sidebar: HostNode?
    let detail: HostNode?
    let compact: HostNode?
    let regular: HostNode?
    let customSlots: [String: HostNode]?

    func makeViewNode() throws -> ViewNode {
        let modifiers = makeModifiers()

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

    private func makeModifiers() -> ViewModifiers {
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
            cornerRadius: cornerRadius,
            fontStyle: fontName,
            fontSize: fontSize,
            fontWeight: fontWeight,
            symbolRenderingMode: symbolRenderingMode,
            buttonStyle: buttonStyle,
            buttonBorderShape: buttonBorderShape,
            isDisabled: isDisabled ?? false,
            glassEffect: glassEffect ?? false,
            glassTint: glassTint,
            navigationTitle: navigationTitle,
            listStyle: listStyle,
            imageContentMode: imageContentMode,
            imageInterpolation: imageInterpolation,
            aspectRatio: aspectRatio,
            aspectRatioContentMode: aspectRatioContentMode,
            fixedSizeHorizontal: fixedSizeHorizontal ?? false,
            fixedSizeVertical: fixedSizeVertical ?? false,
            compactVertical: compactVertical ?? false,
            onAppearEvent: onAppearEvent.map { SurfaceEvent($0) }
        )
    }
}

private enum HostComponentType: String, Decodable {
    case vStack = "VStack"
    case hStack = "HStack"
    case zStack = "ZStack"
    case grid = "Grid"
    case flowLayout = "FlowLayout"
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
    case navigationSplitView = "NavigationSplitView"
    case spacer = "Spacer"
    case text = "Text"
    case label = "Label"
    case image = "Image"
    case divider = "Divider"
    case button = "Button"
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
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .caption:
            return .caption
        case .footnote:
            return .footnote
        }
    }

    var swiftUIFontWeight: SwiftUI.Font.Weight? {
        guard let fontWeight else {
            return nil
        }

        switch fontWeight {
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        }
    }

    var backgroundColor: Color? {
        background.flatMap(Color.named(_:))
    }

    var swiftUIColor: Color? {
        foregroundColor.flatMap(Color.named(_:))
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
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
private func glassValue(for modifiers: ViewModifiers) -> SwiftUI.Glass {
    if let tint = modifiers.glassTint.flatMap(Color.named(_:)) {
        return .regular.tint(tint)
    }

    return .regular
}

private extension Color {
    static func named(_ value: String) -> Color? {
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
        #if canImport(UIKit)
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
        #endif
        default:
            return Color(value)
        }
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
