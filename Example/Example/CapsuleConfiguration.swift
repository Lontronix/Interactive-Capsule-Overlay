//
//  CapsuleConfiguration.swift
//  Example
//
//  Created by Lonnie Gerol on 2/24/24.
//

import Foundation
import InteractiveCapsuleOverlay
import SwiftUI

extension CapsuleOverlayConfiguration {

    static func taskCompleted() -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Completed",
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {}),
            timeoutInterval: 5,
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {}),
            accentColor: .pink
        )
    }

}
