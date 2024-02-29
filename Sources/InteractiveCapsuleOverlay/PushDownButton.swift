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
            .conditionalEffect(
              .pushDown,
              condition: configuration.isPressed
            )
    }

}
