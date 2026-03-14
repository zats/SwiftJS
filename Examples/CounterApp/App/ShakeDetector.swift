import SwiftUI
import UIKit

struct ShakeDetector: UIViewControllerRepresentable {
    let onShake: () -> Void

    func makeUIViewController(context: Context) -> ShakeViewController {
        let controller = ShakeViewController()
        controller.onShake = onShake
        return controller
    }

    func updateUIViewController(_ uiViewController: ShakeViewController, context: Context) {
        uiViewController.onShake = onShake
        uiViewController.activateShakeHandling()
    }
}

final class ShakeViewController: UIViewController {
    var onShake: (() -> Void)?
    private var observersInstalled = false

    override var canBecomeFirstResponder: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        installObserversIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateShakeHandling()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activateShakeHandling()
    }

    func activateShakeHandling() {
        guard isViewLoaded else {
            return
        }

        UIApplication.shared.applicationSupportsShakeToEdit = true

        DispatchQueue.main.async { [weak self] in
            guard let self, self.view.window != nil else {
                return
            }
            _ = self.becomeFirstResponder()
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else {
            return
        }

        onShake?()
    }

    private func installObserversIfNeeded() {
        guard !observersInstalled else {
            return
        }

        observersInstalled = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleActivation),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleActivation),
            name: UIWindow.didBecomeKeyNotification,
            object: nil
        )
    }

    @objc
    private func handleActivation() {
        activateShakeHandling()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
