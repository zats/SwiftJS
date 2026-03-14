import SwiftUI
import SwiftJS

struct ContentView: View {
    @State private var runtime = JSSurfaceRuntime(
        source: .bundleResource(name: "food-truck.bundle", extension: "js", bundle: .main)
    )

    var body: some View {
        NavigationStack {
            JSSurfaceView(runtime: runtime)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    ContentView()
}
