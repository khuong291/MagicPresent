<img src="https://image.ibb.co/hpOVFw/Logo.png" width="700">

[![Version](https://img.shields.io/cocoapods/v/Presentr.svg?style=flat)](http://cocoapods.org/pods/Presentr)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platform](https://img.shields.io/cocoapods/p/Presentr.svg?style=flat)](http://cocoapods.org/pods/Presentr)
[![License](https://img.shields.io/cocoapods/l/Presentr.svg?style=flat)](http://cocoapods.org/pods/Presentr)

*MagicPresent is a simple customizable wrapper for the Custom View Controller Presentation API introduced in iOS 8.*

## About

iOS let's you modally present any view controller, but if you want the presented view controller to not cover the whole screen or modify anything about its presentation or transition you have to use the Custom View Controller Presentation API's.

This can be cumbersome, specially if you do it multiple times in your app. **MagicPresent** simplifies all of this. You just have to configure your **MagicPresent** object depending on how you want you view controller to be presented, and the framework handles everything for you.

<img src="https://github.com/khuong291/MagicPresent/blob/master/BottomPosition.gif" width="192"><img src="https://github.com/khuong291/MagicPresent/blob/master/CenterPosition.gif" width="192"><img src="https://github.com/khuong291/MagicPresent/blob/master/TopPosition.gif" width="192">

## Contributing

1. Fork project
2. Checkout **master** branch
3. Create **Feature** branch off of the **master** branch
4. Create awesome feature/enhancement/bug-fix
5. Optionally create *Issue* to discuss feature
6. Submit pull request from your **Feature** branch to MagicPresent's **master** branch

## Installation

### [Cocoapods](http://cocoapods.org)

```ruby
use_frameworks!

pod 'MagicPresent'
```

### [Carthage](https://github.com/Carthage/Carthage)
Add Presentr to you `Cartfile`
```sh
github "khuong291/MagicPresent"
```
Install using
```sh
carthage update --platform ios
```

### Manually
1. Download and drop ```/MagicPresent``` folder in your project.  
2. You're done!

## Getting started

### Create a Presentr object

Your **MagicPresent** can be as simple as this:

```swift
class ViewController: UIViewController {
  private var presentationVC: MagicPresent?
}
```

### Present the view controller.

Instantiate the View Controller you want to present and use **MagicPresent** object to do the custom presentation.

```swift
let vc = ViewController2()
presentationVC = MagicPresent(presentedViewController: vc, presenting: self)
presentationVC?.cornerRadius = 6
presentationVC?.position = .center
present(vc, animated: true, completion: nil)
```

In your View Controller you want to present, set preferredContentSize with the size you want

```swift
preferredContentSize = CGSize(width: 350 , height: 350) 
```

## Main Types

### Presentation Position

```swift
public enum PresentationPosition {
  case bottom
  case center
  case top
}
```

## Properties

#### Properties are optional, as they all have Default values.

```swift
open var animationDuration: Double = 0.2
open var position: PresentationPosition = .center
open var shadowEnabled = true
open var cornerRadius: CGFloat = 0
open var dismissEnabled = true
open var shadowAlpha: CGFloat = 0.5
    
open var shadowOpacity: Float = 0.5
open var shadowRadius: CGFloat = 5
open var shadowOffsetWidth = 0
open var shadowOffsetHeight = -3
```

## Requirements

* iOS 9.0+
* Xcode 8.0+
* Swift 3.0+

##  Author
[Khuong Pham](http://kasler.net) <br>

## License
MagicPresent is released under the MIT license.  
See LICENSE for details.
