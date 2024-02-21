//
//  InteractiveCapsuleOverlay.swift
//
//
//  Created by Lonnie Gerol on 2/20/24.
//

import SwiftUI

public struct ShowsInteractiveCapsuleOverlay: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .windowedOverlay {
                VStack {
                    Spacer()
                    Text("Hello World")
                        .background(.red)
                }
                .padding()
            }
    }

}

public extension View {

    func showsInteractiveCapsuleOverlay() -> some View {
        return modifier(ShowsInteractiveCapsuleOverlay())
    }

}
