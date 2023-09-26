<h1 align="center"> react-native-visionos </h1>

<p align="center">
  <strong>Learn once, write anywhere:</strong><br>
  Build visionOS apps with React.
</p>

This is an independent fork of react-native aimed at exploring the possibilities of making React Native fully compatible with visionOS. While Apple has designed visionOS to work with SwiftUI, React Native currently only utilizes UIKit as the native iOS framework for rendering user interfaces.

This project draws inspiration from the awesome work done by [software-mansion-labs/react-native-swiftui](https://github.com/software-mansion-labs/react-native-swiftui
).

Please note that this project is still a work in progress and is not yet ready for production use.

There are a few things that need to be addressed before this is ready for use:

- [x] CocoaPods releases support for visionOS (https://github.com/CocoaPods/CocoaPods/issues/11961)
- [ ] Update the React Native template to support visionOS
- [ ] Add visionOS support to the following pods:
  - [ ] libevent
  - [ ] SocketRocket (https://github.com/facebookincubator/SocketRocket/pull/669)
  - [ ] fmt
  - [ ] OCMock (https://github.com/erikdoe/ocmock/pull/530)

### Contributing

We welcome contributions to the project! Whether you want to report a bug, propose new features, or submit code changes, your input is highly appreciated.

### License

react-native-visionos, including modifications to the original Facebook source code, and all newly contributed code is provided under the [MIT License](LICENSE). Portions of the react-native-visionos derived from React Native are copyright Facebook.
