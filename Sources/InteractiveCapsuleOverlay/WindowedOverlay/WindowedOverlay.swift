//
//  WindowedOverlay.swift
//
//
//  Created by Lonnie Gerol on 2/20/24.
//

import Foundation
import SwiftUI

struct WindowedOverlay<OverlayContent: View>: ViewModifier {

    let overlayContent: OverlayContent

    init(overlayContent: () -> OverlayContent) {
        self.overlayContent = overlayContent()
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                WindowOverlayBody {
                    overlayContent
                }
                .allowsHitTesting(false)
            }
    }

}

// MARK: WindowedOverlayBody
extension WindowedOverlay {

    struct WindowOverlayBody<Content: View>: UIViewControllerRepresentable {

        class Coordinator {
            var overlayWindow: UIWindow?
        }

        @WeakState private var window: UIWindow?

        let content: Content

        init(content: () -> Content) {
            self.content = content()
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }

        func makeUIViewController(context: Context) -> WindowOverlayViewController {
            return WindowOverlayViewController { window in
                self.window = window
            }
        }

        func updateUIViewController(_ uiViewController: WindowOverlayViewController, context: Context) {
            guard let window else { return }
            guard let windowScene = window.windowScene else { return }

            let overlayWindow = PassthroughWindow(windowScene: windowScene)
            let hostingController = UIHostingController(rootView: content)
            hostingController.view.backgroundColor = .clear
            overlayWindow.rootViewController = hostingController
            overlayWindow.isHidden = false
            context.coordinator.overlayWindow = overlayWindow
        }

    }

}

extension View {

    func windowedOverlay<Content>(@ViewBuilder content : () -> Content) -> some View where Content: View {
        modifier(WindowedOverlay(overlayContent: { content() }))
    }

}
