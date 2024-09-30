import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedded_state.dart';

part 'embedded_cubit.freezed.dart';

class EmbeddedCubit extends Cubit<EmbeddedState> {
  EmbeddedCubit() : super(const EmbeddedState.initial());
}
