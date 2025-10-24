part of 'main_bloc.dart';

sealed class MainBlocEvent extends Equatable {
  const MainBlocEvent();

  @override
  List<Object> get props => [];
}

class MainBlocInit extends MainBlocEvent {
  const MainBlocInit();
}

class MainBlocSystemInfoArrived extends MainBlocEvent {
  final WebtritSystemInfo systemInfo;
  const MainBlocSystemInfoArrived(this.systemInfo);

  @override
  List<Object> get props => [
    EquatablePropToString([systemInfo], listPropToString),
  ];
}

class MainBlocAppUpdatePressed extends MainBlocEvent {
  final Uri storeUrl;
  const MainBlocAppUpdatePressed(this.storeUrl);

  @override
  List<Object> get props => [
    EquatablePropToString([storeUrl], listPropToString),
  ];
}