import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/models/models.dart';

import '../mocks/feature_access_mocks.dart';

WebtritSystemInfo createMockSystemInfo() {
  final systemInfo = MockWebtritSystemInfo();
  final adapterInfo = MockAdapterInfo();
  final coreInfo = CoreInfo(version: Version(0, 1, 0));

  when(() => adapterInfo.supported).thenReturn([]);
  when(() => systemInfo.adapter).thenReturn(adapterInfo);
  when(() => systemInfo.core).thenReturn(coreInfo);

  return systemInfo;
}

EmbeddedResource createMockTermsResource() {
  final resource = MockEmbeddedResource();
  final toolbar = MockToolbarConfig();

  when(() => toolbar.titleL10n).thenReturn('Terms');

  when(() => resource.id).thenReturn('terms_id');
  when(() => resource.type).thenReturn(EmbeddedResourceType.terms);
  when(() => resource.uriOrNull).thenReturn(Uri.parse('https://example.com/terms'));
  when(() => resource.uri).thenReturn('https://example.com/terms');
  when(() => resource.reconnectStrategy).thenReturn(null);
  when(() => resource.toolbar).thenReturn(toolbar);
  when(() => resource.payload).thenReturn([]);
  when(() => resource.attributes).thenReturn({});
  when(() => resource.enableConsoleLogCapture).thenReturn(false);

  return resource;
}

AppConfig createMockAppConfig() {
  final appConfig = MockAppConfig();
  final login = MockAppConfigLogin();
  final loginModeSelect = MockAppConfigLoginModeSelect();
  final main = MockAppConfigMain();
  final bottomMenu = MockAppConfigBottomMenu();
  final settings = MockAppConfigSettings();
  final call = MockAppConfigCall();
  final transfer = MockAppConfigTransfer();
  final encoding = MockAppConfigEncoding();
  final preset = MockEncodingDefaultPresetOverride();
  final peerConnection = MockAppConfigPeerConnection();
  final negotiation = MockAppConfigNegotiation();
  final contacts = MockAppConfigContacts();
  final contactDetails = MockAppConfigContactDetails();
  final contactActions = MockAppConfigContactDetailsActions();
  final messaging = MockAppConfigMessaging();
  final chats = MockAppConfigChats();
  final contactInfo = MockChatContactInfo();

  when(() => login.modeSelect).thenReturn(loginModeSelect);
  when(() => loginModeSelect.actions).thenReturn([]);
  when(() => login.common).thenReturn(const AppConfigLoginCommon());

  when(() => main.bottomMenu).thenReturn(bottomMenu);
  when(() => bottomMenu.tabs).thenReturn([BottomMenuTabScheme.keypad(titleL10n: 'Keypad', icon: '0xe1ce')]);
  // TODO: Migrate client configurations first before fully removing this property.
  // ignore: deprecated_member_use_from_same_package, deprecated_member_use
  when(() => main.systemNotificationsEnabled).thenReturn(false);

  when(() => settings.sections).thenReturn([]);

  when(() => call.videoEnabled).thenReturn(true);
  when(() => call.transfer).thenReturn(transfer);
  when(() => transfer.enableBlindTransfer).thenReturn(true);
  when(() => transfer.enableAttendedTransfer).thenReturn(true);
  when(() => call.encoding).thenReturn(encoding);
  when(() => encoding.defaultPresetOverride).thenReturn(preset);
  when(() => encoding.bypassConfig).thenReturn(false);
  when(() => call.peerConnection).thenReturn(peerConnection);
  when(() => peerConnection.negotiation).thenReturn(negotiation);
  when(() => negotiation.includeInactiveVideoInOfferAnswer).thenReturn(false);

  when(() => contacts.details).thenReturn(contactDetails);
  when(() => contactDetails.actions).thenReturn(contactActions);
  when(() => contactActions.appBar).thenReturn(null);
  when(() => contactActions.phoneTile).thenReturn(null);
  when(() => contactActions.emailTile).thenReturn(null);

  when(() => messaging.chats).thenReturn(chats);
  when(() => chats.groupChatButtonEnabled).thenReturn(false);
  when(() => chats.contactInfo).thenReturn(contactInfo);
  when(() => contactInfo.showVideoButtonAction).thenReturn(false);

  when(() => appConfig.loginConfig).thenReturn(login);
  when(() => appConfig.mainConfig).thenReturn(main);
  when(() => appConfig.settingsConfig).thenReturn(settings);
  when(() => appConfig.callConfig).thenReturn(call);
  when(() => appConfig.contacts).thenReturn(contacts);
  when(() => appConfig.messaging).thenReturn(messaging);
  when(() => appConfig.supported).thenReturn([]);

  return appConfig;
}
