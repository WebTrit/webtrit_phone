#!/bin/sh
# Prints the combined Android flavor name resolved from dart_define.json.
# Keep the rule in sync with compute-flavor-arg in makefile.shared:
#   WEBTRIT_APP_LINK_DOMAIN non-empty            -> deeplinks   else deeplinksDisabled
#   WEBTRIT_CALL_TRIGGER_MECHANISM_SMS == "true" -> smsReceiver else smsReceiverDisabled
#
# Usage: flutter build apk --flavor "$(tool/scripts/android_flavor.sh)" ...
set -eu

DART_DEFINE_PATH="${1:-dart_define.json}"

link_domain="$(jq -r '.WEBTRIT_APP_LINK_DOMAIN // ""' "$DART_DEFINE_PATH")"
sms_trigger="$(jq -r '.WEBTRIT_CALL_TRIGGER_MECHANISM_SMS // "false"' "$DART_DEFINE_PATH")"

if [ -n "$link_domain" ]; then
  deeplink_flavor="deeplinks"
else
  deeplink_flavor="deeplinksDisabled"
fi

if [ "$sms_trigger" = "true" ]; then
  sms_flavor="smsReceiver"
else
  sms_flavor="smsReceiverDisabled"
fi

printf '%s%s\n' "$deeplink_flavor" "$sms_flavor"
