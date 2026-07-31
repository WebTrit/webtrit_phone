import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({
    super.key,
    this.appBar,
    this.body,
    this.contentThemeOverride,
    this.applyToAppBar,
    this.systemUiOverlayStyle,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      contentThemeOverride: contentThemeOverride,
      applyToAppBar: applyToAppBar ?? true,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle ?? systemOverlayStyleOf(Theme.of(context).brightness),
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: IntrinsicHeight(child: body),
              ),
            );
          },
        ),
      ),
    );
  }
}
