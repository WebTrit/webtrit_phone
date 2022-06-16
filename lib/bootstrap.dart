import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';

import 'firebase_options.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  final logger = Logger('bootstrap');

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await _initFirebase();
      await _initFirebaseMessaging();
      if (kDebugMode) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
        await FirebaseCrashlytics.instance.deleteUnsentReports();
      }
      FlutterError.onError = (details) {
        logger.severe('FlutterError', details.exception, details.stack);
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      await AppPath.init();
      await DeviceInfo.init();
      await PackageInfo.init();

      await _precacheSvgPicture(); // TODO check this functionality

      return BlocOverrides.runZoned(
        () async => runApp(await builder()),
        blocObserver: _AppBlocObserver(),
      );
    },
    (error, stackTrace) {
      logger.severe('runZonedGuarded', error, stackTrace);
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

Future<void> _precacheSvgPicture() async {
  final assetManifestJson = await rootBundle.loadString('AssetManifest.json');
  final assetManifest = jsonDecode(assetManifestJson) as Map<String, dynamic>;
  await Future.wait(assetManifest.keys.where((String key) => key.endsWith('.svg')).map(
        (assetName) => precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, assetName),
          null,
        ),
      ));
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _initFirebaseMessaging() async {
  final logger = Logger('FirebaseMessaging');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.info('onMessage: ${message.toMap()}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.info('onMessageOpenedApp: ${message.toMap()}');
  });
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    logger.info('initialMessage: ${initialMessage.toMap()}');
  }

  final notificationSettings = await FirebaseMessaging.instance.requestPermission();
  if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
    logger.info('User granted permission');
  } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
    logger.info('User granted provisional permission');
  } else {
    logger.info('User declined or has not accepted permission');
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final logger = Logger('main');

  await Firebase.initializeApp();

  logger.info('onBackgroundMessage: ${message.toMap()}');
}

class _AppBlocObserver extends BlocObserver {
  final Logger _logger = Logger('BlocObserver');

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.fine('onCreate $bloc');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.fine('onEvent $bloc: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.fine('onChange $bloc: $change');
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.fine('onTransition $bloc: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.warning('onError $bloc', error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.fine('onClose $bloc');
  }
}
