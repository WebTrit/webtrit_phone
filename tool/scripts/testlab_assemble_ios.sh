flutter clean

testfile=$1
if [ -z "$testfile" ]; then
    echo "No test file provided, building all tests."
    patrol build ios --release --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json
else
    echo "Building target test file: $testfile"
    patrol build ios --release -t integration_test/$testfile --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json
fi


pushd build/ios_integ/Build/Products
find . -name "Runner_*.xctestrun" -exec zip -r --must-match "ios_tests.zip" "Release-iphoneos" {} +
popd

keystorePath=$(jq .WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH android/../../dart_define.json | tr -d '"')
serviceAccountPath=android/$keystorePath/google-play-service-account.json
echo "service account path: $serviceAccountPath"
projectId=$(jq .project_id $serviceAccountPath | tr -d '"')
echo "project id: $projectId"
gcloud auth activate-service-account --key-file=$serviceAccountPath
gcloud --quiet config set project $projectId
gcloud firebase test ios run \
  --test "build/ios_integ/Build/Products/ios_tests.zip" \
  --device model=iphone13pro,version=16.6,locale=en_US,orientation=portrait \
  --timeout 5m