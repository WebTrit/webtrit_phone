# Variables
BUILD_TYPE ?= debug
BUILD_PLATFORM ?= apk
BUILD_FLOW ?= classic
DART_DEFINE_FILE = --dart-define-from-file=dart_define.json
CONFIGURATOR = dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart
KEYSTORES_PATH = --keystores-path=../webtrit_phone_keystores

# Paths to configuration files
CONFIGS_PATH = /Users/serdun/Documents/work/webtrit/webtrit_phone/tool/configs
FLUTTER_LAUNCHER_ICONS_CONFIG = $(CONFIGS_PATH)/flutter_launcher_icons.yaml
FLUTTER_NATIVE_SPLASH_CONFIG = $(CONFIGS_PATH)/flutter_native_splash.yaml

# Variables for package rename
PACKAGE_NAME ?= com.example.newapp
BUNDLE_ID ?= com.example.newapp
ANDROID_APP_NAME ?= "New App"
IOS_APP_NAME ?= "New App"

# Determine Flutter flags based on build type
ifeq ($(BUILD_TYPE), release)
    FLUTTER_FLAGS = $(DART_DEFINE_FILE) --release  --no-tree-shake-icons
else
    FLUTTER_FLAGS = $(DART_DEFINE_FILE)  --no-tree-shake-icons
endif

# Rules
.PHONY: run build configure configure-clean configure-demo configure-classic build-ios build-apk build-appbundle clean-git generate-package-config rename-package generate-launcher-icons generate-native-splash generate-assets

## Run the Flutter application
run:
	flutter run $(FLUTTER_FLAGS)

## Build the Flutter application
build:
	flutter build $(BUILD_PLATFORM) $(FLUTTER_FLAGS)

## Configure application resources
configure:
	$(CONFIGURATOR) configurator-resources --applicationId=$(id) $(KEYSTORES_PATH) --token=$(token) --$(BUILD_FLOW)
	$(CONFIGURATOR) configurator-generate

## Create demo configuration
configure-demo:
	$(CONFIGURATOR) configurator-resources --applicationId=$(id) $(KEYSTORES_PATH) --token=$(token) --demo
	$(CONFIGURATOR) configurator-generate

## Create classic configuration
configure-classic:
	$(CONFIGURATOR) configurator-resources --applicationId=$(id) $(KEYSTORES_PATH) --token=$(token) --classic
	$(CONFIGURATOR) configurator-generate

## Create iOS build
build-ios:
	flutter build ios $(FLUTTER_FLAGS)

## Create APK build
build-apk:
	flutter build apk $(FLUTTER_FLAGS)

## Create App Bundle build
build-appbundle:
	flutter build appbundle $(FLUTTER_FLAGS)

## Generate package_rename_config.yaml for package_rename
generate-package-config:
	echo "package_rename_config:" > package_rename_config.yaml
	echo "  android:" >> package_rename_config.yaml
	echo "    app_name: $(ANDROID_APP_NAME)" >> package_rename_config.yaml
	echo "    package_name: $(PACKAGE_NAME)" >> package_rename_config.yaml
	echo "    override_old_package: com.webtrit.app" >> package_rename_config.yaml
	echo "    lang: kotlin" >> package_rename_config.yaml
	echo "  ios:" >> package_rename_config.yaml
	echo "    app_name: $(IOS_APP_NAME)" >> package_rename_config.yaml
	echo "    package_name: $(BUNDLE_ID)" >> package_rename_config.yaml

## Add package_rename to dev_dependencies and run it
rename-package: generate-package-config
	dart pub add package_rename --dev
	dart run package_rename

## Generate launcher icons using external config
generate-launcher-icons:
	flutter pub add flutter_launcher_icons --dev
	dart run flutter_launcher_icons  -f $(FLUTTER_LAUNCHER_ICONS_CONFIG)

## Generate native splash screen using external config
generate-native-splash:
	flutter pub add flutter_native_splash --dev
	dart run flutter_native_splash:create --path=$(FLUTTER_NATIVE_SPLASH_CONFIG)

## Generate both launcher icons and splash screen
generate-assets: generate-launcher-icons generate-native-splash

## Clean git files
clean-git:
	git reset --hard HEAD
	git clean -df
