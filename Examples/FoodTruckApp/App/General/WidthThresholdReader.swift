import SwiftUI
import SwiftJS

enum FoodTruckCustomHosts {
    static func makeRegistry() -> CustomHostRegistry {
        CustomHostRegistry(
            renderers: [
                "WidthThresholdReader": { context, onEvent in
                    AnyView(AppWidthThresholdReader(context: context, onEvent: onEvent))
                }
            ]
        )
    }
}

private struct AppWidthThresholdReader: View {
    let context: CustomHostContext
    let onEvent: (SurfaceEvent) -> Void

    #if canImport(UIKit)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        GeometryReader { geometry in
            if let node = selectedNode(for: geometry.size.width) {
                SurfaceView(root: node, onEvent: onEvent, customHostRegistry: FoodTruckCustomHosts.makeRegistry())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                Color.clear
            }
        }
    }

    private func selectedNode(for width: CGFloat) -> ViewNode? {
        let slotName = isCompact(width: Double(width)) ? "compact" : "regular"
        return context.slot(named: slotName)
    }

    private func isCompact(width: Double) -> Bool {
        #if canImport(UIKit)
        if horizontalSizeClass == .compact {
            return true
        }
        #endif

        if dynamicTypeSize >= .xxLarge {
            return true
        }

        return width < (context.numberValue(forKey: "widthThreshold") ?? 400)
    }
}
