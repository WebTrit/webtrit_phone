# ===========================
# Include Shared Makefile Logic
# ===========================

TOOLS_MAKEFILE := makefile.shared

ifeq (,$(wildcard $(TOOLS_MAKEFILE)))
$(shell curl -sSL https://raw.githubusercontent.com/WebTrit/webtrit_phone_tools/refs/heads/main/Makefile.shared -o $(TOOLS_MAKEFILE))
endif

include $(TOOLS_MAKEFILE)

# Variables
DART_DEFINE_FILE = --dart-define-from-file=dart_define.json
CONFIGURATOR = dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart
KEYSTORES_PATH = --keystores-path=../webtrit_phone_keystores

# ===========================
#  Paths to Configuration Files
# ===========================

# Base directory for storing configuration files
CONFIGS_PATH = $(CURDIR)/tool/configs


# ===========================
#  Package Rename Configuration
# ===========================

# Documentation: https://github.com/OutdatedGuy/package_rename/blob/main/README.md
# Path to package rename configuration file
FLUTTER_RENAME_PACKAGE_CONFIG = $(CONFIGS_PATH)/package_rename_config.yaml

# Application package details
PACKAGE_NAME ?= com.example.newapp
BUNDLE_ID ?= com.example.newapp

# Application display names
ANDROID_APP_NAME ?= "New App"
IOS_APP_NAME ?= "New App"

# ===========================
#  Launcher Icons Configuration
# ===========================

# Documentation: https://github.com/fluttercommunity/flutter_launcher_icons/blob/master/README.md
# Path to launcher icons configuration file
FLUTTER_LAUNCHER_ICONS_CONFIG = $(CONFIGS_PATH)/flutter_launcher_icons.yaml

# Paths to launcher icon images for different platforms
LAUNCHER_ICON_IMAGE_ANDROID ?= "tool/assets/launcher_icons/android.png"  # Android launcher icon
LAUNCHER_ICON_FOREGROUND ?= "tool/assets/launcher_icons/ic_foreground.png"  # Foreground image for adaptive Android icons
LAUNCHER_ICON_IMAGE_IOS ?= "tool/assets/launcher_icons/ios.png"          # iOS launcher icon
LAUNCHER_ICON_IMAGE_WEB ?= "tool/assets/launcher_icons/web.png"          # Web launcher icon

# Background color for launcher icons (used for Android adaptive icons, iOS background, and Web background)
ICON_BACKGROUND_COLOR ?= "#123752"

# Theme color for web applications (affects browser UI, such as the address bar)
THEME_COLOR ?= "#F3F5F6"

# ===========================
#  Splash Screen Configuration
# ===========================

# Documentation: https://github.com/jonbhanson/flutter_native_splash/blob/master/README.md
# Path to splash screen configuration file
FLUTTER_NATIVE_SPLASH_CONFIG = $(CONFIGS_PATH)/flutter_native_splash.yaml

# Splash screen background settings
#
# - Either `SPLASH_COLOR` or `SPLASH_IMAGE` is required.
# - Use `SPLASH_COLOR` for a solid background color.
# - Use `SPLASH_IMAGE` for a custom background image (useful for gradients).
# - Only one of them should be set at a time.
SPLASH_COLOR ?= "#123752"

# Android 12+ splash screen configuration
#
# - From Android 12 onwards, splash screens are handled differently.
# - Visit: https://developer.android.com/guide/topics/ui/splash-screen
ANDROID_12_SPLASH_COLOR ?= "#123752"

# Path to splash screen background image (if used)
SPLASH_IMAGE ?= "tool/assets/native_splash/image.png"

# ===========================
#  Localizely Configuration
# ===========================

ENV_FILE ?= .env

define ensure_localizely_token
	$(eval localizely_token := $(shell \
		if [ -z "$(localizely_token)" ]; then \
			if [ ! -f "$(ENV_FILE)" ]; then \
				echo "__ERROR_ENV_NOT_FOUND__"; \
			else \
				val=$$(grep '^LOCALIZELY_TOKEN=' $(ENV_FILE) | cut -d '=' -f2); \
				if [ -z "$$val" ]; then echo "__ERROR_TOKEN_EMPTY__"; else echo "$$val"; fi; \
			fi; \
		else echo "$(localizely_token)"; fi \
	)) \
	@if [ "$(localizely_token)" = "__ERROR_ENV_NOT_FOUND__" ]; then \
		echo "Error: Token not provided and $(ENV_FILE) not found."; exit 1; \
	elif [ "$(localizely_token)" = "__ERROR_TOKEN_EMPTY__" ]; then \
		echo "Error: LOCALIZELY_TOKEN is empty in $(ENV_FILE)"; exit 1; \
	fi
endef

# Rules
.PHONY: run build configure configure-demo configure-classic build-ios build-apk build-appbundle clean-git generate-package-config rename-package generate-launcher-icons generate-native-splash generate-assets

## Configure application resources
configure:
	$(CONFIGURATOR) configurator-resources --applicationId=$(id) $(KEYSTORES_PATH) --token=$(token)
	$(CONFIGURATOR) configurator-generate

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
	dart pub add package_rename:1.8.0 --dev
	dart run package_rename --path=$(FLUTTER_RENAME_PACKAGE_CONFIG)

## Generate flutter_launcher_icons.yaml with custom parameters
generate-launcher-icons-config:
	@echo "flutter_launcher_icons:" > $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  android: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  image_path_android: \"$${LAUNCHER_ICON_IMAGE_ANDROID:-$(LAUNCHER_ICON_IMAGE_ANDROID)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  min_sdk_android: 23" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  adaptive_icon_background: \"$${ICON_BACKGROUND_COLOR:-$(ICON_BACKGROUND_COLOR)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  adaptive_icon_foreground: \"$${LAUNCHER_ICON_FOREGROUND:-$(LAUNCHER_ICON_FOREGROUND)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  ios: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  background_color_ios: \"$${ICON_BACKGROUND_COLOR:-$(ICON_BACKGROUND_COLOR)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  remove_alpha_ios: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  image_path_ios: \"$${LAUNCHER_ICON_IMAGE_IOS:-$(LAUNCHER_ICON_IMAGE_IOS)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "  web:" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    generate: true" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    image_path: \"$${LAUNCHER_ICON_IMAGE_WEB:-$(LAUNCHER_ICON_IMAGE_WEB)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
	@echo "    background_color: \"$${ICON_BACKGROUND_COLOR:-$(ICON_BACKGROUND_COLOR)}\"" >> $(FLUTTER_LAUNCHER_ICONS_CONFIG)
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
push-l10n:
	$(call ensure_localizely_token)
	localizely-cli --api-token=$(localizely_token) push

## Pull localization keys from Localizely
pull-l10n:
	$(call ensure_localizely_token)
	localizely-cli --api-token=$(localizely_token) pull

## Generate Flutter localization files
gen-l10n:
	flutter gen-l10n

## Fetch localization keys from Localizely, pull them and generate localization files
fetch-l10n: pull-l10n gen-l10n

## Clean git files
clean-git:
	git reset --hard HEAD
	git clean -df

sync-run-configs:
	mkdir -p .idea/runConfigurations
	cp tool/run/*.xml .idea/runConfigurations/

run-core:
	$(MAKE) -f makefile.shared run
