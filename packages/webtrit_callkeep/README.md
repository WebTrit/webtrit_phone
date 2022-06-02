# webtrit_callkeep

A Flutter plugin that provide integration native call frameworks
(**CallKit** & **PushKit** for iOS and **ConnectionService** for Android).

|             | Android |  iOS  |
|-------------|---------|-------|
| **Support** | SDK 23+ | 10.0+ |

## Contributing

This package uses [pigeon][1] to generate the communication layer between Flutter and the host
platforms. The communication interface is defined in the `pigeons/callkeep.messages.dart`
file. After editing the communication interface regenerate the communication layer by running
`flutter pub run pigeon --input pigeons/callkeep.messages.dart`.

[1]: https://pub.dev/packages/pigeon
