//
//  PassthroughWindow.swift
//
//
//  Created by Lonnie Gerol on 2/20/24.
//

import UIKit

/**
 A UIWindow subclass that ignores touches, unless they are a descendant of the root view.
 */
class PassthroughWindow: UIWindow {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        guard let hitView = super.hitTest(point, with: event) else {
            return nil
        }

        return self.rootViewController?.view == hitView ? nil : hitView
    }

}
