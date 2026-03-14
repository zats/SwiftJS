import SwiftUI
import SwiftJS

struct ContentView: View {
    @State private var runtime: JSSurfaceRuntime
    @State private var workspace: CounterScriptWorkspace.Workspace
    @State private var editorText = ""
    @State private var bundledText = ""
    @State private var isEditorPresented = false
    @State private var isTranspiling = false
    @State private var transpileErrorMessage: String?

    init() {
        do {
            let workspace = try CounterScriptWorkspace.prepareWorkspace()
            let bundledText = try CounterScriptWorkspace.bundledSource()
            _workspace = State(initialValue: workspace)
            _bundledText = State(initialValue: bundledText)
            _runtime = State(initialValue: JSSurfaceRuntime(source: .file(workspace.scriptURL)))
        } catch {
            fatalError("Failed to prepare editable TSX project: \(error)")
        }
    }

    var body: some View {
        NavigationStack {
            JSSurfaceView(runtime: runtime)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color(.systemGroupedBackground))
                .overlay {
                    if !isEditorPresented {
                        ShakeDetector {
                            presentEditor()
                        }
                        .allowsHitTesting(false)
                    }
                }
        }
        .fullScreenCover(isPresented: $isEditorPresented) {
            SourceEditorView(
                text: $editorText,
                bundledText: bundledText,
                isBusy: isTranspiling,
                onCancel: {
                    isEditorPresented = false
                },
                onSave: saveAndReload,
                onReset: resetAndReload
            )
        }
        .alert("Transpile Failed", isPresented: Binding(
            get: { transpileErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    transpileErrorMessage = nil
                }
            }
        )) {
            Button("OK", role: .cancel) {
                transpileErrorMessage = nil
            }
        } message: {
            Text(transpileErrorMessage ?? "")
        }
    }

    private func presentEditor() {
        guard !isEditorPresented, !isTranspiling else {
            return
        }

        do {
            let refreshedWorkspace = try CounterScriptWorkspace.prepareWorkspace()
            workspace = refreshedWorkspace
            bundledText = try CounterScriptWorkspace.bundledSource()
            editorText = try CounterScriptWorkspace.loadSource(at: refreshedWorkspace.editableSourceURL)
            isEditorPresented = true
        } catch {
            transpileErrorMessage = error.localizedDescription
        }
    }

    private func saveAndReload() {
        guard !isTranspiling else {
            return
        }

        let updatedSource = editorText
        isTranspiling = true

        Task {
            do {
                try CounterScriptWorkspace.saveSource(updatedSource, at: workspace.editableSourceURL)
                try await CounterScriptWorkspace.transpileProject(in: workspace)
                isEditorPresented = false
                runtime.reload()
            } catch {
                transpileErrorMessage = error.localizedDescription
            }

            isTranspiling = false
        }
    }

    private func resetAndReload() {
        guard !isTranspiling else {
            return
        }

        isTranspiling = true

        Task {
            do {
                bundledText = try CounterScriptWorkspace.bundledSource()
                try CounterScriptWorkspace.resetEditableSource(in: workspace)
                editorText = bundledText
                try await CounterScriptWorkspace.transpileProject(in: workspace)
                isEditorPresented = false
                runtime.reload()
            } catch {
                transpileErrorMessage = error.localizedDescription
            }

            isTranspiling = false
        }
    }
}

#Preview {
    ContentView()
}
