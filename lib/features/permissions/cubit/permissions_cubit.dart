import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/data/app_permissions.dart';

part 'permissions_cubit.freezed.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit({
    required this.appPermissions,
  }) : super(const PermissionsState());

  final AppPermissions appPermissions;

  void requestPermissions() async {
    emit(state.copyWith(status: PermissionsStatus.inProgress));
    try {
      await appPermissions.request();
      emit(state.copyWith(status: PermissionsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PermissionsStatus.failure));
    }
  }
}
