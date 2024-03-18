run:
	flutter run --dart-define-from-file=dart_define.json

run-release:
	flutter run --dart-define-from-file=dart_define.json --release

build-ios:
	flutter build ios --dart-define-from-file=dart_define.json

build-apk:
	flutter build apk --dart-define-from-file=dart_define.json --release

build-appbundle:
	flutter build appbundle --dart-define-from-file=dart_define.json --release

configure:
	dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart configurator-resources ../webtrit_phone_keystores --applicationId=$(id)
	dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart configurator-generate

configure-demo:
	dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart configurator-resources ../webtrit_phone_keystores --applicationId=$(id) --demo
	dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart configurator-generate

configure-classic:
	dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart configurator-resources ../webtrit_phone_keystores --applicationId=$(id) --classic
	dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart configurator-generate

configure-ios:
	make configure
	make build-ios

configure-apk:
	make configure
	make build-apk

configure-appbundle:
	make configure
	make build-appbundle

configure-appbundle-demo:
	make configure-demo
	make build-appbundle

configure-clean:
	git reset --hard HEAD
	git clean -df
