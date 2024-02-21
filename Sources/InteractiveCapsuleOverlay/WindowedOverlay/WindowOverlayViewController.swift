//
//  WindowOverlayViewController.swift
//  
//
//  Created by Lonnie Gerol on 2/20/24.
//

import Foundation
import UIKit

final class WindowOverlayViewController: UIViewController {

    let onDidMoveToWindow: (UIWindow?) -> Void

    init(onDidMoveToWindow: @escaping (UIWindow?) -> Void) {
        self.onDidMoveToWindow = onDidMoveToWindow
        super.init(nibName: nil, bundle: nil)
        self.view.isUserInteractionEnabled = false
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = WindowReaderView { window in
            self.onDidMoveToWindow(window)
        }
    }

}
