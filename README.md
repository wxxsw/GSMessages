![GSMessages](https://github.com/wxxsw/GSMessages/blob/master/ScreenShots/logo.png)

<p align="center">
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift2-f48041.svg?style=flat"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%207%2B-blue.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/GSMessages"><img src="https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat"></a>
<a href="https://github.com/wxxsw/GSMessages/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat"></a>
<a href="https://github.com/wxxsw/GSMessages/tree/1.2.2"><img src="https://img.shields.io/badge/release-1.2.2-blue.svg"></a>
</p>

## Demo

![](https://github.com/wxxsw/GSMessages/blob/master/ScreenShots/demo.gif)

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

##### Parameters (Current setting is default value):


```Swift
// Type          : Success / Error / Warning / Info
// Animation     : Slide / Fade
// Position      : Top / Bottom
// TextAlignment : Left / Center / Right
self.showMessage("Some Text...", type: .Success, options: [.Animation(.Slide),
                                                           .AnimationDuration(0.3),
                                                           .AutoHide(true),
                                                           .AutoHideDelay(3.0),
                                                           .Height(44.0),
                                                           .HideOnTap(true),
                                                           .Position(.Top),
                                                           .TextAlignment(.Center),
                                                           .TextColor(UIColor.whiteColor()),
                                                           .TextNumberOfLines(1),
                                                           .TextPadding(30.0)]
```

## Font / Background Color

To set custom fonts and background colors in the following ways:
```Swift
GSMessage.font = UIFont.boldSystemFontOfSize(14)
GSMessage.successBackgroundColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)
GSMessage.warningBackgroundColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255,   alpha: 0.95)
GSMessage.errorBackgroundColor   = UIColor(red: 219.0/255, green: 36.0/255,  blue: 27.0/255,  alpha: 0.70)
GSMessage.infoBackgroundColor    = UIColor(red: 44.0/255,  green: 187.0/255, blue: 255.0/255, alpha: 0.90)
```

## Requirements

- iOS 7.0+
- Xcode 7.3 (Swift 2.2)

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8.**
>
> To use GSMessages with a project targeting iOS 7, you must to drag `GSMessage.swift` to your iOS Project.

### [CocoaPods](http://cocoapods.org/):

In your `Podfile`:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod "GSMessages"
```

And in your `*.swift`:
```swift
import GSMessages
```

### [Carthage](https://github.com/Carthage/Carthage):

In your `Cartfile`:

```
github "wxxsw/GSMessages"
```

And in your `*.swift`:
```swift
import GSMessages
```

## License

GSMessages is available under the MIT license. See the LICENSE file for more info.
