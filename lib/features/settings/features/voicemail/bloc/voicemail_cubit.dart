import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voicemail_state.dart';
part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit() : super(const VoicemailState.initial());
}
