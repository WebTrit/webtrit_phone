import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'embaded_state.dart';
part 'embaded_cubit.freezed.dart';

class EmbadedCubit extends Cubit<EmbadedState> {
  EmbadedCubit() : super(const EmbadedState.initial());
}
