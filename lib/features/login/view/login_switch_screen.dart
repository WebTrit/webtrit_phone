import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginSwitchScreen extends StatelessWidget {
  const LoginSwitchScreen({
    super.key,
    required this.body,
    required this.currentLoginType,
    required this.supportedLoginTypes,
    this.onLoginTypeChanged,
    this.isLogoVisible = true,
  });

  final Widget body;
  final LoginType currentLoginType;
  final List<LoginType> supportedLoginTypes;
  final ValueChanged<LoginType>? onLoginTypeChanged;
  final bool isLogoVisible;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.processing != current.processing,
      builder: (context, state) {
        final themeData = Theme.of(context);
        return LoginScaffold(
          appBar: AppBar(
            leading: ExtBackButton(
              disabled: state.processing,
            ),
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Column(
            children: [
              if (isLogoVisible) ...[
                const OnboardingLogo(),
                const SizedBox(height: kInset),
              ],
              if (supportedLoginTypes.length > 1) ...[
                SegmentedButton<LoginType>(
                  segments: supportedLoginTypes
                      .map((loginType) => ButtonSegment(
                            value: loginType,
                            label: Text(
                              key: loginType.toLoginSegmentKey(),
                              loginType.l10n(context),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ))
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
      },
    );
  }
}
