# ToasterSwift

[![CI Status](http://img.shields.io/travis/jonathan-leininger/ToasterSwift.svg?style=flat)](https://travis-ci.org/jonathan-leininger/ToasterSwift)
[![Version](https://img.shields.io/cocoapods/v/ToasterSwift.svg?style=flat)](http://cocoapods.org/pods/ToasterSwift)
[![License](https://img.shields.io/cocoapods/l/ToasterSwift.svg?style=flat)](http://cocoapods.org/pods/ToasterSwift)
[![Platform](https://img.shields.io/cocoapods/p/ToasterSwift.svg?style=flat)](http://cocoapods.org/pods/ToasterSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ToasterSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ToasterSwift"
``````

## Utilisation

```ruby
ToasterSwift.shared.show(message: "Hello world !", keep: true, close: true)
``````
    
| Parameter | Description |
| ------ | ------ |
| keep | true if the toast should still be display, false to auto hide this one after N seconds |
| close | true if the button close should be display |


```ruby
ToasterSwift.shared.hide()
``````

## Author

jonathan-leininger

## License

ToasterSwift is available under the MIT license. See the LICENSE file for more info.
