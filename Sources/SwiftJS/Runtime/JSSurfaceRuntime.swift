import Foundation
import JavaScriptCore
import Observation
import SwiftUI
import UniformTypeIdentifiers
import UIKit
import WebKit
import SwiftJSCore
import os

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

public struct JSSurfaceRuntimeMetrics: Equatable, Sendable {
    public fileprivate(set) var dispatchCount = 0
    public fileprivate(set) var dispatchTotalMS = 0.0
    public fileprivate(set) var applyCount = 0
    public fileprivate(set) var skippedApplyCount = 0
    public fileprivate(set) var applyTotalMS = 0.0
    public fileprivate(set) var decodeHostTotalMS = 0.0
    public fileprivate(set) var makeViewNodeTotalMS = 0.0
    public fileprivate(set) var payloadBytesTotal = 0
    public fileprivate(set) var payloadBytesMax = 0

    public var summary: String {
        [
            "dispatchCount=\(dispatchCount)",
            "dispatchTotalMS=\(Self.format(dispatchTotalMS))",
            "applyCount=\(applyCount)",
            "skippedApplyCount=\(skippedApplyCount)",
            "applyTotalMS=\(Self.format(applyTotalMS))",
            "decodeHostTotalMS=\(Self.format(decodeHostTotalMS))",
            "makeViewNodeTotalMS=\(Self.format(makeViewNodeTotalMS))",
            "payloadBytesTotal=\(payloadBytesTotal)",
            "payloadBytesMax=\(payloadBytesMax)",
        ].joined(separator: " ")
    }

    private static func format(_ value: Double) -> String {
        String(format: "%.3f", value)
    }
}

public enum SwiftJSTypeScriptPackage {
    public static var packageRootURL: URL? {
        Bundle.module
            .url(forResource: "Package", withExtension: nil)
//            .deletingLastPathComponent()
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
    @ObservationIgnored public private(set) var metrics = JSSurfaceRuntimeMetrics()
    public private(set) var rootVersion = 0
    public private(set) var errorMessage: String?
    public private(set) var customHostRegistry: CustomHostRegistry

    private let source: JSScriptSource
    private let collectMetrics: Bool
    private let modulesByName: [String: any JSRuntimeModule]
    private var context: JSContext
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private var didStart = false
    private var activeLayoutMeasurementStack: [(Int, ProposedViewSize) -> CGSize] = []
    private static let signpostLog = OSLog(subsystem: "SwiftJS", category: "Runtime")
    private static let consoleLogger = Logger(subsystem: "SwiftJS", category: "Console")

    public var rootNode: ViewNode? {
        currentRootNode
    }

    public init(
        source: JSScriptSource,
        collectMetrics: Bool = false,
        customHostRegistry: CustomHostRegistry = .init(),
        modules: [any JSRuntimeModule] = []
    ) {
        self.source = source
        self.collectMetrics = collectMetrics
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
            if collectMetrics {
                enableRuntimeMetrics()
            }
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

        guard collectMetrics else {
            dispatchEvent(event)
            return
        }

        let signpostID = OSSignpostID(log: Self.signpostLog)
        os_signpost(.begin, log: Self.signpostLog, name: "DispatchEvent", signpostID: signpostID, "%{public}s", event.name)
        defer {
            os_signpost(.end, log: Self.signpostLog, name: "DispatchEvent", signpostID: signpostID, "%{public}s", event.name)
        }

        let started = Self.currentTimeMS()
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

        metrics.dispatchCount += 1
        metrics.dispatchTotalMS += Self.currentTimeMS() - started
    }

    private func dispatchEvent(_ event: SurfaceEvent) {
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
        installNavigationDestinationBridge()
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
            JSSurfaceRuntime.consoleLogger.error("[SwiftJS] \(message, privacy: .public)")
        }

        let log: @convention(block) (String) -> Void = { message in
            print("[SwiftJS] \(message)")
            JSSurfaceRuntime.consoleLogger.info("[SwiftJS] \(message, privacy: .public)")
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

    private func installNavigationDestinationBridge() {
        customHostRegistry = customHostRegistry.withNavigationDestinationBridge(
            NavigationDestinationBridge(
                hasHandler: { [weak self] id in
                    self?.hasNavigationDestinationHandler(id: id) ?? false
                },
                render: { [weak self] id, value in
                    self?.callJavaScriptNavigationDestination(id: id, value: value)
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

    private func enableRuntimeMetrics() {
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let enableMetrics = runtime?.objectForKeyedSubscript("enableBenchmarkMetrics")
        enableMetrics?.call(withArguments: [])
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
            if collectMetrics {
                metrics.skippedApplyCount += 1
            }
            return
        }

        guard collectMetrics else {
            applyTreeJSONNow(payload)
            return
        }

        let signpostID = OSSignpostID(log: Self.signpostLog)
        os_signpost(.begin, log: Self.signpostLog, name: "ApplyTreeJSON", signpostID: signpostID, "%{public}d", payload.utf8.count)
        defer {
            os_signpost(.end, log: Self.signpostLog, name: "ApplyTreeJSON", signpostID: signpostID)
        }

        let started = Self.currentTimeMS()
        do {
            let data = Data(payload.utf8)
            let decodeStarted = Self.currentTimeMS()
            os_signpost(.begin, log: Self.signpostLog, name: "DecodeHostNode", signpostID: signpostID)
            let hostNode = try decoder.decode(HostNode.self, from: data)
            os_signpost(.end, log: Self.signpostLog, name: "DecodeHostNode", signpostID: signpostID)
            let makeStarted = Self.currentTimeMS()
            os_signpost(.begin, log: Self.signpostLog, name: "MakeViewNode", signpostID: signpostID)
            currentRootNode = try hostNode.makeViewNode()
            os_signpost(.end, log: Self.signpostLog, name: "MakeViewNode", signpostID: signpostID)
            let finished = Self.currentTimeMS()
            lastTreePayload = payload
            rootVersion += 1
            errorMessage = nil
            metrics.applyCount += 1
            metrics.applyTotalMS += finished - started
            metrics.decodeHostTotalMS += makeStarted - decodeStarted
            metrics.makeViewNodeTotalMS += finished - makeStarted
            metrics.payloadBytesTotal += data.count
            metrics.payloadBytesMax = max(metrics.payloadBytesMax, data.count)
        } catch {
            report(error)
        }
    }

    private func applyTreeJSONNow(_ payload: String) {
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
        Self.consoleLogger.error("[SwiftJS] \(message, privacy: .public)")
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

    private func hasNavigationDestinationHandler(id: NodeID) -> Bool {
        context.exception = nil
        let runtime = context.objectForKeyedSubscript("__swiftjsRuntime")
        let function = runtime?.objectForKeyedSubscript("hasNavigationDestinationHandler")
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

    private func callJavaScriptNavigationDestination(id: NodeID, value: CustomHostValue) -> ViewNode? {
        callJavaScriptLayout(
            functionName: "renderNavigationDestination",
            arguments: [
                id.rawValue,
                value.payloadJSON
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

    private static func currentTimeMS() -> Double {
        CFAbsoluteTimeGetCurrent() * 1000
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
