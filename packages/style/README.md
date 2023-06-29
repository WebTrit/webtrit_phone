The package is designed to update the theme of the application. Also, this package is the source of models for other modules of the system, such as configurator, publisher or phone.

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

