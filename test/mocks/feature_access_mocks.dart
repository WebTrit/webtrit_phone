import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/theme/theme.dart';

class MockAppThemes extends Mock implements AppThemes {}

class MockSystemInfoRepository extends Mock implements SystemInfoRepository {}

class MockRemoteConfigService extends Mock implements RemoteConfigService {}

class MockRemoteConfigSnapshot extends Mock implements RemoteConfigSnapshot {}

class MockWebtritSystemInfo extends Mock implements WebtritSystemInfo {}

class MockAdapterInfo extends Mock implements AdapterInfo {}

class MockEmbeddedResource extends Mock implements EmbeddedResource {}

class MockToolbarConfig extends Mock implements ToolbarConfig {}

class MockAppConfig extends Mock implements AppConfig {}

class MockAppConfigLogin extends Mock implements AppConfigLogin {}

class MockAppConfigMain extends Mock implements AppConfigMain {}

class MockAppConfigBottomMenu extends Mock implements AppConfigBottomMenu {}

class MockAppConfigSettings extends Mock implements AppConfigSettings {}

class MockAppConfigCall extends Mock implements AppConfigCall {}

class MockAppConfigTransfer extends Mock implements AppConfigTransfer {}

class MockAppConfigEncoding extends Mock implements AppConfigEncoding {}

class MockAppConfigPeerConnection extends Mock implements AppConfigPeerConnection {}

class MockAppConfigNegotiation extends Mock implements AppConfigNegotiationSettingsOverride {}

class MockAppConfigContacts extends Mock implements AppConfigContacts {}

class MockAppConfigContactDetails extends Mock implements AppConfigContactDetails {}

class MockAppConfigContactDetailsActions extends Mock implements AppConfigContactDetailsActions {}

class MockAppConfigMessaging extends Mock implements AppConfigMessaging {}

class MockAppConfigChats extends Mock implements AppConfigChats {}

class MockChatContactInfo extends Mock implements ChatContactInfo {}

class MockAppConfigLoginModeSelect extends Mock implements AppConfigLoginModeSelect {}

class MockEncodingDefaultPresetOverride extends Mock implements EncodingDefaultPresetOverride {}
