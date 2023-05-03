A library for Dart developers.

## Usage

A simple usage example:

```dart
import 'package:style/style.dart';

main() async {
  StyleManager.setting(
    host: AppYaml().publisherConfig.host,
  );

  StyleManager.init(
      applicationId: AppYaml().publisherConfig.applicationId,
      themeId: AppYaml().publisherConfig.themeId,
      defaultTheme: Assets.style.webtrit);

  final styleModel = await StyleManager().get();
}
```

