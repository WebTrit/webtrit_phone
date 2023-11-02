import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/features/auth/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/login_types_cubit.dart';
import '../extensions/extensions.dart';

class LoginTypesScreen extends StatelessWidget {
  final Widget child;
  final SupportedLoginType selected;

  const LoginTypesScreen({
    super.key,
    required this.selected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypesCubit, LoginTypesState>(
      builder: (BuildContext context, LoginTypesState state) {
        return LoginScaffold(
          appBar: AppBar(
            title: Text(context.l10n.login_AppBarTitle_otpRequest),
            leading: const ExtBackButton(),
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Column(
            children: [
              const OnboardingLogo(),
              Padding(
                padding: const EdgeInsets.fromLTRB(kInset, kInset, kInset, kInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.supportedLogin.length > 1)
                      SegmentedButton<SupportedLoginType>(
                        segments: state.supportedLogin
                            .map((type) => ButtonSegment<SupportedLoginType>(
                                  value: type,
                                  label: Text(type.l10n(context)),
                                ))
                            .toList(),
                        selected: <SupportedLoginType>{selected},
                        onSelectionChanged: (Set<SupportedLoginType> newSelection) => context.go(
                          '${context.namedLocation(AppRoute.loginTypes)}/${newSelection.first.name}',
                        ),
                        showSelectedIcon: false,
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
                  child: child,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
