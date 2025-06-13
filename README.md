# Lib Pub App

## Overview

The **Lib Pub App** IOS is a library designed to allow all Apple products to be monetized using a single solution.

It encapsulates both Prebid SDK and Google Mobile Ads SDK functionalities, allowing banner and and native ads to be served using the agreed commercial.

## Features List
- Simple API for serving ads.
- Integration with Prebid and Google Ads.
- Well-aligned rules for serving ads inside Globo App Products.
- Strong contracts for collecting and sending common targeting parameters, allowing the correct campaign segmentation.
- Detailed documentation and examples for developers.

## Technologies
The main technologies used in this project include:
- **Swift**: For iOS application development.
- **Cocoapods**: Build automation tool for the project.
- **Google Mobile Ads**: For integrating Google ad services.
- **Prebid SDK**: For enabling header bidding auctions in mobile apps.

## Available ad formats

### Banner

Future development.

### Native

- Pause Ads ✅
- Binge Ads ✅

## Usage

Latest stable version: `0.0.1`

## Requirements

| Instalação                                             | Xcode | Installation                                                                                                         | Status                   |
| ---------------------------------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| iOS 14.0+ | 16.0 | [CocoaPods](#cocoapods) | Available |


### CocoaPods
To integrate `LibPub` into your project, add the following to your `Podfile`:
```swift
source("https://gitlab.globoi.com/native/pods-repository")
...
pod 'LibPub', '0.0.1'
```
> Note: Remember to update your repositories with `pod install --repo-update`

## Development

### Setup

Check your `cocoapods` version:

```sh
gem info cocoapods
```

If your version is not 1.16+, run:

```sh
sudo gem install cocoapods
```

### Installing Libraries
To install the required libraries for the LibPub project using CocoaPods:

```sh
pod deintegrate
pod install
```

### Open LibPub Project
```sh
cd LibPub
open LibPub.xcworkspace
```

### Playground

In the root directory of the repository, there is a Playground project named LibPubPlayground.

This project is designed to help you test and experiment with the LibPub library easily.

```sh
cd LibPubPlayground
open LibPubPlayground.xcworkspace
```

Whenever you make changes to the LibPub library or update its dependencies,

it is essential to run the following command in your terminal to ensure that your project has the latest version.

```sh
pod deintegrate
pod install
```

### Tests
```sh
make lint
make test
```

### Generating new version

```sh
make bump_version
> 0.0.X

make add_version_remote
> branch-name

make setup_cocoapods_deploy
> your gitlab user
> your gitlab token

make validate_podspec # optional

make cocoapods_deploy
```

Check if the package was generated:
```sh
https://gitlab.globoi.com/native/pods-repository/-/tree/master/LibPub
```
