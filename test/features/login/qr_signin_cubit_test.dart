import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockAppPermissions extends Mock implements AppPermissions {}

void main() {
  late _MockAppPermissions appPermissions;

  setUp(() {
    appPermissions = _MockAppPermissions();
  });

  QrSigninCubit buildCubit({PermissionStatus cameraStatus = PermissionStatus.granted}) {
    when(() => appPermissions.getCameraPermissionStatus()).thenAnswer((_) async => cameraStatus);
    return QrSigninCubit(
      appPermissions: appPermissions,
      parser: QrSigninUriParser(QrSigninConfig(enabled: true, expectedHost: 'EXAMPLE')),
    );
  }

  group('QrSigninCubit', () {
    group('camera permission', () {
      test('granted permission moves to scanning', () async {
        final cubit = buildCubit();
        await pumpEventQueue();

        expect(cubit.state.status, QrSigninStatus.scanning);
        expect(cubit.state.cameraPermanentlyDenied, isFalse);
      });

      test('denied permission moves to permissionRequired', () async {
        final cubit = buildCubit(cameraStatus: PermissionStatus.denied);
        await pumpEventQueue();

        expect(cubit.state.status, QrSigninStatus.permissionRequired);
        expect(cubit.state.cameraPermanentlyDenied, isFalse);
      });

      test('permanent denial is reported so the view can offer the settings screen', () async {
        final cubit = buildCubit(cameraStatus: PermissionStatus.permanentlyDenied);
        await pumpEventQueue();

        expect(cubit.state.status, QrSigninStatus.permissionRequired);
        expect(cubit.state.cameraPermanentlyDenied, isTrue);
      });

      test('a granted request moves to scanning', () async {
        final cubit = buildCubit(cameraStatus: PermissionStatus.denied);
        await pumpEventQueue();
        when(() => appPermissions.requestCameraPermission()).thenAnswer((_) async => PermissionStatus.granted);

        await cubit.requestPermission();

        expect(cubit.state.status, QrSigninStatus.scanning);
      });

      test('a permanently denied request flips the settings flag', () async {
        final cubit = buildCubit(cameraStatus: PermissionStatus.denied);
        await pumpEventQueue();
        when(
          () => appPermissions.requestCameraPermission(),
        ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

        await cubit.requestPermission();

        expect(cubit.state.status, QrSigninStatus.permissionRequired);
        expect(cubit.state.cameraPermanentlyDenied, isTrue);
      });
    });

    group('barcode handling', () {
      test('a valid code is reported as a detection', () async {
        final cubit = buildCubit();
        await pumpEventQueue();

        cubit.barcodeDetected('csc:user123x777:p%40ss777@EXAMPLE');

        final detection = cubit.state.detection;
        expect(detection, isA<QrSigninCredentials>());
        expect((detection as QrSigninCredentials).userRef, 'user123x777');
        expect(cubit.state.parseError, isNull);
      });

      test('an invalid code sets the parse error and does not report a detection', () async {
        final cubit = buildCubit();
        await pumpEventQueue();

        cubit.barcodeDetected('https://example.com');

        expect(cubit.state.detection, isNull);
        expect(cubit.state.parseError, QrSigninParseError.unsupportedScheme);
      });

      test('nothing is handled before the permission check completes', () async {
        final cubit = buildCubit();
        // No pumpEventQueue: still checkingPermission.

        cubit.barcodeDetected('csc:user:pass@EXAMPLE');

        expect(cubit.state.detection, isNull);
      });

      test('a repeated payload is ignored while the detection is pending', () async {
        final cubit = buildCubit();
        await pumpEventQueue();

        cubit.barcodeDetected('csc:user:pass@EXAMPLE');
        final first = cubit.state.detection;
        cubit.barcodeDetected('csc:user:pass@EXAMPLE');

        expect(cubit.state.detection, same(first));
      });

      test('detectionHandled clears the detection', () async {
        final cubit = buildCubit();
        await pumpEventQueue();
        cubit.barcodeDetected('csc:user:pass@EXAMPLE');

        cubit.detectionHandled();

        expect(cubit.state.detection, isNull);
      });

      test('detectionHandled after close is a no-op instead of a StateError', () async {
        final cubit = buildCubit();
        await pumpEventQueue();
        cubit.barcodeDetected('csc:user:pass@EXAMPLE');

        await cubit.close();

        expect(cubit.detectionHandled, returnsNormally);
      });
    });
  });
}
