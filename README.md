
# SKCoreLocationManager

Simple Core Location Manager

## Features

- [x] Easily use Core Location in your project

## Installation

you can copy SKCoreLocationManager folder into your project manually.

## Requirements

- iOS 9.0+ 
- Swift 4.2

## How to use

```swift
let skCoreLocationManager = SKCoreLocationManager()

skCoreLocationManager
    .getLocation { [weak self] (location, error) in
        guard let strongSelf = self else { return }
        if let error = error {
            print(errorMessage: error.localizedDescription)
            return
        }
        guard let location = location else { return }
        print("latitude: ", location.coordinate.latitude)
        print("longtitude: ", location.coordinate.longitude)
    }
```

set
```
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>&quot;Need Location&quot;</string>
```
or 
```
    <key>NSLocationAlwaysUsageDescription</key>
    <string>&quot;Need Location&quot;</string>
```
in your app's Info.plist as source code.
("Privacy - Location When In Use Usage Description" as Property list)
