import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../widgets/widgets.dart';

class UndefineLoginScreen extends StatelessWidget {
  const UndefineLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
      child: Column(
        children: [
          const OnboardingLogo(),
          const SizedBox(height: kInset),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(kInset / 2),
                    child: Text(
                      context.l10n.login_Undefine_noAvailableAuthLogins,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
