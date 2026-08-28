# 🏦 Android Flavors

## What are Flavors?

**Flavors** allow building multiple versions of an app with different configurations, resources, or features — without
duplicating code. In the context of WebTrit, they are used to conditionally include permissions or components such as
receivers, based on the client’s enabled features. This helps avoid requesting unnecessary permissions.

Currently, WebTrit uses several flavors for:

* **deeplinks** — to enable or disable deep link support
* **smsReceiver** — to enable or disable incoming call triggers via SMS

---

## Flavor Structure

```groovy
productFlavors {
    // Deep link support
    deeplinks {
        dimension "deeplinks"
        resValue "string", "APP_LINK_DOMAIN", dartDefine.WEBTRIT_APP_LINK_DOMAIN
    }
    deeplinksDisabled {
        dimension "deeplinks"
    }

    // Incoming call trigger via SMS
    smsReceiver {
        dimension "smsTriggerIncomingCall"
    }
    smsReceiverDisabled {
        dimension "smsTriggerIncomingCall"
    }
}
```

> ℹ️ Flavors are defined only for **Android**. They are currently not used on iOS, so a workaround is added in the
> Makefile for compatibility. In the future, iOS flavor support should also be implemented.

---

## How Flavors Are Selected

They are automatically determined based on values from `dart_define.json`.

> 🔧 Flavor selection logic is delegated to `makefile.shared`, which is included in the local Makefile.

| Dart Define Field                    | Value           | Applied Flavor        |
|--------------------------------------|-----------------|-----------------------|
| `WEBTRIT_APP_LINK_DOMAIN`            | non-empty       | `deeplinks`           |
|                                      | empty/missing   | `deeplinksDisabled`   |
| `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` | `"true"`        | `smsReceiver`         |
|                                      | `"false"`/other | `smsReceiverDisabled` |

The generated argument will look like:

```sh
--flavor deeplinkssmsReceiverDisabled
```

---

## Special Notes

The build version used for compatibility is stored in `build.config` at the project root. This file is added
specifically for **backward compatibility**.

* For `VERSION < 0.0.1` (legacy), flavors are **not used**
* For `VERSION = 0.0.1`, only the deeplink flavor is used
* For `VERSION ≥ 0.0.2`, both (deeplink + sms) flavors are applied

This ensures compatibility with older builds that don’t support flavors.

---

## Examples

### Build APK with both features enabled:

```sh
melos run build:apk
```

### Run the app on a device with the computed flavors:

```sh
melos run start:android
```

> ⚠️ In development environments (e.g., IntelliJ IDEA), you must manually specify the combined flavor (e.g.,
`deeplinkssmsReceiver`) in your run configuration. The melos scripts resolve it with
`tool/scripts/android_flavor.sh`.
> 📄 For more details on how the build system works, see  [build](build.md)..md.
