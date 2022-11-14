import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_permissions.dart';

import '../permissions.dart';
import 'permissions_scaffold.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({
    super.key,
    required this.appPermissions,
  });

  final AppPermissions appPermissions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PermissionsCubit(
        appPermissions: appPermissions,
      ),
      child: const PermissionsScaffold(),
    );
  }
}
