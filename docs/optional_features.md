# Optional Android Features

How the Android features whose permission must not ship unused are chosen at build time.

Last reviewed: 2026-09-02

Some features must not merely stay switched off for a brand that does not use them - their Android
permission and their manifest components must be **absent from the shipped app**. A permission the
app never uses is still shown to the user, still has to be declared in the store listing, and in the
case of SMS still has to be justified to Google. So the decision has to be made at build time.

Today two features are optional in that sense:

* **deep links** - the App Links intent filter on the main activity
* **SMS call trigger** - the `RECEIVE_SMS` permission and the broadcast receiver that turns a
  specially formatted SMS into an incoming call

---

## How it works

Each optional feature owns one manifest fragment under `android/app/optional-manifests/`:

```
android/app/optional-manifests/
  deeplinks/AndroidManifest.xml
  sms-receiver/AndroidManifest.xml
```

`android/app/build.gradle` reads the switches out of the dart-defines the build already carries and
adds the matching fragment to the manifest sources of every variant:

```groovy
androidComponents {
    onVariants(selector().all()) { variant ->
        optionalManifests.each { manifest ->
            variant.sources.manifests.addStaticManifestFile(manifest)
        }
    }
}
```

A fragment that is not added takes no part in the merge, so nothing it declares reaches the built
APK or AAB.

| Dart define                          | Value           | Effect                                          |
|--------------------------------------|-----------------|-------------------------------------------------|
| `WEBTRIT_APP_LINK_DOMAIN`            | non-empty       | deep-link intent filter is merged in            |
|                                      | empty/missing   | no intent filter, no `APP_LINK_DOMAIN` resource  |
| `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` | `"true"`        | `RECEIVE_SMS` and the receiver are merged in    |
|                                      | `"false"`/other | neither is declared                             |

The switches come from the same `dart_define.json` the Dart code reads, so one file decides a
feature both in the app and in the manifest. Every build prints what it resolved:

```
Deep links: enabled, SMS call trigger: disabled
```

---

## Building

Nothing extra to pass - there are no build flavors and no flavor name to type:

```bash
melos run build:apk
melos run build:appbundle
melos run start:android
```

The same holds for IDE run configurations (`melos run ide:sync`) and for a hand-typed
`flutter build` - the features follow `dart_define.json`.

> Only Android has manifest-level optional features. iOS declares its capabilities in the Xcode
> project and needs nothing here.

---

## Verifying

The switches are worth checking on the artifact rather than the source.

The merged manifest is produced by a single Gradle task, far cheaper than a full build. It wants
the dart-defines in the form Flutter passes them - a comma-separated list of base64-encoded
`KEY=VALUE` pairs. Note that a missing or malformed value does not fail the task: it succeeds with
both features off, which reads exactly like a fragment that refused to merge.

```bash
cd android
defines="$(printf '%s' 'WEBTRIT_APP_LINK_DOMAIN=app.webtrit.com' | base64 | tr -d '\n'),$(printf '%s' 'WEBTRIT_CALL_TRIGGER_MECHANISM_SMS=true' | base64 | tr -d '\n')"
./gradlew :app:processReleaseManifest -Pdart-defines="$defines"
cat ../build/app/intermediates/merged_manifests/release/processReleaseManifest/AndroidManifest.xml
```

For a finished bundle, read its own manifest. `aapt2 dump badging` takes an apk and rejects an
`.aab`, and the bundle stores the manifest as protobuf, so either unpack it or use bundletool:

```bash
unzip -p build/app/outputs/bundle/release/app-release.aab base/manifest/AndroidManifest.xml \
  | strings | grep -E 'RECEIVE_SMS|IncomingCallSmsTriggerReceiver|flutter_deeplinking_enabled'
```

---

## History

Until 2026-09 these two features were Android product flavors (`deeplinks` x `smsReceiver`), which
made a build pick one of four combined names such as `deeplinkssmsReceiverDisabled`. Two boolean
switches modelled as flavor dimensions multiply: a third one would have meant eight combinations,
and the name had to be computed and passed by every caller - a script in this repo, a shared
makefile, fastlane, and four IDE run configurations, each able to disagree with `dart_define.json`
in silence. The manifest fragments and the merge that consumes them are unchanged; only the
selection moved from a flavor name to the dart-define the feature already had.
