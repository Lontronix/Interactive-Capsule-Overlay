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

    public enum PresentationMode: Hashable {

        public static let defaultTopYOffset: CGFloat = 15
        public static let defaultBottomYOffset: CGFloat = 20
        
        /// the overlay is presented at the top of the screen
        case top(yOffset: CGFloat = Self.defaultTopYOffset)

        /**
         The overlay is presented at the bottom of the screen

         In this mode, `yOffset` is automatically negated, so +20 means move the overlay *up* 20 points from the bottom of the screen.
         */
        case bottom(yOffset: CGFloat = Self.defaultBottomYOffset)
    }

    public static let defaultTimeoutInterval = 5.0

    public let title: String
    public let timeoutInterval: TimeInterval
    public let presentationMode: PresentationMode
    public let primaryAction: ActionConfiguration
    public let secondaryAction: ActionConfiguration
    public let onDismissButtonPressed: (() -> Void)?
    public let accentColor: Color
    public let id = UUID()

    public init(
        title: String,
        timeoutInterval: TimeInterval = Self.defaultTimeoutInterval,
        presentationMode: PresentationMode = .bottom(),
        primaryAction: ActionConfiguration,
        secondaryAction: ActionConfiguration,
        onDismissButtonPressed: (() -> Void)? = nil,
        accentColor: Color
    ) {
        self.title = title
        self.timeoutInterval = timeoutInterval
        self.presentationMode = presentationMode
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.onDismissButtonPressed = onDismissButtonPressed
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
