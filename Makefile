run:
	flutter run --dart-define-from-file=dart_define.json --debug

run-release:
	flutter run --dart-define-from-file=dart_define.json --release

build-ios:
	flutter build ios --dart-define-from-file=dart_define.json

build-apk:
	flutter build apk --dart-define-from-file=dart_define.json --release

build-appbundle:
	flutter build appbundle --dart-define-from-file=dart_define.json --release
