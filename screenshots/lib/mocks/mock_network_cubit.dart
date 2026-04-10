import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/network/bloc/network_cubit.dart';
import 'package:webtrit_phone/features/settings/features/network/models/incoming_call_type_model.dart';
import 'package:webtrit_phone/models/models.dart';

class MockNetworkCubit extends MockCubit<NetworkState> implements NetworkCubit {
  MockNetworkCubit();

  factory MockNetworkCubit.initial() {
    final mock = MockNetworkCubit();
    whenListen(
      mock,
      const Stream<NetworkState>.empty(),
      initialState: NetworkState(
        incomingCallTypeModels: [
          IncomingCallTypeModel(IncomingCallType.pushNotification, true),
          IncomingCallTypeModel(IncomingCallType.socket, false),
        ],
      ),
    );
    when(() => mock.smsFallbackAvailable).thenReturn(false);
    return mock;
  }
}
