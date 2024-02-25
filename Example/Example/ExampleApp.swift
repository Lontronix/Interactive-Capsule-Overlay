//
//  ExampleApp.swift
//  Example
//
//  Created by Lonnie Gerol on 2/20/24.
//

import SwiftUI
import InteractiveCapsuleOverlay

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .showsInteractiveCapsuleOverlay()
        }
    }
}
