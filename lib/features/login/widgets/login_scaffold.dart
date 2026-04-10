import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        // Use provided style, or fallback to dark icons (standard for light backgrounds),
        // but ideally this should align with the active theme brightness.
        value: systemUiOverlayStyle ?? SystemUiOverlayStyle.dark,
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
