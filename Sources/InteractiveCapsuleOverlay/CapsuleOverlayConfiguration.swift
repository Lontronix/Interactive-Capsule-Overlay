//
//  CapsuleOverlayConfiguration.swift
//
//
//  Created by Lonnie Gerol on 2/24/24.
//

import Foundation
import SwiftUI

public struct CapsuleOverlayConfiguration: Identifiable {

    public enum ActionConfiguration {
        case disabled
        case enabled(iconIdentifier: String, onPressed: () -> Void)
    }

    public let title: String
    public let timeoutInterval: TimeInterval
    public let primaryAction: ActionConfiguration
    public let secondaryAction: ActionConfiguration
    public let accentColor: Color
    public let id = UUID()

    public init(
        title: String,
        primaryAction: ActionConfiguration,
        timeoutInterval: TimeInterval,
        secondaryAction: ActionConfiguration,
        accentColor: Color
    ) {
        self.title = title
        self.timeoutInterval = timeoutInterval
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.accentColor = accentColor
    }

}

// MAK: Equatable
extension CapsuleOverlayConfiguration: Equatable {

    // swiftlint:disable:next identifier_name
    public static func == (lhs: CapsuleOverlayConfiguration, rhs: CapsuleOverlayConfiguration) -> Bool {
        return lhs.id == rhs.id
    }

}
