import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/auth/auth.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/widgets.dart';
import '../extensions/extensions.dart';

@RoutePage()
class OtpLoginPage extends AutoRouter {
  const OtpLoginPage({super.key});
}

@RoutePage()
class PasswordLoginPage extends AutoRouter {
  const PasswordLoginPage({super.key});
}

class SupportedLoginsScreen extends StatelessWidget {
  const SupportedLoginsScreen({super.key, required this.supportedLoginType});

  final List<SupportedLoginType> supportedLoginType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.l10n.login_AppBarTitle_otpRequest),
        leading: ExtBackButton(
          onBackPressed: () => context.router.back(),
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: supportedLoginType.isEmpty
          ? const UndefineLoginScreen()
          : AutoTabsRouter(
              routes: const [
                OtpLoginPageRoute(),
                PasswordLoginPageRoute(),
              ],
              transitionBuilder: (context, child, _) {
                final tabsRouter = AutoTabsRouter.of(context);

                return LayoutBuilder(
                  builder: (context, viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const OnboardingLogo(),
                                const SizedBox(height: kInset),
                                supportedLoginType.isEmpty
                                    ? const SizedBox()
                                    : SizedBox(
                                        width: double.infinity,
                                        child: SegmentedButton<SupportedLoginType>(
                                          segments: _getLoginSegments(context),
                                          selected: <SupportedLoginType>{
                                            SupportedLoginType.values[tabsRouter.activeIndex]
                                          },
                                          onSelectionChanged: (Set<SupportedLoginType> newSelection) =>
                                              tabsRouter.setActiveIndex(newSelection.first.index),
                                          showSelectedIcon: false,
                                        ),
                                      ),
                                Expanded(child: child)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  List<ButtonSegment<SupportedLoginType>> _getLoginSegments(BuildContext context) => supportedLoginType
      .map(
        (type) => ButtonSegment<SupportedLoginType>(
          value: type,
          label: Text(type.l10n(context)),
        ),
      )
      .toList();
}
