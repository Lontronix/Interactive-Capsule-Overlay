# Interactive Capsule Overlay

A Swift Package for presenting a configurable interactive capsule over all other content (including modal sheets).

<p align="center">
    <img src="Assets/demo.gif" alt="A Demo of this package" width="200"/>
</p>

## Usage

## Installation

**Interactive Capsule Overlay** is installed like any other Swift Package, just add this to the `dependencies` section of your `Package.swift` file

```
.package(url: "https://github.com/lontronix/Interactive-Capsule-Overlay", from: "1.1.2")
```

## Add the `showsInteractiveCapsuleOverlay` View Modifier to the root view of your app.

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

## Create a Custom Configuration

Create a custom `CapsuleOverlayConfiguration`

### CapsuleOverlayConfiguration:
| Parameter       | Type                | Description                                                                                               |
| --------------- | ------------------- | ---------------------------------------------------------------------------------------------             |
| title           | String              | Prominent text displayed in the capsule                                                                   |
| timeoutInterval | TimeInterval        | How long the capsule is displayed before being automatically dismissed (has a default value of 5 seconds) |
| primaryAction   | ActionConfiguration | The action that is invoked by tapping anywhere on the capsule but the secondary action button             |
| secondaryAction | ActionConfiguration | the action that is invoked by tapping the secondary button                                                |
| accentColor     | Color               | the accent color of the overlay                                                                           |

### ActionConfiguration


#### case: disabled

The action is disable and hidden

#### case: enabled

The action is enabled and visible

| Parameter      | Type       | Description                                                          |
| -------------- | ---------- | -------------------------------------------------------------------- |
| iconIdentifier | String     | The icon used to represent the action (an SF Symbol name)            |
| onPressed      | () -> Void | A callback this library calls when the action is invoked by the user |

### PresentationMode

#### case: top

The overlay is presented from the top of the screen.

#### case: bottom

The overlay is presented from the bottom of the screen.

| Parameter | Type    | Description                                                                             |
| --------- | ------- | --------------------------------------------------------------------------------------- |
| yOffset   | CGFloat | How far the capsule is offset from the top or bottom of the screen (based on the mode). |

**Note:** The specified value is automatically negated for the bottom mode. (i.e. 20 means move the capsule 20 points up)


### CapsuleOverlayConfiguration:

```swift
import InteractiveCapsuleOverlay

extension CapsuleOverlayConfiguration { 

    static func taskCompleted(accentColor: Color) -> CapsuleOverlayConfiguration {
        return CapsuleOverlayConfiguration(
            title: "Task Completed",
            primaryAction: .enabled(iconIdentifier: "slider.horizontal.3", onPressed: {
                // Do something
            }),
            timeoutInterval: 5,
            secondaryAction: .enabled(iconIdentifier: "arrow.uturn.backward.circle.fill", onPressed: {
                // Do something
            }),
            accentColor: accentColor
        )
    }

}
```
## Display the Overlay

Use the `showOverlay` environment value to make the capsule appear with the desired configuration.

```swift

import InteractiveCapsuleOverlay

struct ContentView: View { 
    
    @Environment(\.showOverlay) private var showOverlay
    
    var body: some View {
        Button("Complete Task") {
            showOverlay(.taskCompleted(.blue))
        }
    }

}

```
