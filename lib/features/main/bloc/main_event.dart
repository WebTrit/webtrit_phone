part of 'main_bloc.dart';

abstract class MainBlocEvent {
  const MainBlocEvent();
}

final class MainBlocInit extends MainBlocEvent {
  const MainBlocInit();
}

final class MainBlocSystemInfoArrived extends MainBlocEvent {
  final WebtritSystemInfo systemInfo;
  const MainBlocSystemInfoArrived(this.systemInfo);
}

final class MainBlocAppUpdatePressed extends MainBlocEvent {
  final Uri storeUrl;
  const MainBlocAppUpdatePressed(this.storeUrl);
}
