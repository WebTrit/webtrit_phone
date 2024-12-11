import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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
        child: Stack(
          children: [
            SafeArea(
              child: AppBar(
                leading: const ExtBackButton(),
                backgroundColor: Colors.transparent,
                foregroundColor: onTabGradient,
                primary: false,
              ),
            ),
            Center(
              child: Visibility(
                visible: showProgressIndicator,
                child: CircularProgressIndicator(
                  color: onTabGradient,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
