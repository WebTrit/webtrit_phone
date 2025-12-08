import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({super.key, this.appBar, this.body});

  final PreferredSizeWidget? appBar;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
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
