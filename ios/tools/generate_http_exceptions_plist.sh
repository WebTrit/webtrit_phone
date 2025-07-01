#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# This script extracts a specific DART_DEFINE key (e.g., WEBTRIT_HTTP_ALLOWED_DOMAINS)
# from either the environment or the generated xcconfig file, decodes its Base64 value(s),
# and updates Info.plist with HTTP exception domains for App Transport Security (ATS).
#
# This is required when allowing HTTP (non-HTTPS) traffic to specific domains
# in iOS builds (e.g., for local testing or development environments).
# -----------------------------------------------------------------------------

DEFINE_KEY="WEBTRIT_HTTP_ALLOWED_DOMAINS"
PLIST="${PROJECT_DIR}/Runner/Info.plist"

#  Attempt to read DART_DEFINES from environment, or fallback to Generated.xcconfig
if [[ -z "$DART_DEFINES" ]]; then
  CONFIG_FILE="${PROJECT_DIR}/Flutter/Generated.xcconfig"
  if [[ -f "$CONFIG_FILE" ]]; then
    DART_DEFINES=$(grep -o 'DART_DEFINES=.*' "$CONFIG_FILE" | cut -d '=' -f2-)
  fi
fi

if [[ -z "$DART_DEFINES" ]]; then
  echo "️  DART_DEFINES not found in env or config file. Skipping domain injection."
  exit 0
fi

#  Decode each base64 entry individually and look for the target key
IFS=',' read -ra DEFINES_ARR <<< "$DART_DEFINES"

DOMAINS=""
for encoded in "${DEFINES_ARR[@]}"; do
  decoded=$(echo "$encoded" | base64 --decode 2>/dev/null || true)
  if [[ "$decoded" == "$DEFINE_KEY="* ]]; then
    DOMAINS="${decoded#*=}"
    break
  fi
done

if [[ -z "$DOMAINS" ]]; then
  echo "⚠️  No matching value found for key: $DEFINE_KEY"
  exit 0
fi

#  Clean existing NSExceptionDomains section (if any) in Info.plist
/usr/libexec/PlistBuddy -c "Delete :NSAppTransportSecurity:NSExceptionDomains" "$PLIST" || true
/usr/libexec/PlistBuddy -c "Add :NSAppTransportSecurity:NSExceptionDomains dict" "$PLIST"

#  Split multiple domain entries using semicolon separator
# Each entry format: domain,includeSubdomains (e.g., 127.0.0.1,true)
IFS=';' read -ra ENTRIES <<< "$DOMAINS"
for entry in "${ENTRIES[@]}"; do
  domain=$(echo "$entry" | cut -d',' -f1)
  includeSub=$(echo "$entry" | cut -d',' -f2 | tr '[:upper:]' '[:lower:]')

  # Fallback to false if includeSubdomains value is missing or invalid
  [[ "$includeSub" != "true" ]] && includeSub="false"

  echo " Adding HTTP exception for domain: $domain (includeSubdomains=$includeSub)"
  /usr/libexec/PlistBuddy -c "Add :NSAppTransportSecurity:NSExceptionDomains:${domain} dict" "$PLIST"
  /usr/libexec/PlistBuddy -c "Add :NSAppTransportSecurity:NSExceptionDomains:${domain}:NSIncludesSubdomains bool $includeSub" "$PLIST"
  /usr/libexec/PlistBuddy -c "Add :NSAppTransportSecurity:NSExceptionDomains:${domain}:NSTemporaryExceptionAllowsInsecureHTTPLoads bool true" "$PLIST"
done

echo "✅ Info.plist updated with HTTP exceptions from $DEFINE_KEY"
