//
//  ShowsInteractiveCapsuleOverlay.swift
//
//
//  Created by Lonnie Gerol on 2/24/24.
//

import SwiftUI
import Foundation

public struct ShowsInteractiveCapsuleOverlay: ViewModifier {

    /// The configuration of the capsule currently being shown (nil, no capsule is shown)
    @State private var currentConfig: CapsuleOverlayConfiguration?

    func showOverlayWith(config: CapsuleOverlayConfiguration) {
        self.currentConfig = config
    }

    public func body(content: Content) -> some View {
        content
            .windowedOverlay {
                InteractiveCapsuleOverlayView(currentConfig: $currentConfig)
            }
            .environment(\.showOverlay, ShowOverlayAction { config in
                self.showOverlayWith(config: config)
            })
    }

}

public extension View {

    func showsInteractiveCapsuleOverlay() -> some View {
        return modifier(ShowsInteractiveCapsuleOverlay())
    }

}
