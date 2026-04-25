import SwiftUI
import SwiftJS
import SwiftJSCalendar
import SwiftJSLocation

@MainActor
struct ContentView: View {
    @State private var runtime = JSSurfaceRuntime(
        source: .bundleResource(name: "catalog.bundle", extension: "js", bundle: .main),
        modules: [
            SwiftJSCalendarModule(),
            SwiftJSLocationModule(),
        ]
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
