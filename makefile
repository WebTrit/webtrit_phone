# Variables
BUILD_TYPE ?= debug
BUILD_PLATFORM ?= apk
BUILD_FLOW ?= classic
DART_DEFINE_FILE = --dart-define-from-file=dart_define.json
CONFIGURATOR = dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart
KEYSTORES_PATH = --keystores-path=../webtrit_phone_keystores

# Paths to configuration files
CONFIGS_PATH = $(CURDIR)/tool/configs
FLUTTER_LAUNCHER_ICONS_CONFIG = $(CONFIGS_PATH)/flutter_launcher_icons.yaml
FLUTTER_NATIVE_SPLASH_CONFIG = $(CONFIGS_PATH)/flutter_native_splash.yaml
FLUTTER_RENAME_PACKAGE_CONFIG = $(CONFIGS_PATH)/package_rename_config.yaml

# Variables for package rename
PACKAGE_NAME ?= com.example.newapp
BUNDLE_ID ?= com.example.newapp
ANDROID_APP_NAME ?= "New App"
IOS_APP_NAME ?= "New App"

# Variables for configuration launchers and splash screen
ADAPTIVE_ICON_BACKGROUND ?= "#123752"
BACKGROUND_COLOR ?= "#FFFFFF"
THEME_COLOR ?= "#F3F5F6"
SPLASH_COLOR ?= "#123752"
ANDROID_12_SPLASH_COLOR ?= "#123752"
LAUNCHER_ICON_IMAGE_ANDROID ?= "tool/assets/launcher_icons/android.png"
LAUNCHER_ICON_IMAGE_IOS ?= "tool/assets/launcher_icons/ios.png"
LAUNCHER_ICON_IMAGE_WEB ?= "tool/assets/launcher_icons/web.png"
LAUNCHER_ICON_FOREGROUND ?= "tool/assets/launcher_icons/ic_foreground.png"
SPLASH_IMAGE ?= "tool/assets/native_splash/image.png"

# Determine Flutter flags based on build type
ifeq ($(BUILD_TYPE), release)
    FLUTTER_FLAGS = $(DART_DEFINE_FILE) --release  --no-tree-shake-icons
else
    FLUTTER_FLAGS = $(DART_DEFINE_FILE)  --no-tree-shake-icons
endif

# Rules
.PHONY: run build configure configure-demo configure-classic build-ios build-apk build-appbundle clean-git generate-package-config rename-package generate-launcher-icons generate-native-splash generate-assets

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
	@echo "package_rename_config:" > $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "  android:" >>$(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "    app_name: $(ANDROID_APP_NAME)" >> $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "    package_name: $(PACKAGE_NAME)" >> $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "    override_old_package: com.webtrit.app" >> $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "    lang: kotlin" >> $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "  ios:" >> $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "    app_name: $(IOS_APP_NAME)" >> $(FLUTTER_RENAME_PACKAGE_CONFIG)
	@echo "    package_name: $(BUNDLE_ID)" >>$(FLUTTER_RENAME_PACKAGE_CONFIG)

## Add package_rename to dev_dependencies and run it
rename-package:
	dart pub add package_rename --dev
	dart run package_rename --path=$(FLUTTER_RENAME_PACKAGE_CONFIG)


## Generate flutter_launcher_icons.yaml with custom parameters
generate-launcher-icons-config:
	@echo "flutter_launcher_icons:" > $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  android: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  image_path_android: \"$${LAUNCHER_ICON_IMAGE_ANDROID:-$(LAUNCHER_ICON_IMAGE_ANDROID)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  min_sdk_android: 23" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  adaptive_icon_background: \"$${ADAPTIVE_ICON_BACKGROUND:-$(ADAPTIVE_ICON_BACKGROUND)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  adaptive_icon_foreground: \"$${LAUNCHER_ICON_FOREGROUND:-$(LAUNCHER_ICON_FOREGROUND)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  ios: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  image_path_ios: \"$${LAUNCHER_ICON_IMAGE_IOS:-$(LAUNCHER_ICON_IMAGE_IOS)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  web:" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    generate: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    image_path: \"$${LAUNCHER_ICON_IMAGE_WEB:-$(LAUNCHER_ICON_IMAGE_WEB)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    background_color: \"$${BACKGROUND_COLOR:-$(BACKGROUND_COLOR)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    theme_color: \"$${THEME_COLOR:-$(THEME_COLOR)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)

## Generate launcher icons using external config
generate-launcher-icons:
	flutter pub add flutter_launcher_icons --dev
	dart run flutter_launcher_icons  -f $(FLUTTER_LAUNCHER_ICONS_CONFIG)

## Generate flutter_native_splash.yaml with custom parameters
generate-native-splash-config:
	@echo "flutter_native_splash:" > $(FLUTTER_NATIVE_SPLASH_CONFIG)
	@echo "  color: \"$${SPLASH_COLOR:-$(SPLASH_COLOR)}\"" >> $(FLUTTER_NATIVE_SPLASH_CONFIG)
	@echo "  image: \"$${SPLASH_IMAGE:-$(SPLASH_IMAGE)}\"" >> $(FLUTTER_NATIVE_SPLASH_CONFIG)
	@echo "  android_12:" >> $(FLUTTER_NATIVE_SPLASH_CONFIG)
	@echo "    color: \"$${ANDROID_12_SPLASH_COLOR:-$(ANDROID_12_SPLASH_COLOR)}\"" >> $(FLUTTER_NATIVE_SPLASH_CONFIG)

## Generate native splash screen using external config
generate-native-splash:
	flutter pub add flutter_native_splash --dev
	dart run flutter_native_splash:create --path=$(FLUTTER_NATIVE_SPLASH_CONFIG)

## Generate both launcher icons and splash screen
generate-assets: generate-launcher-icons generate-native-splash

## Push localization keys to Localizely
push-localizations:
	localizely-cli --api-token=$(token) push

## Pull localization keys from Localizely
pull-localizations:
	localizely-cli --api-token=$(token) pull

## Generate Flutter localization files
generate-localizations:
	flutter gen-l10n

## Full localization workflow (Push, Pull, Generate)
localization-workflow: push-localizations pull-localizations generate-localizations

## Clean git files
clean-git:
	git reset --hard HEAD
	git clean -df
