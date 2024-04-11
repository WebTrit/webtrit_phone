import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../about.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        final themeData = Theme.of(context);
        final logo = themeData.extension<LogoAssets>()?.primaryOnboarding;
        final logoHeight = themeData.textTheme.displayLarge!.fontSize! * 1.5;
        final delimiterHeight = themeData.textTheme.titleLarge!.fontSize!;
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.settings_ListViewTileTitle_about),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (logo != null)
                  logo.svg(
                    height: logoHeight,
                  ),
                Text(
                  state.appName,
                  style: themeData.textTheme.displaySmall,
                ),
                Text(state.packageName),
                SizedBox(
                  height: delimiterHeight,
                ),
                Text(
                  context.l10n.settings_AboutText_AppVersion,
                ),
                Text(
                  state.appVersion,
                  style: themeData.textTheme.titleLarge,
                ),
                SizedBox(
                  height: delimiterHeight,
                ),
                Text(
                  context.l10n.settings_AboutText_StoreVersion,
                ),
                Text(
                  state.storeVersion,
                  style: themeData.textTheme.titleLarge,
                ),
                SizedBox(
                  height: delimiterHeight,
                ),
                Text(state.coreUrl.toString()),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      state.progress
                          ? ''
                          : (state.coreVersion ?? context.l10n.settings_AboutText_CoreVersionUndefined).toString(),
                      style: themeData.textTheme.bodyMedium,
                    ),
                    if (state.progress)
                      SizedCircularProgressIndicator(
                        size: themeData.textTheme.bodyMedium!.fontSize!,
                        strokeWidth: 2,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
