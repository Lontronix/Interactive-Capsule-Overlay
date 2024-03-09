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

    case createTask = "Create Task"
    case completeTask = "Complete Task"
    case copyText = "Copy Text"

    var id: String { return self.rawValue }

    var configuration: CapsuleOverlayConfiguration {
        return switch self {
            case .createTask:
                .taskCreated(accentColor: .green)
            case .completeTask:
                .taskCompleted(accentColor: .red)
            case .copyText:
                .textCopied(accentColor: .blue)
        }
    }

}

extension CapsuleOverlayConfiguration {

    static func taskCreated(accentColor: Color) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Created",
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {
                print("Edit Task Pressed")
            }),
            timeoutInterval: 10,
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {
                print("Undo Task Creation Pressed")
            }),
            accentColor: accentColor
        )
    }

    static func taskCompleted(accentColor: Color) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Completed",
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {
                print("Edit Task Completion Pressed")
            }),
            timeoutInterval: 10,
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {
                print("Undo Completion Pressed")
            }),
            accentColor: accentColor
        )
    }

    static func textCopied(accentColor: Color) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Text Copied",
            primaryAction: .disabled,
            secondaryAction: .enabled(iconIdentifier: "xmark.circle.fill", onPressed: {
                print("dismiss pressed")
            }),
            accentColor: accentColor
        )
    }

}
