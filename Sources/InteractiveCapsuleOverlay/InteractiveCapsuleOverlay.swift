//
//  InteractiveCapsuleOverlay.swift
//
//
//  Created by Lonnie Gerol on 2/20/24.
//

import SwiftUI
import Time
import Pow

@MainActor
struct InteractiveCapsuleOverlayView: View {

    @Binding var currentConfig: CapsuleOverlayConfiguration?

    /// the portion of the y offset that is influenced by how far through the swipe to dismiss gesture the user currently is
    @State private var swipeDismissableYOffset: CGFloat = 0
    @State private var numStrikes: TimeInterval = 0

    var yOffset: CGFloat {
        guard let currentConfig else { return 0 }
        let value = switch currentConfig.presentationMode {
            case let .bottom(yOffset: bottomYOffset): swipeDismissableYOffset + bottomYOffset * -1
            case let .top(yOffset: topYOffset): swipeDismissableYOffset + topYOffset
        }
        return value
    }

    var capsuleAlignment: Alignment {
        guard let currentConfig else { return .bottom }
        switch currentConfig.presentationMode {
            case .top:
                return .top
            case .bottom(let yOffset):
                return .bottom
        }
    }

    /// the edge the capsule slides in and out from when being shown or hidden
    var dismissEdge: Edge {
        guard let currentConfig else { return .bottom }
        switch currentConfig.presentationMode {
            case .top(let yOffset):
                return .top
            case .bottom(let yOffset):
                return .bottom
        }
    }

    func dismissCapsule() {
        withAnimation {
            self.currentConfig = nil
        } completion: {
            self.numStrikes = 0
        }
    }

    @ViewBuilder
    private func capsuleView(config: CapsuleOverlayConfiguration) -> some View {
        CapsuleView(config: config) {
            dismissCapsule()
        }
        .fractionalOutline(
            completionAmount:  1 - ((self.numStrikes) / config.timeoutInterval),
            accentColor: config.accentColor.opacity(0.60)
        )
        .swipeDismissible(edge: dismissEdge == .top ? .top : .bottom) {
            dismissCapsule()
        }
        .offset(x: 0, y: yOffset)
        .transition(
            .move(edge: dismissEdge)
            .combined(with: .opacity)
        )
        .id(config.id)
    }

    public var body: some View {
        GeometryReader { reader in
            VStack {
                if let currentConfig {
                    capsuleView(config: currentConfig)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: capsuleAlignment)
            .animation(.bouncy, value: currentConfig)
        }
        .onChange(of: currentConfig) {
            guard currentConfig != nil else { return }

            // ensures outline resets with no animation when switching between configs
            var transaction = Transaction(animation: .none)
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                numStrikes = 0
            }
        }
        .task {
            do {
                let strikes = Clocks.system.strike(
                    every: Second.self,
                    startingFrom: .init(
                        region: .current,
                        date: .now
                    )
                )
                for try await _ in strikes.asyncValues {
                    guard let currentConfig = currentConfig else { continue }
                    guard numStrikes < currentConfig.timeoutInterval else {
                        dismissCapsule()
                        continue
                    }
                    self.numStrikes += 1
                }
            } catch {
                print(error)
            }
        }
        .dynamicTypeSize(.medium)
    }

}

extension InteractiveCapsuleOverlayView {

    struct CapsuleView: View {

        @Environment(\.colorScheme) private var colorScheme

        let config: CapsuleOverlayConfiguration

        let dismissCapsule: () -> Void

        var primaryButtonIsEnabled: Bool {
            guard case let .enabled(iconIdentifier: _, onPressed: onPressed) = config.primaryAction else {
                return false
            }
            return true
        }

        private func primaryButtonPressed() { 
            guard case let .enabled(iconIdentifier: _, onPressed: onPressed) = config.primaryAction else {
                return
            }
            onPressed()
            dismissCapsule()
        }

        private func secondaryButtonPressed() { 
            guard case let .enabled(iconIdentifier: _, onPressed: onPressed) = config.secondaryAction else {
                return
            }
            onPressed()
            dismissCapsule()
        }

        @ViewBuilder
        private func primaryActionView() -> some View {
            if case let .enabled(
                iconIdentifier: iconIdentifier,
                onPressed: onPressed
            ) = config.primaryAction {
                Image(systemName: iconIdentifier)
                    .fontWeight(.bold)
                    .foregroundStyle(.tint.opacity(0.80))
            }
        }

        @ViewBuilder
        private func secondaryActionButton() -> some View {
            if case let .enabled(
                iconIdentifier: iconIdentifier,
                onPressed: onPressed
            ) = config.secondaryAction {
                Button {
                    secondaryButtonPressed()
                } label: {
                    Image(systemName: iconIdentifier)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                        .symbolRenderingMode(.hierarchical)
                }
                .foregroundStyle(.tint)
                .buttonStyle(PushDownButtonStyle())
            }
        }

        var body: some View {
            HStack {
                Button {
                    primaryButtonPressed()
                } label: {
                    HStack {
                        VStack(alignment: .center, spacing: 0) {
                            Text(config.title)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(.secondary)
                        Spacer()
                        HStack(spacing: 5) {
                            primaryActionView()
                        }
                    }
                }
                .buttonStyle(PushDownButtonStyle())
                secondaryActionButton()
            }
            .frame(minHeight: 35)
            .frame(width: 200)
            .padding(.vertical, 7)
            .padding(.leading)
            .padding(.trailing, 5)
            .tint(config.accentColor)
            .background(Material.regular)
            .clipShape(.capsule(style: .circular))
            .shadow(color: self.colorScheme == .light ? .black.opacity(0.30) : .clear, radius: 15)
        }

    }

}
