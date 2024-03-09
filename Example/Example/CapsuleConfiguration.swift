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

    func configuration(presentationMode: CapsuleOverlayConfiguration.PresentationMode) -> CapsuleOverlayConfiguration {
        return switch self {
            case .createTask:
                .taskCreated(accentColor: .green, presentationMode: presentationMode)
            case .completeTask:
                .taskCompleted(accentColor: .red, presentationMode: presentationMode)
            case .copyText:
                .textCopied(accentColor: .blue, presentationMode: presentationMode)
        }
    }

}

extension CapsuleOverlayConfiguration {

    static func taskCreated(
        accentColor: Color,
        presentationMode: PresentationMode
    ) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Created",
            timeoutInterval: 10, 
            presentationMode: presentationMode,
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {
                print("Edit Task Pressed")
            }),
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {
                print("Undo Task Creation Pressed")
            }),
            accentColor: accentColor
        )
    }

    static func taskCompleted(
        accentColor: Color,
        presentationMode: PresentationMode
    ) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Completed",
            timeoutInterval: 10, 
            presentationMode: presentationMode,
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {
                print("Edit Task Completion Pressed")
            }),
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {
                print("Undo Completion Pressed")
            }),
            accentColor: accentColor
        )
    }

    static func textCopied(
        accentColor: Color,
        presentationMode: PresentationMode
    ) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Text Copied",
            presentationMode: presentationMode,
            primaryAction: .disabled,
            secondaryAction: .enabled(iconIdentifier: "xmark.circle.fill", onPressed: {
                print("dismiss pressed")
            }),
            accentColor: accentColor
        )
    }

}
