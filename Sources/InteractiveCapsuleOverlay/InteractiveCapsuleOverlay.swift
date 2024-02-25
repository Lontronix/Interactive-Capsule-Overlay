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

    @State private var yOffset: CGFloat = 0
    @State private var numStrikes: TimeInterval = 0

    func dismiss() {
        withAnimation {
            self.currentConfig = nil
        } completion: {
            self.numStrikes = 0
        }
    }

    @ViewBuilder
    private func capsuleView(config: CapsuleOverlayConfiguration) -> some View {
        CapsuleView(config: config)
            .modifier(
                FractionalOutline(
                    completionAmount: 1 - ((self.numStrikes) / config.timeoutInterval),
                    accentColor: config.accentColor.opacity(
                        0.60
                    )
                )
            )
            .offset(x: 0, y: yOffset)
            .transition(
                .move(edge: .bottom)
                .combined(with: .opacity)
            )
            .id(config.id)
    }

    public var body: some View {
        GeometryReader { reader in
            VStack {
                Spacer()
                if let currentConfig {
                    capsuleView(config: currentConfig)
                }
            }
            .onChange(of: reader.safeAreaInsets, initial: true) { (_, newSafeAreaInsets) in
                // Ensures there is always ample spacing between the capsule and the home indicator
                yOffset = newSafeAreaInsets.bottom - 32

            }
            .frame(maxWidth: .infinity)
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
                        dismiss()
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

        private func primaryButtonPressed() { }

        private func secondaryButtonPressed() { }

        @ViewBuilder
        private func primaryActionView() -> some View {
            if case let .enabled(
                iconIdentifier: iconIdentifier,
                onPressed: onPressed
            ) = config.primaryAction {
                Image(systemName: iconIdentifier)
                    .fontWeight(.bold)
                    .foregroundStyle(.tint)
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
            }
        }

        var body: some View {
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

                    HStack(spacing: 5) {
                        primaryActionView()
                        secondaryActionButton()
                    }
                }
            }
            .buttonStyle(.plain)
            .frame(minHeight: 35)
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

