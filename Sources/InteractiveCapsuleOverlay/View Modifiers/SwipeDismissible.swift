//
//  SwipeDismissible.swift
//
//
//  Created by Lonnie Gerol on 2/29/24.
//

import SwiftUI

struct SwipeDismissible: ViewModifier {

    let onDismiss: () -> Void

    @State private var yDragOffset: CGFloat = 0

    /// How far the user must drag for the view to be dismissed
    private let minimumOffsetToDismiss: CGFloat = 50

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                let translationHeight = gesture.translation.height
                if translationHeight > 0 {
                    self.yDragOffset = translationHeight
                }
            }
            .onEnded { _ in
                if self.yDragOffset >= self.minimumOffsetToDismiss {
                    self.onDismiss()
                    self.yDragOffset = 0
                } else {
                    self.yDragOffset = 0
                }
            }
    }

    func body(content: Content) -> some View {
        content
            .animation(.bouncy, value: self.yDragOffset)
            .allowsHitTesting(true)
            .offset(x: 0, y: self.yDragOffset)
            .highPriorityGesture(self.dragGesture)
    }

}

extension View {

    @ViewBuilder
    func swipeDismissible(onDismiss: @escaping () -> Void) -> some View {
        modifier(SwipeDismissible(onDismiss: onDismiss))
    }

}
