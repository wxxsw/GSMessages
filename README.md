![GSMessages](https://github.com/wxxsw/GSMessages/blob/master/ScreenShots/logo.png)

<p align="center">
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift4-f48041.svg?style=flat"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/GSMessages"><img src="https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat"></a>
<a href="https://github.com/wxxsw/GSMessages/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat"></a>
<a href="https://github.com/wxxsw/GSMessages/tree/1.5.1"><img src="https://img.shields.io/badge/release-1.5.1-blue.svg"></a>
</p>

## Demo

![](https://github.com/wxxsw/GSMessages/blob/master/ScreenShots/demo.gif)

## Example

To show notifications use the following code:
```Swift
self.showMessage("Something success", type: .success)
```

To display a notice on a view:
```Swift
view.showMessage("Something success", type: .success)
```

To hide a notification manually:
```Swift
self.hideMessage()
```

#### Options (Current setting is default value):

- type          : success / error / warning / info
- animation     : slide / fade
- position      : top / bottom
- textAlignment : topLeft / topCenter / topRight / left / center / right / bottomLeft / bottomCenter / bottomRight

```Swift
self.showMessage("String or NSAttributedString", type: .success, options: [
    .animation(.slide),
    .animationDuration(0.3),
    .autoHide(true),
    .autoHideDelay(3.0),
    .cornerRadius(0.0),
    .height(44.0),
    .hideOnTap(true),
    .margin(.zero),
    .padding(.init(top: 10, left: 30, bottom: 10, right: 30)),
    .position(.top),
    .textAlignment(.center),
    .textColor(.white)
    .textNumberOfLines(1),
])
```

## Font / Background Color

To set custom fonts and background colors in the following ways:
```Swift
GSMessage.font = UIFont.boldSystemFont(ofSize: 14)
GSMessage.successBackgroundColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)
GSMessage.warningBackgroundColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255,   alpha: 0.95)
GSMessage.errorBackgroundColor   = UIColor(red: 219.0/255, green: 36.0/255,  blue: 27.0/255,  alpha: 0.70)
GSMessage.infoBackgroundColor    = UIColor(red: 44.0/255,  green: 187.0/255, blue: 255.0/255, alpha: 0.90)
```

## Requirements

### Master

- iOS 8.0+
- Xcode 9.0+ (Swift 4.x)

### [1.3.5](https://github.com/wxxsw/GSMessages/tree/1.3.5)

- iOS 8.0+
- Xcode 8.0+ (Swift 3.x)

### [1.2.4](https://github.com/wxxsw/GSMessages/tree/1.2.4)

- iOS 7.0+
- Xcode 7.3+ (Swift 2.x)

## Installation

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
