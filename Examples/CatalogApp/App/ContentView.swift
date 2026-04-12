import SwiftUI
import SwiftJS

@MainActor
struct ContentView: View {
    @State private var runtime = JSSurfaceRuntime(
        source: .bundleResource(name: "catalog.bundle", extension: "js", bundle: .main)
    )

    var body: some View {
        JSSurfaceView(runtime: runtime)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ContentView()
}
