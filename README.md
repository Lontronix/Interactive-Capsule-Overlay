# Interactive Capsule Overlay

A Swift Package for presenting an interactive capsule over all other content (including sheets).

## Usage

Add the `showsInteractiveCapsuleOverlay` View Modifier to the root view of your app.

```swift
import InteractiveCapsuleOverlay

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
              .showsInteractiveCapsuleOverlay()
        }
    }
}
```
