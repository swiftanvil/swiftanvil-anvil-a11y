# A11yIdentifiers

Typed accessibility identifiers for SwiftUI and UIKit.

## Description

`A11yIdentifiers` provides a lightweight, type-safe wrapper around raw accessibility-identifier strings. Using `A11yID` turns typos into compile-time errors and makes identifiers composable with a simple dotted syntax.

## Installation

Add the package dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swiftanvil/swiftanvil-anvil-a11y.git", from: "1.0.0"),
]
```

Then add `A11yIdentifiers` to your target:

```swift
.target(name: "MyTarget", dependencies: [
    .product(name: "A11yIdentifiers", package: "swiftanvil-anvil-a11y"),
])
```

## Usage

```swift
import A11yIdentifiers

// Define identifiers
let loginButton: A11yID = "login.button"
let cellID = A11yID(rawValue: "feed.cell").appending(0)

// SwiftUI
Text("Login").a11ID(loginButton)

// UIKit
let button = UIButton()
button.setA11ID(loginButton)
```

## Build & Test

```bash
swift build
swift test
```
