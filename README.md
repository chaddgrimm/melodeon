# Melodeon

[![Apps Using](https://img.shields.io/cocoapods/at/Melodeon.svg?label=Apps)](http://cocoapods.org/pods/melodeon)
[![Downloads](https://img.shields.io/cocoapods/dt/Melodeon.svg?label=Downloads)](http://cocoapods.org/pods/melodeon)
[![Language](https://img.shields.io/badge/Swift-3.0.2-orange.svg?style=flat)](https://swift.org)


[![CI Status](http://img.shields.io/travis/chaddgrimm/melodeon.svg?style=flat)](https://travis-ci.org/chaddgrimm/melodeon)
[![codecov.io](https://codecov.io/gh/chaddgrimm/melodeon/branch/master/graphs/badge.svg)](https://codecov.io/gh/chaddgrimm/melodeon/branch/master)
[![Version](https://img.shields.io/cocoapods/v/Melodeon.svg?style=flat)](http://cocoapods.org/pods/melodeon)
[![License](https://img.shields.io/cocoapods/l/Melodeon.svg?style=flat)](http://cocoapods.org/pods/melodeon)
[![Platform](https://img.shields.io/cocoapods/p/Melodeon.svg?style=flat)](http://cocoapods.org/pods/melodeon)

[![Twitter: @chaddgrimm](https://img.shields.io/badge/contact-@chaddgrimm-blue.svg?style=flat)](https://twitter.com/chaddgrimm)

A simple subclass of UITableViewController which behaves like a melodeon.

![Screen capture](https://gifyu.com/images/melodeon.gif)

## Usage

Inherit `MelodeonController` and implement it just like you would on a normal `UITableViewController`.

```swift
  class TableViewController: MelodeonController {
    var firstList = ["Option One", "Option Two", "Option Three"]
    var secondList = ["Choice One", "Choice Two", "Choice Three", "Choice Four" ]
    var thirdList = ["Element One", "Element Two"]
   
    ...
    .....
    
  }
```

Provide your sections as array and override the `sections` property.

```swift
  override var sections:[Any] {
    return ["List A", "List B", "List C"]
  }
```

And provide the number of rows per section (this is required).

```swift
  override func numberOfRows(inSection section:Int) -> Int {
    switch section {
    case 0:
      return firstList.count
    case 1:
      return secondList.count
    case 2:
      return thirdList.count
    default:
      return 0
    }
  }
  
```
**Optional:**

You may implement your own header cell as long as it is of type `MelodeonHeaderCell`.

```swift
  override var headerClasses:[MelodeonHeaderCell.Type]? {
    return [TableHeaderCell.self, AnotherHeaderCell.self]
  }
```

You may also provide the section which will be expanded when the view is loaded.

```swift
  override var initialExpandedSection: Int {
    return 0
  }
```
You can control which header is interactive.

```swift
  override func header(_ header: MelodeonHeaderCell, shouldTapAtSection section: Int) -> Bool {
    if section == 1 {
      return false
    }
    return true
  }
```
Or handle the tap events.

```swift
  override func header(_ header: MelodeonHeaderCell, didTapAtSection section: Int) {
    // TODO: Implement header tap event here
  }
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Melodeon is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Melodeon"
```

## Author

Chad Lee, chaddgrimm@gmail.com

## License

Melodeon is available under the MIT license. See the LICENSE file for more info.
