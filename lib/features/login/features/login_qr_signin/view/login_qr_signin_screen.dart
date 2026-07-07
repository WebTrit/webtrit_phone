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
    // The permission may have been granted on the system settings screen.
    if (state == AppLifecycleState.resumed) {
      context.read<QrSigninCubit>().recheckPermission();
    }
  }

  void _onDetect(BarcodeCapture capture) {
    final rawValue = capture.barcodes.firstOrNull?.rawValue;
    context.read<QrSigninCubit>().barcodeDetected(rawValue);
  }

  Future<void> _onDetectionReported(BuildContext context, QrSigninParseResult detection) async {
    final loginCubit = context.read<LoginCubit>();
    final qrSigninCubit = context.read<QrSigninCubit>();

    await _scannerController.stop();

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
    if (mounted && qrSigninCubit.state.status == QrSigninStatus.scanning) {
      await _scannerController.start();
    }
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
