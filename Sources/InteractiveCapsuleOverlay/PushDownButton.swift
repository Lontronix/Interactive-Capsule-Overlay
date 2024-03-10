//
//  PushDownButton.swift
//
//
//  Created by Lonnie Gerol on 2/29/24.
//

import SwiftUI
import Pow

struct PushDownButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1)
            .conditionalEffect(
              .pushDown,
              condition: configuration.isPressed
            )
    }

}
