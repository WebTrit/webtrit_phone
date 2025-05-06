flutter clean

testfile=$1
if [ -z "$testfile" ]; then
    echo "No test file provided, building all tests."
    patrol build android --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json
else
    echo "Building target test file: $testfile"
    patrol build android -t integration_test/$testfile --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json
fi

keystorePath=$(jq .WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH android/../../dart_define.json | tr -d '"')
serviceAccountPath=android/$keystorePath/google-play-service-account.json
echo "service account path: $serviceAccountPath"
projectId=$(jq .project_id $serviceAccountPath | tr -d '"')
echo "project id: $projectId"
gcloud auth activate-service-account --key-file=$serviceAccountPath
gcloud --quiet config set project $projectId
gcloud firebase test android run \
    --type instrumentation \
    --use-orchestrator \
    --app build/app/outputs/apk/debug/app-debug.apk \
    --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
    --timeout 10m \
    --record-video \
    --environment-variables clearPackageData=true
