import Foundation
import JavaScriptCore
import Observation
import SwiftUI

public struct SurfaceEvent: Hashable, Sendable, ExpressibleByStringLiteral {
    public let name: String

    public init(_ name: String) {
        self.name = name
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
    case body
    case caption
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

public enum ImageSource: Equatable, Sendable {
    case system(String)
    case asset(String)
}

public struct ViewModifiers: Equatable, Sendable {
    public var padding: Double?
    public var paddingTop: Double?
    public var frameWidth: Double?
    public var frameHeight: Double?
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
    public var onAppearEvent: SurfaceEvent?

    public init(
        padding: Double? = nil,
        paddingTop: Double? = nil,
        frameWidth: Double? = nil,
        frameHeight: Double? = nil,
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
        onAppearEvent: SurfaceEvent? = nil
    ) {
        self.padding = padding
        self.paddingTop = paddingTop
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
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
        self.onAppearEvent = onAppearEvent
    }
}

public indirect enum ViewNode: Equatable, Sendable, Identifiable {
    case vStack(
        id: NodeID,
        spacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case hStack(
        id: NodeID,
        spacing: Double,
        modifiers: ViewModifiers,
        children: [ViewNode]
    )
    case text(
        id: NodeID,
        value: String,
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
        modifiers: ViewModifiers
    )

    public var id: NodeID {
        switch self {
        case let .vStack(id, _, _, _),
             let .hStack(id, _, _, _),
             let .text(id, _, _),
             let .image(id, _, _),
             let .divider(id, _),
             let .button(id, _, _, _):
            id
        }
    }

    fileprivate var modifiers: ViewModifiers {
        switch self {
        case let .vStack(_, _, modifiers, _),
             let .hStack(_, _, modifiers, _),
             let .text(_, _, modifiers),
             let .image(_, _, modifiers),
             let .divider(_, modifiers),
             let .button(_, _, _, modifiers):
            modifiers
        }
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

    public init(root: ViewNode, onEvent: @escaping (SurfaceEvent) -> Void) {
        self.root = root
        self.onEvent = onEvent
    }

    public var body: some View {
        RenderNodeView(node: root, onEvent: onEvent)
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
                SurfaceView(root: rootNode, onEvent: runtime.dispatch)
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

    private let source: JSScriptSource
    private var context: JSContext
    private let decoder = JSONDecoder()
    private var didStart = false

    public init(source: JSScriptSource) {
        self.source = source
        self.context = Self.makeContext()
        installBridge()
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
        dispatch?.call(withArguments: [event.name])

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
        errorMessage = (error as? LocalizedError)?.errorDescription ?? String(describing: error)
    }
}

private struct RenderNodeView: View {
    let node: ViewNode
    let onEvent: (SurfaceEvent) -> Void

    var body: some View {
        switch node {
        case let .vStack(_, spacing, _, children):
            applyCommonModifiers(
                VStack(spacing: spacing) {
                    ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent)
                    }
                }
            )
        case let .hStack(_, spacing, _, children):
            applyCommonModifiers(
                HStack(spacing: spacing) {
                    ForEach(children) { child in
                        RenderNodeView(node: child, onEvent: onEvent)
                    }
                }
            )
        case let .text(_, value, modifiers):
            applyCommonModifiers(
                textView(value, modifiers: modifiers)
            )
        case let .image(_, source, modifiers):
            applyCommonModifiers(
                imageView(source, modifiers: modifiers)
            )
        case .divider:
            applyCommonModifiers(Divider())
        case let .button(_, title, event, modifiers):
            applyCommonModifiers(
                buttonView(title, event: event, modifiers: modifiers)
            )
        }
    }

    private func textView(_ value: String, modifiers: ViewModifiers) -> some View {
        Text(value)
            .modifier(NodeAppearanceModifier(modifiers: modifiers))
    }

    @ViewBuilder
    private func buttonView(_ title: String, event: SurfaceEvent, modifiers: ViewModifiers) -> some View {
        let button = Button(title) {
            onEvent(event)
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
            Image(systemName: systemName)
                .modifier(NodeAppearanceModifier(modifiers: modifiers))
        case let .asset(name):
            Image(name)
                .resizable()
                .scaledToFit()
                .modifier(NodeAppearanceModifier(modifiers: modifiers))
        }
    }

    private func applyCommonModifiers<Content: View>(_ content: Content) -> some View {
        content.modifier(CommonNodeModifier(modifiers: node.modifiers, onEvent: onEvent))
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
        let width = modifiers.frameWidth.map { CGFloat($0) }
        let height = modifiers.frameHeight.map { CGFloat($0) }
        let laidOut = content
            .padding(modifiers.padding ?? 0)
            .padding(.top, modifiers.paddingTop ?? 0)
            .frame(width: width, height: height)

        let styledBackground = backgroundStyled(laidOut)
        let styledGlass = glassStyled(styledBackground)

        if let onAppearEvent = modifiers.onAppearEvent {
            styledGlass.onAppear {
                onEvent(onAppearEvent)
            }
        } else {
            styledGlass
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
}

private struct HostNode: Decodable {
    let type: HostComponentType
    let id: String
    let spacing: Double?
    let padding: Double?
    let paddingTop: Double?
    let frameWidth: Double?
    let frameHeight: Double?
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
    let onAppearEvent: String?
    let value: String?
    let systemName: String?
    let name: String?
    let title: String?
    let event: String?
    let children: [HostNode]?

    func makeViewNode() throws -> ViewNode {
        let modifiers = makeModifiers()

        switch type {
        case .vStack:
            return .vStack(
                id: NodeID(id),
                spacing: spacing ?? 16,
                modifiers: modifiers,
                children: try mapChildren()
            )
        case .hStack:
            return .hStack(
                id: NodeID(id),
                spacing: spacing ?? 12,
                modifiers: modifiers,
                children: try mapChildren()
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
            guard let title else {
                throw JSSurfaceError.invalidTree("Button node '\(id)' is missing a title")
            }

            guard let event else {
                throw JSSurfaceError.invalidTree("Button node '\(id)' is missing an action event")
            }

            return .button(
                id: NodeID(id),
                title: title,
                event: SurfaceEvent(event),
                modifiers: modifiers
            )
        }
    }

    private func mapChildren() throws -> [ViewNode] {
        try (children ?? []).map { try $0.makeViewNode() }
    }

    private func makeModifiers() -> ViewModifiers {
        ViewModifiers(
            padding: padding,
            paddingTop: paddingTop,
            frameWidth: frameWidth,
            frameHeight: frameHeight,
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
            onAppearEvent: onAppearEvent.map { SurfaceEvent($0) }
        )
    }
}

private enum HostComponentType: String, Decodable {
    case vStack = "VStack"
    case hStack = "HStack"
    case text = "Text"
    case image = "Image"
    case divider = "Divider"
    case button = "Button"
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
        case .body:
            return .body
        case .caption:
            return .caption
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
            true
        default:
            false
        }
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
        case "white":
            return .white
        case "secondary":
            return .secondary
        default:
            return nil
        }
    }
}
