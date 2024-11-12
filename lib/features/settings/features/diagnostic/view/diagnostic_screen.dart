import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../bloc/diagnostic_cubit.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class DiagnosticScreen extends StatefulWidget {
  const DiagnosticScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<DiagnosticCubit>().fetchPermissionsStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosticCubit, DiagnosticState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.diagnostic_AppBar_title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ...state.permissions.map(
                  (permission) => DiagnosticPermissionItem(
                    permissionWithStatus: permission,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return DiagnosticPermissionDetails(
                          permissionWithStatus: permission,
                          onTap: () {
                            _handleRequestPermission(permission);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleRequestPermission(PermissionWithStatus permission) {
    context.read<DiagnosticCubit>().handleRequestPermission(permission);
  }
}
