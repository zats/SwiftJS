import EsbuildKit
import Foundation

enum CounterScriptWorkspace {
    static let bundleFileName = "counter.bundle.js"
    static let projectDirectoryName = "CounterProject"
    static let entryPoint = "src/main.tsx"
    static let editableSourceRelativePath = "src/ContentView.tsx"
    static let typesSourceRelativePath = "src/swiftjs/types.ts"

    struct Workspace: Sendable {
        let projectURL: URL
        let scriptURL: URL
        let editableSourceURL: URL
    }

    static func prepareWorkspace() throws -> Workspace {
        let fileManager = FileManager.default
        let documentsURL = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let projectURL = documentsURL.appendingPathComponent(projectDirectoryName, isDirectory: true)
        try fileManager.createDirectory(at: projectURL, withIntermediateDirectories: true)
        try ensureBundledProjectExists(at: projectURL)

        let scriptURL = projectURL.appendingPathComponent(bundleFileName, isDirectory: false)
        if !fileManager.fileExists(atPath: scriptURL.path) {
            try fileManager.copyItem(at: bundledScriptURL(), to: scriptURL)
        }

        return Workspace(
            projectURL: projectURL,
            scriptURL: scriptURL,
            editableSourceURL: projectURL.appendingPathComponent(editableSourceRelativePath, isDirectory: false)
        )
    }

    static func bundledSource() throws -> String {
        try loadSource(at: try bundledSourceURL())
    }

    static func loadTypesSource(in workspace: Workspace) throws -> String {
        try loadSource(at: workspace.projectURL.appendingPathComponent(typesSourceRelativePath, isDirectory: false))
    }

    static func loadSource(at url: URL) throws -> String {
        try String(contentsOf: url, encoding: .utf8)
    }

    static func saveSource(_ source: String, at url: URL) throws {
        try source.write(to: url, atomically: true, encoding: .utf8)
    }

    static func resetEditableSource(in workspace: Workspace) throws {
        try saveSource(bundledSource(), at: workspace.editableSourceURL)
    }

    static func transpileProject(in workspace: Workspace) async throws {
        let outputURL = try await EsbuildKit.bundleProject(
            at: workspace.projectURL,
            entryPoint: entryPoint,
            outputFileName: bundleFileName,
            format: .iife,
            jsx: .automatic,
            target: "es2020",
            platform: .browser,
            bundle: true
        )
        let output = try Data(contentsOf: outputURL)
        try output.write(to: workspace.scriptURL, options: .atomic)
    }

    private static func bundledScriptURL() throws -> URL {
        guard let bundledURL = Bundle.main.url(forResource: "counter.bundle", withExtension: "js") else {
            throw WorkspaceError.missingBundledScript
        }

        return bundledURL
    }

    private static func bundledSourceDirectoryURL() throws -> URL {
        guard let bundledURL = Bundle.main.url(forResource: "Project", withExtension: nil)?
            .appendingPathComponent("src", isDirectory: true) else {
            throw WorkspaceError.missingBundledProjectDirectory
        }

        return bundledURL
    }

    private static func bundledSourceURL() throws -> URL {
        try bundledSourceDirectoryURL().appendingPathComponent("ContentView.tsx", isDirectory: false)
    }

    private static func ensureBundledProjectExists(at projectURL: URL) throws {
        let fileManager = FileManager.default
        guard let bundledProjectURL = Bundle.main.url(forResource: "Project", withExtension: nil) else {
            throw WorkspaceError.missingBundledProjectDirectory
        }

        let bundledSourceURL = bundledProjectURL.appendingPathComponent("src", isDirectory: true)
        let editableSourceDirectoryURL = projectURL.appendingPathComponent("src", isDirectory: true)
        if !fileManager.fileExists(atPath: editableSourceDirectoryURL.path) {
            try fileManager.copyItem(at: bundledSourceURL, to: editableSourceDirectoryURL)
        }

        let bundledTSConfigURL = bundledProjectURL.appendingPathComponent("tsconfig.json", isDirectory: false)
        let editableTSConfigURL = projectURL.appendingPathComponent("tsconfig.json", isDirectory: false)
        if !fileManager.fileExists(atPath: editableTSConfigURL.path) {
            try fileManager.copyItem(at: bundledTSConfigURL, to: editableTSConfigURL)
        }
    }
}

private enum WorkspaceError: LocalizedError {
    case missingBundledScript
    case missingBundledProjectDirectory

    var errorDescription: String? {
        switch self {
        case .missingBundledScript:
            "The bundled counter JS bundle is missing from the app resources."
        case .missingBundledProjectDirectory:
            "The bundled counter TSX project directory is missing from the app resources."
        }
    }
}
