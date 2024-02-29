//
//  CapsuleConfiguration.swift
//  Example
//
//  Created by Lonnie Gerol on 2/24/24.
//

import Foundation
import InteractiveCapsuleOverlay
import SwiftUI

enum OverlayAction: String, CaseIterable, Identifiable {

    case completeTask = "Complete Task"
    case copyText = "Copy Text"

    var id: String { return self.rawValue }

    var configuration: CapsuleOverlayConfiguration {
        return switch self {
            case .completeTask:
                .taskCompleted(accentColor: .red)
            case .copyText:
                .textCopied(accentColor: .blue)
        }
    }

}

extension CapsuleOverlayConfiguration {

    static func taskCompleted(accentColor: Color) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Completed",
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {}),
            timeoutInterval: 5,
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {}),
            accentColor: accentColor
        )
    }

    static func textCopied(accentColor: Color) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Text Copied",
            primaryAction: .disabled,
            timeoutInterval: 5,
            secondaryAction: .enabled(iconIdentifier: "xmark.circle.fill", onPressed: {}),
            accentColor: accentColor
        )
    }

}
