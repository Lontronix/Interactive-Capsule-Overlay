//
//  FractionalOutline.swift
//
//
//  Created by Lonnie Gerol on 2/24/24.
//

import SwiftUI

struct FractionalOutline: ViewModifier {

    let completionAmount: CGFloat
    let accentColor: Color

    func body(content: Content) -> some View {
        content
            .overlay {
                Capsule(style: .continuous)
                    .trim(from: 0, to: self.completionAmount)
                    .fill(.clear)
                    .stroke(self.accentColor, lineWidth: 2.0)
            }
            .animation(.linear(duration: 1.0), value: completionAmount)
    }

}

extension View {

    @ViewBuilder
    func fractionalOutline(completionAmount: CGFloat, accentColor: Color) -> some View {
        modifier(FractionalOutline(completionAmount: completionAmount, accentColor: accentColor))
    }

}

