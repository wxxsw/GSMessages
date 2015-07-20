# GSMessages

Easy to use messages/notifications for iOS written in pure Swift. Inspired from [TSMessages](https://github.com/KrauseFx/TSMessages)

![](https://github.com/wxxsw/GSMessages/blob/master/demo.gif)

## Example

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

## Parameters

##### Type:

```Swift
enum GSMessageType {
    case Success
    case Error
    case Warning
    case Info
}
```

##### Options:

```Swift
enum GSMessageOption {
    case Animation(GSMessageAnimation)      // Default is .Slide (Other: .Fade)
    case AnimationDuration(NSTimeInterval)  // Default is 0.3
    case AutoHide(Bool)                     // Default is true
    case AutoHideDelay(Double)              // Default is 3
    case Height(CGFloat)                    // Default is 44.0
    case Position(GSMessagePosition)        // Default is .Top (Other: .Bottom)
    case TextColor(UIColor)                 // Default is .whiteColor()
}
```

## Font / Background Color

To set custom fonts and background colors in the following ways:
```Swift
GSMessage.font = UIFont.boldSystemFontOfSize(12)
GSMessage.successBackgroundColor = .greenColor()
GSMessage.warningBackgroundColor = .yellowColor()
GSMessage.errorBackgroundColor = .redColor()
GSMessage.infoBackgroundColor = .blueColor()
```

## Installation

Feel free to drag `GSMessage.swift` to your iOS Project. But it's recommended to use CocoaPods

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ [sudo] gem install cocoapods
```

To integrate GSMessages into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'GSMessages'
```

Then, run the following command:

```bash
$ pod install
```

You should open the `{Project}.xcworkspace` instead of the `{Project}.xcodeproj` after you installed anything from CocoaPods.

For more information about how to use CocoaPods, I suggest [this tutorial](http://www.raywenderlich.com/64546/introduction-to-cocoapods-2).

## License

GSMessages is available under the MIT license. See the LICENSE file for more info.
