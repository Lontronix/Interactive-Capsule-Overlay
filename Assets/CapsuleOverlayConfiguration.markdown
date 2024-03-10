| Parameter              | Type                | Description                                                                                   |
| ---------------------- | ------------------- | --------------------------------------------------------------------------------------------- |
| title                  | String              | Prominent text displayed in the capsule                                                       |
| timeoutInterval        | TimeInterval        | How long the capsule is displayed before being automatically dismissed                        |
| primaryAction          | ActionConfiguration | The action that is invoked by tapping anywhere on the capsule but the secondary action button |
| secondaryAction        | ActionConfiguration | the action that is invoked by tapping the secondary button                                    |
| onDismissButtonPressed | (() -> Void)?       | A closure that is called when the user taps the dismiss button                                |
| accentColor            | Color               | the accent color of the overlay                                                               |
