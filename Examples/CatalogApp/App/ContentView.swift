import SwiftUI
import SwiftJS
import SwiftJSCalendar
import SwiftJSLocation
import os

@MainActor
struct ContentView: View {
    var body: some View {
        if BenchmarkConfig.current.isEnabled {
            BenchmarkContentView(config: .current)
        } else {
            CatalogContentView()
        }
    }
}

@MainActor
private struct CatalogContentView: View {
    @State private var runtime = JSSurfaceRuntime(
        source: .bundleResource(name: "catalog.bundle", extension: "js", bundle: .main),
        modules: [
            SwiftJSCalendarModule(),
            SwiftJSLocationModule(),
        ]
    )

    var body: some View {
        RuntimeHostView(runtime: runtime)
    }
}

@MainActor
private struct BenchmarkContentView: View {
    let config: BenchmarkConfig
    @State private var runtime: JSSurfaceRuntime
    @State private var didRun = false

    init(config: BenchmarkConfig) {
        self.config = config
        UserDefaults.standard.set(BenchmarkConfig.jsonString(config.caseName), forKey: "swiftjs.benchmark.case")
        UserDefaults.standard.set(String(config.size), forKey: "swiftjs.benchmark.size")
        _runtime = State(
            initialValue: JSSurfaceRuntime(
                source: .bundleResource(name: "benchmark.bundle", extension: "js", bundle: .main),
                collectMetrics: true,
                modules: []
            )
        )
    }

    var body: some View {
        RuntimeHostView(runtime: runtime)
            .task {
                await runBenchmarkIfNeeded()
            }
    }

    private func runBenchmarkIfNeeded() async {
        guard !didRun else {
            return
        }

        didRun = true
        runtime.start()
        try? await Task.sleep(for: .milliseconds(config.warmupMS))
        let signpostID = OSSignpostID(log: Self.signpostLog)
        os_signpost(.begin, log: Self.signpostLog, name: "BenchmarkRun", signpostID: signpostID, "%{public}s", config.caseName)
        Self.logger.info("[SwiftJSBenchmark] begin case=\(config.caseName, privacy: .public) ticks=\(config.ticks) intervalMS=\(config.intervalMS) size=\(config.size)")

        for tick in 0 ..< config.ticks {
            runtime.dispatch(SurfaceEvent("benchmark.tick:action", payloadJSON: String(tick)))
            if config.intervalMS > 0 {
                try? await Task.sleep(for: .milliseconds(config.intervalMS))
            } else if tick % 25 == 0 {
                await Task.yield()
            }
        }

        try? await Task.sleep(for: .milliseconds(config.cooldownMS))
        runtime.dispatch("benchmark.report:action")
        Self.logger.info("[SwiftJSBenchmarkSwift] \(runtime.metrics.summary, privacy: .public)")
        Self.logger.info("[SwiftJSBenchmark] end")
        os_signpost(.end, log: Self.signpostLog, name: "BenchmarkRun", signpostID: signpostID, "%{public}s", config.caseName)
    }

    private static let signpostLog = OSLog(subsystem: "SwiftJSBenchmark", category: "Run")
    private static let logger = Logger(subsystem: "SwiftJSBenchmark", category: "Metrics")
}

@MainActor
private struct RuntimeHostView: View {
    let runtime: JSSurfaceRuntime

    var body: some View {
        JSSurfaceView(runtime: runtime)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

private struct BenchmarkConfig {
    let isEnabled: Bool
    let caseName: String
    let ticks: Int
    let intervalMS: Int
    let warmupMS: Int
    let cooldownMS: Int
    let size: Int

    static var current: BenchmarkConfig {
        let environment = ProcessInfo.processInfo.environment
        let arguments = ArgumentValues(ProcessInfo.processInfo.arguments)
        return BenchmarkConfig(
            isEnabled: environment["SWIFTJS_BENCHMARK"] == "1" || arguments.bool("swiftjs-benchmark"),
            caseName: arguments.string("swiftjs-benchmark-case") ?? environment["SWIFTJS_BENCHMARK_CASE"] ?? "wide-text",
            ticks: Self.intValue(arguments.string("swiftjs-benchmark-ticks") ?? environment["SWIFTJS_BENCHMARK_TICKS"], fallback: 240),
            intervalMS: Self.intValue(arguments.string("swiftjs-benchmark-interval-ms") ?? environment["SWIFTJS_BENCHMARK_INTERVAL_MS"], fallback: 0),
            warmupMS: Self.intValue(arguments.string("swiftjs-benchmark-warmup-ms") ?? environment["SWIFTJS_BENCHMARK_WARMUP_MS"], fallback: 750),
            cooldownMS: Self.intValue(arguments.string("swiftjs-benchmark-cooldown-ms") ?? environment["SWIFTJS_BENCHMARK_COOLDOWN_MS"], fallback: 750),
            size: Self.intValue(arguments.string("swiftjs-benchmark-size") ?? environment["SWIFTJS_BENCHMARK_SIZE"], fallback: 600)
        )
    }

    private static func intValue(_ value: String?, fallback: Int) -> Int {
        guard let value, let parsed = Int(value) else {
            return fallback
        }

        return parsed
    }

    static func jsonString(_ value: String) -> String {
        if let data = try? JSONSerialization.data(withJSONObject: value, options: [.fragmentsAllowed]),
           let json = String(data: data, encoding: .utf8) {
            return json
        }

        return "\"\(value)\""
    }
}

private struct ArgumentValues {
    private let values: [String: String]
    private let flags: Set<String>

    init(_ arguments: [String]) {
        var values: [String: String] = [:]
        var flags = Set<String>()
        var index = arguments.startIndex
        while index < arguments.endIndex {
            let argument = arguments[index]
            guard argument.hasPrefix("--") else {
                index = arguments.index(after: index)
                continue
            }

            let nameAndValue = argument.dropFirst(2).split(separator: "=", maxSplits: 1).map(String.init)
            if nameAndValue.count == 2 {
                values[nameAndValue[0]] = nameAndValue[1]
            } else {
                let name = nameAndValue[0]
                let nextIndex = arguments.index(after: index)
                if nextIndex < arguments.endIndex, !arguments[nextIndex].hasPrefix("--") {
                    values[name] = arguments[nextIndex]
                    index = nextIndex
                } else {
                    flags.insert(name)
                }
            }

            index = arguments.index(after: index)
        }

        self.values = values
        self.flags = flags
    }

    func string(_ name: String) -> String? {
        values[name]
    }

    func bool(_ name: String) -> Bool {
        flags.contains(name) || values[name] == "1" || values[name] == "true"
    }
}

#Preview {
    ContentView()
}
