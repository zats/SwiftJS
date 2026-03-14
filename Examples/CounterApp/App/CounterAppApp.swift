import SwiftUI

@main
struct CounterAppApp: App {
    @UIApplicationDelegateAdaptor(ShakeBridgeAppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class ShakeBridgeAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        application.applicationSupportsShakeToEdit = true
        return true
    }
}
