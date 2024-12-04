# DGReverseBlurEffect
Reversed Blur Effect Function

## Installation

### Swift Package Manager

The [Swift Package Manager](https://www.swift.org/documentation/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding `DGReverseBlurEffect` as a dependency is as easy as adding it to the dependencies value of your Package.swift or the Package list in Xcode.

```
dependencies: [
   .package(url: "https://github.com/donggyushin/DGReverseBlurEffect.git", .upToNextMajor(from: "1.1.0"))
]
```

Normally you'll want to depend on the DGReverseBlurEffect target:

```
.product(name: "DGReverseBlurEffect", package: "DGReverseBlurEffect")
```

##Usage

```swift
imageView.reversedBlur(parentFrame: frame, leftPadding: 13, topPadding: 10, rightPadding: 13, bottomPadding: 80, cornerRadius: 20)
```

<img width="250" alt="스크린샷 2024-10-25 오후 6 07 15" src="https://github.com/user-attachments/assets/5012dd3f-f137-43a0-96cd-1a0d833e2305">