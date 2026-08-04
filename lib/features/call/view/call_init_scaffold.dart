import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'call_screen_styles.dart';

class CallInitScaffold extends StatelessWidget {
  const CallInitScaffold({super.key, this.showProgressIndicator = false});

  final bool showProgressIndicator;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final style = themeData.extension<CallScreenStyles>()?.primary;
    final surfaceColor = themeData.colorScheme.surface;

    return ThemedScaffold(
      background: style?.background,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            child: AppBar(
              leading: style?.appBar?.showBackButton == false ? null : const ExtBackButton(),
              // Fallbacks keep the bar transparent with a light foreground over
              // the dark call gradient even when the call style is absent.
              backgroundColor: style?.appBar?.backgroundColor ?? Colors.transparent,
              foregroundColor: style?.appBar?.foregroundColor ?? surfaceColor,
              primary: style?.appBar?.primary ?? false,
            ),
          ),
          Center(
            child: Visibility(
              visible: showProgressIndicator,
              child: CircularProgressIndicator(color: surfaceColor),
            ),
          ),
        ],
      ),
    );
  }
}
