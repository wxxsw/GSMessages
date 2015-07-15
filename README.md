# GSMessages
Easy to use messages/notifications for iOS written in pure Swift.

![](https://github.com/wxxsw/GSMessages/blob/master/demo.gif)

## Use
```Swift
showSuccessMessage("Something success", options: nil)
showErrorMessage("Something failure", options: [.Position(.Bottom)])
showWarningMessage("Some warning", options: [.Animation(.Fade)])
showInfoMessage("Some message", options: [.Height(60), .Position(.Bottom)])
```
## Options
```Swift
enum GSMessagePosition {
    case Top    // Default
    case Bottom
}

enum GSMessageAnimation {
    case Slide  // Default
    case Fade
}

enum GSMessageOption {
    case Animation(GSMessageAnimation)
    case AnimationDuration(NSTimeInterval)
    case AutoHide(Bool)
    case AutoHideDelay(Double)
    case Height(CGFloat)
    case Position(GSMessagePosition)
    case TextColor(UIColor)
}
```
