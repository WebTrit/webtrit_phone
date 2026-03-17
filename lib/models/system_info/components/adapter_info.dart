import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/app/constants.dart';

class AdapterInfo with EquatableMixin {
  AdapterInfo({this.name, this.version, this.supported, this.custom});

  final String? name;
  final String? version;
  final List<String>? supported;
  final Map<String, dynamic>? custom;

  @override
  List<Object?> get props => [name, version, supported, custom];

  @override
  bool get stringify => true;

  bool get supportsSipPresence => supported?.contains(kSipPresenceFeatureFlag) ?? false;

  bool get supportsSipDialogs => supported?.contains(kSipDialogsFeatureFlag) ?? false;
}
