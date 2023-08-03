import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';

import '../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.navigationBarFlavor,
    this.onNavigationBarTap,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final MainFlavor navigationBarFlavor;
  final ValueChanged<int>? onNavigationBarTap;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final _exceptionHandler = Provider.of<ExceptionHandler>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _exceptionHandler.addFilteredListener(_handleInvalidTokenException, filter: (value) => value is RequestFailure);
  }

  @override
  void dispose() {
    _exceptionHandler.removeListener(_handleInvalidTokenException);
    super.dispose();
  }

//TODO: Not sure that this logic has a place here
  void _handleInvalidTokenException() {
    final appBloc = context.read<AppBloc>();
    final exception = _exceptionHandler.exceptionModel?.error as RequestFailure?;
    if (exception?.statusCode == 401) {
      appBloc.add(const AppLogouted());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final scaffold = Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.bodySmall,
        unselectedLabelStyle: themeData.textTheme.bodySmall,
        currentIndex: widget.navigationBarFlavor.index,
        onTap: widget.onNavigationBarTap,
        items: MainFlavor.values.map((flavor) {
          return BottomNavigationBarItem(
            icon: Icon(flavor.icon),
            label: flavor.labelL10n(context),
          );
        }).toList(),
      ),
    );

    return BlocListener<MainBloc, MainState>(
      listener: (context, state) async {
        final error = state.error;
        final updateStoreViewUrl = state.updateStoreViewUrl;
        if (error != null) {
          final appBloc = context.read<AppBloc>();
          final mainBloc = context.read<MainBloc>();
          final result = await CompatibilityIssueDialog.show(
            context,
            error: error,
            onUpdatePressed: updateStoreViewUrl == null
                ? null
                : () {
                    context.read<MainBloc>().add(MainAppUpdated(updateStoreViewUrl));
                  },
          );
          switch (result) {
            case CompatibilityIssueDialogResult.logout:
              appBloc.add(const AppLogouted());
              break;
            default:
              mainBloc.add(const MainCompatibilityVerified());
              break;
          }
        }
      },
      child: scaffold,
    );
  }
}
