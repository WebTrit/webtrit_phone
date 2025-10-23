part of 'main_bloc.dart';

sealed class MainBlocEvent {
  const MainBlocEvent();
}

class MainBlocInit extends MainBlocEvent {
  const MainBlocInit();
}

class MainBlocSystemInfoArrived extends MainBlocEvent {
  final WebtritSystemInfo systemInfo;
  const MainBlocSystemInfoArrived(this.systemInfo);
}

class MainBlocAppUpdatePressed extends MainBlocEvent {
  final Uri storeUrl;
  const MainBlocAppUpdatePressed(this.storeUrl);
}