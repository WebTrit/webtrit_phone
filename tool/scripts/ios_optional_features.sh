#!/bin/sh
# Applies the optional iOS features to the Xcode project, from dart_define.json.
#
# The counterpart of the optional manifest fragments on Android, and it exists
# for the same reason: a capability a brand does not use must be absent from
# what ships, not merely switched off. An entitlement the app declares forces
# every provisioning profile to carry the matching capability, so leaving it in
# turns an unused feature into a build that cannot be signed:
#
#   Provisioning profile ... doesn't include the Associated Domains capability
#
# One feature is optional in that sense today:
#
#   deep links - com.apple.developer.associated-domains, kept only when
#                WEBTRIT_APP_LINK_DOMAIN names a domain
#
# The switch is the same key the Dart code and android/app/build.gradle read,
# so one file decides the feature on both platforms.
#
# Not ios/Flutter/Environment.xcconfig, deliberately: it is gitignored and
# written by the Xcode scheme's pre-action at archive time, so it does not
# exist yet here and would fall back to the hard-coded default domain.
#
# Nothing installed: `plutil` reads JSON as happily as it reads a plist, and
# `PlistBuddy` edits the entitlements. That is the point of it living here
# rather than in a pipeline that had to install a gem to do the same edit.
#
# PlistBuddy for the plist, not plutil: plutil reads a key path separated by
# dots, and every entitlement key is full of them - it looked for
# `com` -> `apple` -> `developer` and reported the entitlement absent while it
# was sitting there.

set -eu

DART_DEFINE=${1:-dart_define.json}
ENTITLEMENTS=ios/Runner/Runner.entitlements
ASSOCIATED_DOMAINS=com.apple.developer.associated-domains

if [ ! -f "$DART_DEFINE" ]; then
  echo "No ${DART_DEFINE} in $(pwd) - run this after the configuration step that writes it." >&2
  exit 1
fi

# Absent and empty mean the same thing here: no domain, no deep links.
domain=$(plutil -extract WEBTRIT_APP_LINK_DOMAIN raw -o - "$DART_DEFINE" 2>/dev/null || true)
domain=$(printf '%s' "$domain" | tr -d '[:space:]')

if [ -n "$domain" ]; then
  echo "Deep links: enabled (${domain}) - keeping ${ASSOCIATED_DOMAINS}"
  exit 0
fi

if [ ! -f "$ENTITLEMENTS" ]; then
  echo "Deep links: disabled - no ${ENTITLEMENTS} to strip"
  exit 0
fi

PLIST_BUDDY=/usr/libexec/PlistBuddy

if "$PLIST_BUDDY" -c "Print :${ASSOCIATED_DOMAINS}" "$ENTITLEMENTS" >/dev/null 2>&1; then
  "$PLIST_BUDDY" -c "Delete :${ASSOCIATED_DOMAINS}" "$ENTITLEMENTS"
  echo "Deep links: disabled - removed ${ASSOCIATED_DOMAINS} from ${ENTITLEMENTS}"
else
  echo "Deep links: disabled - ${ASSOCIATED_DOMAINS} already absent"
fi
