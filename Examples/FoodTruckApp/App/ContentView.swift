import SwiftUI
import SwiftJS

@MainActor
struct ContentView: View {
    @State private var runtime = JSSurfaceRuntime(
        source: .bundleResource(name: "food-truck.bundle", extension: "js", bundle: .main),
        customHostRegistry: FoodTruckCustomHosts.makeRegistry()
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
