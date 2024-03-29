//
//  ContentView.swift
//  Example
//
//  Created by Lonnie Gerol on 2/20/24.
//

import SwiftUI
import InteractiveCapsuleOverlay

struct ContentView: View {

    @Environment(\.showOverlay) private var showOverlay

    @State private var sheetPresented = false
    @State private var selectedAction: OverlayAction = .completeTask
    @State private var selectedPresentationMode: CapsuleOverlayConfiguration.PresentationMode = .bottom()

    var body: some View {
        NavigationStack {
            VStack {
                Button("Present Sheet") {
                    sheetPresented = true
                }
                .buttonStyle(.bordered)
                Picker("Selected Scenario", selection: $selectedAction) {
                    ForEach(OverlayAction.allCases) { overlayAction in
                        Text("\(overlayAction.rawValue)")
                            .tag(overlayAction)
                    }
                }

                Picker("Presentation Mode", selection: $selectedPresentationMode) {
                    Text("Top")
                        .tag(CapsuleOverlayConfiguration.PresentationMode.top())
                    Text("Bottom")
                        .tag(CapsuleOverlayConfiguration.PresentationMode.bottom())
                }

                Button("Show Overlay") {
                    showOverlay(
                        selectedAction.configuration(presentationMode: selectedPresentationMode)
                    )
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Example")
        }
        .sheet(isPresented: $sheetPresented) {
            Text("This is a sheet... there are many like it but this one is mine.")
        }
    }
}

#Preview {
    ContentView()
}
