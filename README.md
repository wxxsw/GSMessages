# GSMessages
Easy to use messages/notifications for iOS written in pure Swift. Inspired from [TSMessages](https://github.com/KrauseFx/TSMessages)

![](https://github.com/wxxsw/GSMessages/blob/master/demo.gif)

# Installation

## From CocoaPods
GSMessages is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "GSMessages"
    
## Manually
Copy the source files GSMessage into your project.

# Use

To show notifications use the following code:
```Swift
self.showMessage("Something success", type: .Success, options: nil)
```

To display a notice on a view:
```Swift
view.showMessage("Something success", type: .Success, options: [.Position(.Bottom)])
```

To hide a notification manually:
```Swift
self.hideMessage()
```

Type:
```Swift
enum GSMessageType {
    case Success
    case Error
    case Warning
    case Info
}
```

Options:
```Swift
enum GSMessageOption {
    case Animation(GSMessageAnimation)
    case AnimationDuration(NSTimeInterval)
    case AutoHide(Bool)
    case AutoHideDelay(Double)
    case Height(CGFloat)
    case Position(GSMessagePosition)
    case TextColor(UIColor)
}

enum GSMessagePosition {
    case Top    // Default
    case Bottom
}

enum GSMessageAnimation {
    case Slide  // Default
    case Fade
}
```

To set a custom fonts and background colors in the following ways:
```Swift
GSMessage.font = UIFont.boldSystemFontOfSize(12)
GSMessage.successBackgroundColor = .greenColor()
GSMessage.warningBackgroundColor = .yellowColor()
GSMessage.errorBackgroundColor = .redColor()
GSMessage.infoBackgroundColor = .blueColor()
```

