import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';

class LoginQrSigninScreen extends StatefulWidget {
  const LoginQrSigninScreen({super.key});

  @override
  State<LoginQrSigninScreen> createState() => _LoginQrSigninScreenState();
}

class _LoginQrSigninScreenState extends State<LoginQrSigninScreen> with WidgetsBindingObserver {
  final _scannerController = MobileScannerController(formats: [BarcodeFormat.qrCode]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scannerController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // The MobileScanner widget manages the app lifecycle only for its own
    // internal controller; with an external one the camera session must be
    // stopped and resumed here, or the preview stays frozen after the app
    // returns from the background.
    switch (state) {
      case AppLifecycleState.resumed:
        // The permission may have been granted on the system settings screen.
        context.read<QrSigninCubit>().recheckPermission();
        if (_isScannerVisible) _startScannerSafely();
      case AppLifecycleState.inactive:
        unawaited(_scannerController.stop());
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        break;
    }
  }

  /// Whether the scanner preview is currently part of the tree: the camera is
  /// pointless while the sign-in request is in flight or the permission view
  /// is shown.
  bool get _isScannerVisible =>
      context.read<QrSigninCubit>().state.status == QrSigninStatus.scanning &&
      !context.read<LoginCubit>().state.processing;

  /// Starting is a no-op when the camera is already running, but throws while
  /// a concurrent start (e.g. the remounted widget's auto-start) is still in
  /// flight - tolerate that instead of crashing.
  void _startScannerSafely() {
    unawaited(_scannerController.start().onError<MobileScannerException>((_, _) {}));
  }

  void _onDetect(BarcodeCapture capture) {
    final rawValue = capture.barcodes.firstOrNull?.rawValue;
    context.read<QrSigninCubit>().barcodeDetected(rawValue);
  }

  Future<void> _onDetectionReported(BuildContext context, QrSigninParseResult detection) async {
    final loginCubit = context.read<LoginCubit>();
    final qrSigninCubit = context.read<QrSigninCubit>();

    // No explicit camera stop/start here: swapping the scanner widget out for
    // the verifying view (and back) already stops and restarts the camera, and
    // an extra start() would race the remounted widget's auto-start.
    switch (detection) {
      case QrSigninCredentials(:final userRef, :final password):
        await loginCubit.loginQrSigninSubmitted(userRef: userRef, password: password);
      case QrSigninUserRefOnly(:final userRef):
        // The code carries no password: let the user finish on the password tab.
        loginCubit.passwordSigninUserRefInputChanged(userRef);
        final supportedLoginTypes = loginCubit.state.supportedLoginTypes ?? const [];
        final passwordTabIndex = supportedLoginTypes.indexOf(LoginType.passwordSignin);
        if (context.mounted && passwordTabIndex != -1) {
          AutoTabsRouter.of(context).setActiveIndex(passwordTabIndex);
        }
      case QrSigninParseFailure():
        break; // Failures are reported via [QrSigninState.parseError], not here.
    }

    // Reached when the sign-in attempt failed (on success this widget is gone)
    // or after the prefill handoff: let the scanner accept codes again.
    qrSigninCubit.detectionHandled();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrSigninCubit, QrSigninState>(
      listenWhen: (previous, current) => previous.detection != current.detection && current.detection != null,
      listener: (context, state) => _onDetectionReported(context, state.detection!),
      child: Container(
        padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) => previous.processing != current.processing,
          builder: (context, loginState) {
            return BlocBuilder<QrSigninCubit, QrSigninState>(
              builder: (context, state) {
                if (loginState.processing) return const QrSigninVerifyingView();

                return switch (state.status) {
                  QrSigninStatus.checkingPermission => const SizedBox.shrink(),
                  QrSigninStatus.permissionRequired => QrSigninPermissionView(
                    permanentlyDenied: state.cameraPermanentlyDenied,
                    onRequestPermission: context.read<QrSigninCubit>().requestPermission,
                    onOpenSettings: context.read<QrSigninCubit>().openAppSettings,
                  ),
                  QrSigninStatus.scanning => QrScannerView(
                    controller: _scannerController,
                    onDetect: _onDetect,
                    parseError: state.parseError,
                  ),
                };
              },
            );
          },
        ),
      ),
    );
  }
}
