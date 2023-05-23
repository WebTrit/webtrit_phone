import 'package:path_provider/path_provider.dart';

Future<String> getApplicationDocumentsPath() => getApplicationDocumentsDirectory().then((value) => value.path);

Future<String> getApplicationSupportPath() => getApplicationSupportDirectory().then((value) => value.path);

Future<String?> getDownloadsPath() => getDownloadsDirectory().then((value) => value?.path);

Future<String> getLibraryPath() => getLibraryDirectory().then((value) => value.path);

Future<String> getTemporaryPath() => getTemporaryDirectory().then((value) => value.path);
