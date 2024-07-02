import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class CallInitScaffold extends StatelessWidget {
  const CallInitScaffold({
    super.key,
    this.showProgressIndicator = false,
  });

  final bool showProgressIndicator;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final onTabGradient = themeData.colorScheme.surface;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradients?.tab,
        ),
        child: !showProgressIndicator
            ? null
            : Center(
                child: CircularProgressIndicator(
                  color: onTabGradient,
                ),
              ),
      ),
    );
  }
}
