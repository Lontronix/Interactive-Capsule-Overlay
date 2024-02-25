//
//  ShowOverlayAction.swift
//  
//
//  Created by Lonnie Gerol on 2/24/24.
//

import Foundation
import SwiftUI

public struct ShowOverlayAction {

    public typealias ShowOverlay = (CapsuleOverlayConfiguration) -> Void

    let showOverlay: ShowOverlay

    public init(showOverlay: @escaping ShowOverlay) {
        self.showOverlay = showOverlay
    }

    public func callAsFunction(_ config: CapsuleOverlayConfiguration) {
        showOverlay(config)
    }

}

private struct ShowOverlayKey: EnvironmentKey {

    static let defaultValue = ShowOverlayAction { _ in
        // swiftlint:disable:next disable_print
        print("showOverlay() is unimplemented!")
    }

}

public extension EnvironmentValues {

    var showOverlay: ShowOverlayAction {
        get { self[ShowOverlayKey.self] }
        set { self[ShowOverlayKey.self] = newValue }
    }

}
