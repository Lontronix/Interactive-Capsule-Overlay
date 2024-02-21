//
//  WindowReaderView.swift
//
//
//  Created by Lonnie Gerol on 2/20/24.
//

import UIKit

final class WindowReaderView: UIView {

    let onDidMoveToWindow: ((UIWindow?) -> Void)

    init(onDidMoveToWindow: @escaping ((UIWindow?) -> Void)) {
        self.onDidMoveToWindow = onDidMoveToWindow
        super.init(frame: .zero)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        Task {
            await MainActor.run {
                onDidMoveToWindow(self.window)
            }
        }
    }

}
