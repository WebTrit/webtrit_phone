import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

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
                if (loginState.processing) return const _VerifyingView();

                return switch (state.status) {
                  QrSigninStatus.checkingPermission => const SizedBox.shrink(),
                  QrSigninStatus.permissionRequired => const _PermissionRequiredView(),
                  QrSigninStatus.scanning => _ScannerView(
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

class _ScannerView extends StatelessWidget {
  const _ScannerView({required this.controller, required this.onDetect, this.parseError});

  final MobileScannerController controller;
  final ValueChanged<BarcodeCapture> onDetect;
  final QrSigninParseError? parseError;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.l10n.login_qrSignin_scanHint, textAlign: TextAlign.center, style: themeData.textTheme.bodyLarge),
        const SizedBox(height: kInset),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 320),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kInset),
                child: MobileScanner(controller: controller, onDetect: onDetect),
              ),
            ),
          ),
        ),
        const SizedBox(height: kInset / 2),
        // Reserve the line so the layout does not jump when an error appears.
        Text(
          parseError != null ? context.l10n.login_qrSignin_invalidCodeError : '',
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.colorScheme.error),
        ),
      ],
    );
  }
}

class _VerifyingView extends StatelessWidget {
  const _VerifyingView();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: kInset),
        Text(
          context.l10n.login_qrSignin_verifyingTitle,
          textAlign: TextAlign.center,
          style: themeData.textTheme.titleLarge,
        ),
        const SizedBox(height: kInset / 2),
        Text(
          context.l10n.login_qrSignin_verifyingText,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _PermissionRequiredView extends StatelessWidget {
  const _PermissionRequiredView();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: themeData.colorScheme.surfaceContainerHighest,
            child: Icon(Icons.no_photography_outlined, size: 36, color: themeData.colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: kInset),
        Text(
          context.l10n.login_qrSignin_cameraPermissionTitle,
          textAlign: TextAlign.center,
          style: themeData.textTheme.titleLarge,
        ),
        const SizedBox(height: kInset / 2),
        Text(
          context.l10n.login_qrSignin_cameraPermissionText,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium,
        ),
        const SizedBox(height: kInset),
        ElevatedButton(
          onPressed: context.read<QrSigninCubit>().requestPermission,
          child: Text(context.l10n.login_qrSignin_allowCameraAccessButton),
        ),
        TextButton(
          onPressed: context.read<QrSigninCubit>().openAppSettings,
          child: Text(context.l10n.login_qrSignin_openSettingsButton),
        ),
      ],
    );
  }
}
