## LoaderButton

![Version](https://img.shields.io/badge/swift-4.0-orange.svg)

![build](https://img.shields.io/badge/build-passing-green.svg)

![License](https://img.shields.io/badge/License-MIT-brightgreen.svg)

![platform](https://img.shields.io/badge/platforom-ios-yellowgreen.svg)

![LoaderButton](https://github.com/Jovins/LoaderButton/blob/master/Images/loaderbutton.png)

### Example

- To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Screenshots

![LoaderButton](https://github.com/Jovins/LoaderButton/blob/master/Images/loaderbutton.gif)

### Requirements

- iOS 9.0 or later
- Swift 3.0 or later

### Installation

- LoaderButton is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

``` 
pod 'LoaderButton'
```

``` 
import UIKit
import LoaderButton
```

- Usage example

``` 
/// start animation
button.startAnimate(loaderType: .rotateChase, loaderColor: .white, complete: nil)

/// stop animation
button.stopAnimate(complete: nil)
```

### Author

jovinscoder@163.com

### License

- LoaderButton is available under the MIT license. See the LICENSE file for more info.

### Inspired

- LoaderButton animations inspired from  [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)