//
//  SwipeDismissible.swift
//
//
//  Created by Lonnie Gerol on 2/29/24.
//

import SwiftUI

struct SwipeDismissible: ViewModifier {

    enum SwipeDismissibleEdge {
        case top
        case bottom
    }

    let swipeDismissibleEdge: SwipeDismissibleEdge
    let onDismiss: () -> Void

    var opacity: CGFloat {
        // the capsule shouldn't be invisible unless its been dismissed since that can confuse the user
        return max(1 - abs(yDragOffset) / minimumOffsetToDismiss, 0.10)
    }

    @State private var yDragOffset: CGFloat = 0

    /// How far the user must drag for the view to be dismissed
    private let minimumOffsetToDismiss: CGFloat = 50

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                var translationHeight =  gesture.translation.height

                switch swipeDismissibleEdge {
                    case .top:
                        if translationHeight < 0 {
                            self.yDragOffset = translationHeight
                        }
                    case .bottom:
                        if translationHeight > 0 {
                            self.yDragOffset = translationHeight
                        }
                }


            }
            .onEnded { _ in
                if abs(self.yDragOffset) >= self.minimumOffsetToDismiss {
                    self.onDismiss()
                    self.yDragOffset = 0
                } else {
                    self.yDragOffset = 0
                }
            }
    }

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .animation(.bouncy, value: self.yDragOffset)
            .allowsHitTesting(true)
            .offset(x: 0, y: self.yDragOffset)
            .highPriorityGesture(self.dragGesture)
    }

}

extension View {

    @ViewBuilder
    func swipeDismissible(edge: SwipeDismissible.SwipeDismissibleEdge, onDismiss: @escaping () -> Void) -> some View {
        modifier(SwipeDismissible(swipeDismissibleEdge: edge, onDismiss: onDismiss))
    }

}
