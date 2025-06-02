# Make commands

## Table of Contents
- [Make commands](#make-commands)
- [Variables](#variables)
- [Rules](#rules)

# Make commands

* `run` - Run the Flutter application
  ```bash
  make run
  ```

* `build` - Build the Flutter application
  ```bash
  make build
  ```

* `configure` - Configure application resources
  ```bash
  make configure id=<application_id>
  ```

* `configure-demo` - Create demo configuration
  ```bash
  make configure-demo id=<application_id>
  ```

* `configure-classic` - Create demo configuration
  ```bash
  make configure-classic id=<application_id>
  ```

* `build-ios` - Create iOS build
  ```bash
  make build-ios
  ```

* `build-apk` - Create APK build
  ```bash
  make build-apk
  ```

* `build-appbundle` - Create App Bundle build
  ```bash
  make build-appbundle
  ```

* `clean-git` - Clean git files
  ```bash
  make clean-git
  ```

# Variables
BUILD_TYPE ?= debug
BUILD_PLATFORM ?= apk
BUILD_FLOW ?= classic
DART_DEFINE_FILE = --dart-define-from-file=dart_define.json
CONFIGURATOR = dart run ../webtrit_phone_tools/bin/webtrit_phone_tools.dart
KEYSTORES_PATH = --keystores-path=../webtrit_phone_keystores

# Determine Flutter flags based on build type
ifeq ($(BUILD_TYPE), release)
    FLUTTER_FLAGS = $(DART_DEFINE_FILE) --release  --no-tree-shake-icons
else
    FLUTTER_FLAGS = $(DART_DEFINE_FILE)  --no-tree-shake-icons
endif

# Rules
.PHONY: run build configure configure-clean create-demo-classic create-ios create-apk create-appbundle

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

## Clean git files
clean-git:
	git reset --hard HEAD
	git clean -df
