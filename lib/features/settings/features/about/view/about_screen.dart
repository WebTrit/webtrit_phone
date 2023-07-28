import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
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
    return BlocConsumer<AboutBloc, AboutState>(
      listener: (context, state) {
        final errorL10n = state.errorL10n(context);
        if (errorL10n != null) {
          context.showErrorSnackBar(errorL10n);
          context.read<AboutBloc>().add(const AboutErrorDismissed());
        }
      },
      builder: (context, state) {
        final themeData = Theme.of(context);
        final logo = themeData.extension<GenImages>()?.primaryOnboardinLogo;
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
                  StreamBuilder<SvgLoader?>(
                    stream: logo,
                    builder: (BuildContext context, AsyncSnapshot<SvgLoader?> snapshot) {
                      if (snapshot.hasError) {
                        return SizedBox(
                          height: logoHeight,
                        );
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return SizedBox(
                            height: logoHeight,
                          );
                        case ConnectionState.waiting:
                          return SizedCircularProgressIndicator(
                            size: themeData.textTheme.bodyMedium!.fontSize!,
                            strokeWidth: 2,
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.data != null) {
                            return SvgPicture(
                              snapshot.data!,
                              height: logoHeight,
                            );
                          } else {
                            return SizedBox(
                              height: logoHeight,
                            );
                          }
                      }
                    },
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
                  state.appVersion,
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
