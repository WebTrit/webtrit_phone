dartDefinesToPdartDefines(){
    json=$(jq . $1)
    jsonKeys=$(echo $json | jq -r 'keys[]')

    comaSeparatedBase64Encoded=""

    for key in $jsonKeys; do
    value=$(echo $json | jq ".\"$key\"" | tr -d '"')
    kv="$key=$value"

    base64Encoded=$(echo $kv | tr -d \\n | base64)
        if [ -z "$comaSeparatedBase64Encoded" ]; then
            comaSeparatedBase64Encoded="$base64Encoded"
        else
            comaSeparatedBase64Encoded="$comaSeparatedBase64Encoded,$base64Encoded"
        fi
    done

    echo $comaSeparatedBase64Encoded
}

# Encode the contents of the JSON files into android specific format e.g [base64(key=value),base64(key=value)]
encodedDefines=$(dartDefinesToPdartDefines ../dart_define.json),$(dartDefinesToPdartDefines dart_define.integration_test.json)

# Assign the first argument as testFile, or use a default value if not provided
targetTest=$(pwd)/integration_test/${1:-just_run_test.dart}
echo "start assemble test: $targetTest"

# Flush flutter the build cache
flutter clean
flutter pub get

pushd android
# run assembling main and test package
./gradlew app:assembleAndroidTest -Pdart-defines="$encodedDefines"
./gradlew app:assembleDebug -Ptarget=$targetTest -Pdart-defines="$encodedDefines"

# run test deployment
keystorePath=$(jq .WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH ../../dart_define.json | tr -d '"')
serviceAccountPath=$keystorePath/google-play-service-account.json
echo "service account path: $serviceAccountPath"
projectId=$(jq .project_id $serviceAccountPath | tr -d '"')
echo "project id: $projectId"
gcloud auth activate-service-account --key-file=$serviceAccountPath
gcloud --quiet config set project $projectId
gcloud firebase test android run --type instrumentation \
  --app ../build/app/outputs/apk/debug/app-debug.apk \
  --test ../build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk\
  --timeout 2m
popd