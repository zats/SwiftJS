import SwiftUI
import SwiftJS

enum FoodTruckCustomHosts {
    static func makeRegistry() -> CustomHostRegistry {
        CustomHostRegistry(
            renderers: [
                "BrandHeader": { context, _, _ in
                    AnyView(AppBrandHeader(context: context))
                },
                "WidthThresholdReader": { context, onEvent, customHostRegistry in
                    AnyView(AppWidthThresholdReader(context: context, onEvent: onEvent, customHostRegistry: customHostRegistry))
                }
            ],
            layouts: [
                "HeroSquareTilingLayout": { context in
                    AnyLayout(
                        AppHeroSquareTilingLayout(
                            spacing: context.numberValue(forKey: "spacing") ?? 10
                        )
                    )
                }
            ]
        )
    }
}

private struct AppBrandHeader: View {
    let context: CustomHostContext

    private var scale: Double {
        switch context.stringValue(forKey: "size") {
        case "reduced":
            return 0.5
        default:
            return 1.0
        }
    }

    var body: some View {
        Color.clear
            .overlay(alignment: .top) {
                LinearGradient(
                    colors: [
                        Color(red: 0.58, green: 0.75, blue: 0.96),
                        Color(red: 0.45, green: 0.60, blue: 0.93)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxWidth: .infinity)
                .frame(height: 400 * scale)
                .padding(.top, -200 * scale)
            }
            .frame(height: 200 * scale)
    }
}

private struct AppWidthThresholdReader: View {
    let context: CustomHostContext
    let onEvent: (SurfaceEvent) -> Void
    let customHostRegistry: CustomHostRegistry

    #if canImport(UIKit)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        GeometryReader { geometry in
            if let node = selectedNode(for: geometry.size.width) {
                SurfaceView(root: node, onEvent: onEvent, customHostRegistry: customHostRegistry)
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

private struct AppHeroSquareTilingLayout: Layout {
    var spacing: Double = 10

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let size = proposal.replacingUnspecifiedDimensions(by: CGSize(width: 100, height: 100))
        let heroLength = min((size.width - spacing) * 0.5, size.height)
        let boundsWidth = heroLength * 2 + spacing
        return CGSize(width: boundsWidth, height: heroLength)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let heroLength = min((bounds.width - spacing) * 0.5, bounds.height)
        let boundsWidth = heroLength * 2 + spacing
        let halfRectSize = CGSize(width: heroLength, height: heroLength)
        let heroOrigin = CGPoint(
            x: bounds.origin.x + ((bounds.width - boundsWidth) * 0.5),
            y: bounds.origin.y + ((bounds.height - heroLength) * 0.5)
        )
        let tileLength = (heroLength - spacing) * 0.5

        let tilesOrigin = CGPoint(x: heroOrigin.x + heroLength + spacing, y: heroOrigin.y)
        let tilesRect = CGRect(origin: tilesOrigin, size: halfRectSize)

        for index in subviews.indices {
            if index == 0 {
                subviews[index].place(
                    at: heroOrigin,
                    anchor: .topLeading,
                    proposal: ProposedViewSize(halfRectSize)
                )
            } else {
                let tileIndex = index - 1
                let xPos: Double = tileIndex % 2 == 0 ? 0 : 1
                let yPos: Double = tileIndex < 2 ? 0 : 1
                let point = CGPoint(
                    x: tilesRect.minX + (xPos * tilesRect.width),
                    y: tilesRect.minY + (yPos * tilesRect.height)
                )
                subviews[index].place(
                    at: point,
                    anchor: UnitPoint(x: xPos, y: yPos),
                    proposal: ProposedViewSize(width: tileLength, height: tileLength)
                )
            }
        }
    }
}
