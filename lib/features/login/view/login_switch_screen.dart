import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';

class LoginSwitchScreen extends StatelessWidget {
  const LoginSwitchScreen({
    super.key,
    required this.appBar,
    required this.header,
    required this.body,
    required this.currentLoginType,
    required this.supportedLoginTypes,
    this.onLoginTypeChanged,
  });

  final PreferredSizeWidget? appBar;
  final Widget? header;
  final Widget body;
  final LoginType currentLoginType;
  final List<LoginType> supportedLoginTypes;
  final ValueChanged<LoginType>? onLoginTypeChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return LoginScaffold(
      appBar: appBar,
      body: Column(
        children: [
          if (header != null) header!,
          if (supportedLoginTypes.length > 1) ...[
            SegmentedButton<LoginType>(
              segments: supportedLoginTypes
                  .map(
                    (loginType) => ButtonSegment(
                      value: loginType,
                      label: Text(
                        key: loginType.toLoginSegmentKey(),
                        loginType.l10n(context),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                  .toList(growable: false),
              selected: {currentLoginType},
              onSelectionChanged: (Set<LoginType> newSelection) => onLoginTypeChanged?.call(newSelection.first),
              showSelectedIcon: false,
            ),
            const SizedBox(height: kInset),
          ],
          Expanded(
            child: Ink(
              color: themeData.scaffoldBackgroundColor, // background color necessary for visually proper transition
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
