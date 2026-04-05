import SwiftUI
import SwiftJS

@MainActor
struct ContentView: View {
    @State private var runtime: JSSurfaceRuntime
    @State private var workspace: CounterScriptWorkspace.Workspace
    @State private var isGeneratorPresented = false
    @State private var transpileErrorMessage: String?

    init() {
        do {
            let workspace = try CounterScriptWorkspace.prepareWorkspace()
            _workspace = State(initialValue: workspace)
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
                    if !isGeneratorPresented {
                        ShakeDetector {
                            presentGenerator()
                        }
                        .allowsHitTesting(false)
                    }
                }
        }
        .fullScreenCover(isPresented: $isGeneratorPresented) {
            ScreenGeneratorView(
                workspace: workspace,
                onCompiled: {
                    runtime.reload()
                    isGeneratorPresented = false
                }
            )
        }
        .alert("Generator Failed", isPresented: Binding(
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

    private func presentGenerator() {
        guard !isGeneratorPresented else {
            return
        }

        do {
            workspace = try CounterScriptWorkspace.prepareWorkspace()
            isGeneratorPresented = true
        } catch {
            transpileErrorMessage = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
