// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get account_selfCarePasswordExpired_message =>
      'รหัสผ่าน self-care ของคุณหมดอายุแล้ว กรุณาอัปเดตผ่าน self-care ของคุณ\nจนกว่าจะเปลี่ยนรหัสผ่าน การเข้าถึงบริการจะถูกจำกัด';

  @override
  String agoTicker_daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days วันที่แล้ว',
      one: '$days วันที่แล้ว',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String agoTicker_hoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ชั่วโมงที่แล้ว',
      one: '$hours ชั่วโมงที่แล้ว',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String agoTicker_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes นาทีที่แล้ว',
      one: '$minutes นาทีที่แล้ว',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String agoTicker_secondsAgo(num seconds) {
    final intl.NumberFormat secondsNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String secondsString = secondsNumberFormat.format(seconds);

    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$secondsString วินาทีที่แล้ว',
      one: '$secondsString วินาทีที่แล้ว',
      zero: 'เมื่อสักครู่',
    );
    return '$_temp0';
  }

  @override
  String get alertDialogActions_no => 'ไม่';

  @override
  String get alertDialogActions_ok => 'ตกลง';

  @override
  String get alertDialogActions_yes => 'ใช่';

  @override
  String get autoprovision_errorSnackBar_invalidToken =>
      'ข้อมูลรับรองการตั้งค่าอัตโนมัติถูกปฏิเสธโดยเซิร์ฟเวอร์ โปรดขอลิงก์การตั้งค่าใหม่';

  @override
  String get autoprovision_ReloginDialog_confirm => 'ยืนยัน';

  @override
  String get autoprovision_ReloginDialog_decline => 'ปฏิเสธ';

  @override
  String get autoprovision_ReloginDialog_text =>
      'คุณต้องการใช้ข้อมูลรับรองการยืนยันตัวตนใหม่ที่ให้มาในลิงก์หรือไม่? คุณจะถูกออกจากระบบของเซสชันปัจจุบัน';

  @override
  String get autoprovision_ReloginDialog_title => 'ยืนยันการเข้าสู่ระบบใหม่';

  @override
  String get autoprovision_successSnackBar_used => 'ดึงการตั้งค่าของคุณสำเร็จแล้ว แอปพร้อมใช้งาน';

  @override
  String get callTileActions_contact => 'รายชื่อติดต่อ';

  @override
  String get callTileActions_history => 'ประวัติ';

  @override
  String get callTileActions_message => 'ข้อความ';

  @override
  String get cacheManagement_Button_clear => 'ล้าง';

  @override
  String get cacheManagement_Label_empty => 'ไม่มีข้อมูลในแคชบนอุปกรณ์นี้';

  @override
  String cacheManagement_Label_itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count รายการ');
    return '$_temp0';
  }

  @override
  String get cacheManagement_Label_unknown => 'ไม่ทราบ';

  @override
  String get cacheManagement_Widget_screenTitle => 'พื้นที่เก็บข้อมูลและแคช';

  @override
  String get callTileActions_more => 'เพิ่มเติม';

  @override
  String get call_CallActionsTooltip_accept => 'รับสาย';

  @override
  String get call_CallActionsTooltip_accept_inviteToAttendedTransfer => 'รับการโอนสาย';

  @override
  String get call_CallActionsTooltip_attended_transfer => 'โอนสายแบบรอรับ';

  @override
  String get call_CallActionsTooltip_changeAudioDevice => 'เปลี่ยนอุปกรณ์เสียง';

  @override
  String get call_CallActionsTooltip_decline_inviteToAttendedTransfer => 'ปฏิเสธการโอนสาย';

  @override
  String get call_CallActionsTooltip_device_bluetooth => 'บลูทูธ';

  @override
  String get call_CallActionsTooltip_device_earpiece => 'หูฟังโทรศัพท์';

  @override
  String get call_CallActionsTooltip_device_speaker => 'ลำโพง';

  @override
  String get call_CallActionsTooltip_device_streaming => 'กำลังสตรีม';

  @override
  String get call_CallActionsTooltip_device_unknown => 'อุปกรณ์ที่ไม่รู้จัก';

  @override
  String get call_CallActionsTooltip_device_wiredHeadset => 'หูฟังแบบมีสาย';

  @override
  String get call_CallActionsTooltip_disableCamera => 'ปิดกล้อง';

  @override
  String get call_CallActionsTooltip_disableSpeaker => 'ปิดลำโพง';

  @override
  String get call_CallActionsTooltip_enableCamera => 'เปิดกล้อง';

  @override
  String get call_CallActionsTooltip_cameraPermissionDenied => 'ถูกปฏิเสธสิทธิ์การใช้กล้อง แตะเพื่อเปิดการตั้งค่า';

  @override
  String get call_CallActionsTooltip_enableSpeaker => 'เปิดลำโพง';

  @override
  String get call_CallActionsTooltip_hangup => 'วางสาย';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'ซ่อนแป้นกด';

  @override
  String get call_CallActionsTooltip_hold => 'พักสาย';

  @override
  String get call_CallActionsTooltip_mute => 'ปิดไมโครโฟน';

  @override
  String get call_CallActionsTooltip_showKeypad => 'แสดงแป้นกด';

  @override
  String get call_CallActionsTooltip_transfer => 'โอนสาย';

  @override
  String get call_CallActionsTooltip_transfer_choose => 'เลือกหมายเลข';

  @override
  String get call_CallActionsTooltip_unattended_transfer => 'โอนสายแบบไม่รอรับ';

  @override
  String get call_CallActionsTooltip_unhold => 'ยกเลิกการพักสาย';

  @override
  String get call_CallActionsTooltip_unmute => 'เปิดเสียงไมโครโฟน';

  @override
  String get call_CallList_incoming => 'สายเข้า';

  @override
  String get call_CallList_outgoing => 'โทรออก';

  @override
  String call_CallList_header(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count สาย - แตะเพื่อเลือก',
      one: '$count สาย - แตะเพื่อเลือก',
    );
    return '$_temp0';
  }

  @override
  String get call_CallList_statusOnCall => 'กำลังสนทนา';

  @override
  String call_FocusedActionHint_actingOn(String name) {
    return 'กำลังดำเนินการกับ: $name';
  }

  @override
  String call_FocusedActionHint_willBeEnded(String name) {
    return '$name จะถูกวางสาย';
  }

  @override
  String call_FocusedActionHint_willBeHeld(String name) {
    return '$name จะถูกพักสาย';
  }

  @override
  String get call_ToolbarStatus_connecting => 'กำลังเชื่อมต่อ...';

  @override
  String get call_ToolbarStatus_reconnecting => 'กำลังเชื่อมต่อใหม่...';

  @override
  String get call_description_held => 'พักสาย';

  @override
  String get call_description_incoming => 'สายเรียกเข้า';

  @override
  String get call_description_inviteToAttendedTransfer => 'คุณได้รับเชิญให้เข้าร่วมการโอนสายแบบมีผู้รับสาย';

  @override
  String get call_description_outgoing => 'สายโทรออก';

  @override
  String get call_description_requestToAttendedTransfer => 'คำขอโอนสาย';

  @override
  String get call_description_transferProcessing => 'กำลังโอนสาย';

  @override
  String get call_errorRegisteringSelfManagedPhoneAccount => 'เกิดปัญหาในการลงทะเบียนบัญชีโทรศัพท์ที่จัดการเอง';

  @override
  String get call_FailureAcknowledgeDialog_title => 'ล้มเหลว';

  @override
  String get callProcessingStatus_answering => 'กำลังรับสาย โปรดรอสักครู่…';

  @override
  String get callProcessingStatus_disconnecting => 'กำลังวางสาย โปรดรอสักครู่…';

  @override
  String get callProcessingStatus_init_media => 'กำลังเริ่มต้นอุปกรณ์สื่อ';

  @override
  String get callProcessingStatus_invite => 'กำลังสร้างเซสชัน SIP';

  @override
  String get callProcessingStatus_preparing => 'กำลังเตรียม';

  @override
  String get callProcessingStatus_ringing => 'กำลังเรียก';

  @override
  String get callProcessingStatus_routing => 'กำลังกำหนดเส้นทางการโทร';

  @override
  String get callProcessingStatus_signaling_connecting => 'กำลังเชื่อมต่อกับเซิร์ฟเวอร์ระยะไกล';

  @override
  String get iceConnectionIssue_iceFail => 'การเชื่อมต่อสื่อล้มเหลว ตรวจสอบเครือข่ายของคุณ';

  @override
  String get iceConnectionIssue_iceFailNoIcePath => 'การเชื่อมต่อสื่อล้มเหลว ลองเปลี่ยนไปใช้เครือข่ายอื่น';

  @override
  String get iceConnectionIssue_iceFailNoIcePathViaVpn => 'VPN อาจกำลังบล็อกการโทร ลองปิดการใช้งาน';

  @override
  String get callNetworkQuality_yourAudioWeak => 'สัญญาณเสียงของคุณอ่อน';

  @override
  String get callNetworkQuality_yourVideoWeak => 'วิดีโอของคุณสัญญาณอ่อน';

  @override
  String get callNetworkQuality_theirAudioWeak => 'เสียงของอีกฝ่ายอ่อน';

  @override
  String get callNetworkQuality_theirVideoWeak => 'วิดีโอของอีกฝ่ายสัญญาณอ่อน';

  @override
  String get callPullBadge_dialogTitle => 'สายที่ดึงได้';

  @override
  String get callPullBadge_pickupButtonTitle => 'รับสาย';

  @override
  String get call_settings_additional_options => 'ตัวเลือกเพิ่มเติม';

  @override
  String get callStatus_appUnregistered => 'ยังไม่ได้ลงทะเบียน';

  @override
  String get callStatus_connectError => 'เกิดข้อผิดพลาดในการเชื่อมต่อ';

  @override
  String get callStatus_connectIssue => 'ปัญหาการเชื่อมต่อ';

  @override
  String get callStatus_connectivityNone => 'ไม่มีการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get callStatus_inProgress => 'กำลังเชื่อมต่อ';

  @override
  String get callStatus_ready => 'เชื่อมต่อสำเร็จแล้ว';

  @override
  String get call_SystemErrorDialog_description =>
      'หากต้องการโทรต่อ จำเป็นต้องรีสตาร์ทโทรศัพท์ ซึ่งจะแก้ไขข้อผิดพลาดชั่วคราวของระบบ';

  @override
  String get call_SystemErrorDialog_title => 'ข้อผิดพลาดของระบบ';

  @override
  String get call_ThumbnailAvatar_currentlyNoActiveCall => 'ขณะนี้ไม่มีสายที่ใช้งานอยู่';

  @override
  String get call_videoBackground_actionLabel_disableBlur => 'ปิดการเบลอ';

  @override
  String get call_videoBackground_actionLabel_enableBlur => 'เปิดเบลอ';

  @override
  String get call_videoView_actionLabel_cover => 'เต็มพื้นที่';

  @override
  String get call_videoView_actionLabel_fit => 'พอดี';

  @override
  String get cdrs_Cache_description =>
      'สำเนาประวัติการโทรที่ดึงจากเซิร์ฟเวอร์ซึ่งเก็บไว้ในเครื่อง การล้างจะลบรายการในเครื่อง และประวัติจะถูกดาวน์โหลดใหม่ในการซิงค์ครั้งถัดไป';

  @override
  String get cdrs_Cache_title => 'ประวัติการโทร';

  @override
  String get cdrs_noMissedCalls_message => 'ไม่มีสายที่ไม่ได้รับ';

  @override
  String get cdrs_noRecentCalls_message => 'ไม่มีการโทรล่าสุด';

  @override
  String get common_noInternetConnection_message =>
      'ดูเหมือนว่าคุณไม่ได้เชื่อมต่ออินเทอร์เน็ต กรุณาตรวจสอบการเชื่อมต่อแล้วลองอีกครั้ง';

  @override
  String get common_noInternetConnection_retryButton => 'ลองอีกครั้ง';

  @override
  String get common_noInternetConnection_title => 'ไม่มีการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get common_problemWithLoadingPage => 'เกิดปัญหาในการโหลดหน้า';

  @override
  String get contacts_agreement_button_text => 'ดำเนินการต่อ';

  @override
  String get contacts_agreement_checkbox_text =>
      'ฉันยินยอมให้แอปเข้าถึงรายชื่อผู้ติดต่อของฉันเพื่อยกระดับประสบการณ์การใช้งาน';

  @override
  String get contacts_agreement_description =>
      'แอปนี้ต้องการสิทธิ์เข้าถึงรายชื่อผู้ติดต่อของคุณ เพื่อแสดงผู้ติดต่อในแท็บผู้ติดต่อของแอป \n\nข้อมูลผู้ติดต่อจะถูกจัดเก็บไว้ชั่วคราวในเครื่องของคุณ เพื่อเปิดใช้คุณสมบัติต่าง ๆ เช่น การโทรออกจากแอปได้โดยตรง \n\nข้อมูลนี้จะไม่ถูกเก็บรวบรวม ส่งต่อ หรือแชร์ออกไปนอกแอป';

  @override
  String get contacts_agreement_title => 'การเก็บรวบรวมข้อมูล';

  @override
  String get contacts_ExternalTabButton_refresh => 'รีเฟรช';

  @override
  String get contacts_ExternalTabText_empty => 'ไม่มีรายชื่อติดต่อ';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'ไม่พบรายชื่อติดต่อ';

  @override
  String get contacts_ExternalTabText_failure => 'ไม่สามารถดึงรายชื่อจาก PBX บนคลาวด์ได้';

  @override
  String get contacts_LocalTabButton_contactsAgreement => 'เปิดการตั้งค่า';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'ให้สิทธิ์เข้าถึงรายชื่อติดต่อในโทรศัพท์ของคุณ';

  @override
  String get contacts_LocalTabButton_refresh => 'รีเฟรช';

  @override
  String get contacts_LocalTabText_contactsAgreementFailure =>
      'หากต้องการซิงค์รายชื่อในเครื่อง คุณต้องยอมรับข้อตกลงในการตั้งค่า';

  @override
  String get contacts_LocalTabText_empty => 'ไม่มีผู้ติดต่อ';

  @override
  String get contacts_LocalTabText_emptyOnSearching => 'ไม่พบรายชื่อติดต่อ';

  @override
  String get contacts_LocalTabText_failure => 'ไม่สามารถดึงรายชื่อติดต่อในโทรศัพท์ของคุณได้';

  @override
  String get contacts_LocalTabText_permissionFailure => 'ไม่มีสิทธิ์ในการเข้าถึงรายชื่อติดต่อในโทรศัพท์ของคุณ';

  @override
  String get contactsSourceExternal => 'Cloud PBX';

  @override
  String get contactsSourceLocal => 'โทรศัพท์ของคุณ';

  @override
  String get contacts_Text_blingTransferInitiated => 'กำลังโอนสายแบบไม่แจ้ง';

  @override
  String get contacts_DialogsInfoView_title => 'ข้อมูลการโทร (BLF):';

  @override
  String contacts_ContactTile_inCall(Object destination) {
    return 'อยู่ในสาย: $destination';
  }

  @override
  String get contacts_ContactScreen_options => 'ตัวเลือก:';

  @override
  String get contacts_ContactScreen_presenceViaSip => 'ติดตามสถานะผู้ใช้ผ่าน SIP (Presence)';

  @override
  String get contacts_ContactScreen_presenceViaSip_tooltip =>
      'นอกเหนือจากการแลกเปลี่ยนข้อมูลโดยตรง (แอปถึงแอป) ฟีเจอร์การติดตามผ่าน SIP-Presence ช่วยให้สามารถรวบรวมข้อมูลสถานะการมีตัวตนจากตัวแทนผู้ใช้รายอื่น (โทรศัพท์ตั้งโต๊ะ ซอฟต์โฟนแบบสแตนด์อโลน ฯลฯ) แนะนำให้เปิดใช้งานเฉพาะเมื่อผู้ติดต่อของคุณนิยมใช้ตัวแทนผู้ใช้แบบเดิม และคุณต้องการเห็นสถานะการมีตัวตนของพวกเขาในทุกอุปกรณ์';

  @override
  String get contacts_ContactScreen_dialogsViaSipBlf => 'ติดตามสายที่กำลังใช้งานผ่าน SIP (BLF/Dialogs)';

  @override
  String get contacts_ContactScreen_dialogsViaSipBlf_tooltip =>
      'นอกเหนือจากการแลกเปลี่ยนข้อมูลโดยตรง (แอปถึงแอป) แล้ว ฟีเจอร์การติดตามผ่าน SIP-Dialogs ยังช่วยรวบรวมข้อมูลสถานะการโทรจากผู้ใช้รายอื่น (โทรศัพท์ตั้งโต๊ะ ซอฟต์โฟนแบบสแตนด์อโลน ฯลฯ) แนะนำให้เปิดใช้งานเฉพาะเมื่อผู้ติดต่อของคุณนิยมใช้ผู้ใช้แบบเก่า และคุณต้องการเห็นสถานะการโทรของพวกเขาในทุกอุปกรณ์';

  @override
  String get copyToClipboard_floatingSnackBar => 'คัดลอกข้อความแล้ว';

  @override
  String get copyToClipboard_popupMenuItem => 'คัดลอกไปยังคลิปบอร์ด';

  @override
  String get default_CannotRemoveOwnerMessagingSocketException => 'ไม่สามารถลบเจ้าของได้';

  @override
  String get default_ChatMemberNotFoundMessagingSocketException => 'ไม่พบสมาชิกแชท';

  @override
  String get default_ChatNotFoundMessagingSocketException => 'ไม่พบแชท';

  @override
  String get default_ClientExceptionError => 'เกิดปัญหาเกี่ยวกับ HTTP client';

  @override
  String get default_ErrorDetails => 'รายละเอียด';

  @override
  String get default_ErrorMessage => 'ข้อความแสดงข้อผิดพลาด';

  @override
  String get default_ErrorPath => 'เส้นทางข้อผิดพลาด';

  @override
  String get default_ErrorTransactionId => 'รหัสธุรกรรม';

  @override
  String get default_ForbiddenMessagingSocketException => 'คำขอถูกปฏิเสธ';

  @override
  String get default_FormatExceptionError => 'เกิดปัญหาเกี่ยวกับรูปแบบการตอบกลับ';

  @override
  String get default_InternalErrorMessagingSocketException => 'เกิดข้อผิดพลาดภายในเซิร์ฟเวอร์';

  @override
  String get default_InvalidChatTypeMessagingSocketException => 'ประเภทแชทไม่ถูกต้อง';

  @override
  String get default_JoinCrashedMessagingSocketException => 'เกิดข้อผิดพลาดขณะเข้าร่วมการสนทนา';

  @override
  String get default_MessagingSocketException => 'เกิดข้อผิดพลาดขณะประมวลผลคำขอ';

  @override
  String get default_RequestFailureError => 'เกิดข้อผิดพลาดที่เซิร์ฟเวอร์';

  @override
  String get default_SelfAuthorityAssignmentForbiddenMessagingSocketException => 'ไม่อนุญาตให้กำหนดสิทธิ์ให้ตนเอง';

  @override
  String get default_SelfRemovalForbiddenMessagingSocketException => 'ไม่อนุญาตให้ลบตัวเอง';

  @override
  String get default_SmsConversationNotFoundMessagingSocketException => 'ไม่พบบทสนทนา SMS';

  @override
  String get default_TimeoutExceptionError => 'เซิร์ฟเวอร์หมดเวลาตอบสนอง';

  @override
  String get default_TimeoutMessagingSocketException => 'คำขอหมดเวลา';

  @override
  String get default_TlsExceptionError => 'เกิดปัญหาเกี่ยวกับโปรโตคอลเครือข่ายที่ปลอดภัย (TLS/SSL)';

  @override
  String get default_TypeErrorError => 'เกิดปัญหาเกี่ยวกับการตอบกลับ';

  @override
  String get default_UnauthorizedMessagingSocketException => 'คำขอที่ไม่ได้รับอนุญาต';

  @override
  String get default_UnauthorizedRequestFailureError => 'คำขอไม่ได้รับอนุญาต';

  @override
  String default_UnknownExceptionError(String error) {
    return 'เกิดปัญหาที่ไม่ทราบสาเหตุ: $error';
  }

  @override
  String get default_UserAlreadyInChatMessagingSocketException => 'ผู้ใช้อยู่ในแชทอยู่แล้ว';

  @override
  String get diagnostic_AppBar_title => 'การวินิจฉัย';

  @override
  String get diagnostic_battery_groupTitle => 'แบตเตอรี่';

  @override
  String get diagnostic_batteryMode_optimized_description =>
      'ระบบจัดการการทำงานเบื้องหลังของแอปเพื่อประหยัดแบตเตอรี่ ซึ่งอาจทำให้สายเรียกเข้าที่เกิดจากการแจ้งเตือนแบบพุชทำงานไม่ถูกต้อง';

  @override
  String get diagnostic_batteryMode_optimized_title => 'ปรับให้เหมาะสม';

  @override
  String get diagnostic_batteryMode_restricted_description =>
      'กิจกรรมเบื้องหลังของแอปถูกจำกัดอย่างมากเพื่อประหยัดแบตเตอรี่ อาจพลาดสายเรียกเข้าได้';

  @override
  String get diagnostic_batteryMode_restricted_title => 'ถูกจำกัด';

  @override
  String get diagnostic_batteryMode_unknown_description => 'ไม่ทราบสถานะโหมดแบตเตอรี่ แอปอาจทำงานไม่เป็นไปตามที่คาด';

  @override
  String get diagnostic_batteryMode_unknown_title => 'ไม่ทราบ';

  @override
  String get diagnostic_batteryMode_unrestricted_description =>
      'แอปสามารถทำงานเบื้องหลังได้อย่างเต็มที่โดยไม่มีข้อจำกัด';

  @override
  String get diagnostic_batteryMode_unrestricted_title => 'ไม่จำกัด';

  @override
  String get diagnostic_battery_navigate_section => 'ไปที่ส่วนแบตเตอรี่';

  @override
  String get diagnostic_battery_tile_title => 'โหมดแบตเตอรี่';

  @override
  String get diagnostic_callingMode_groupTitle => 'โหมดการโทร';

  @override
  String get diagnostic_callingMode_tile_title => 'โหมดการโทร';

  @override
  String get diagnostic_callingMode_standalone_title => 'โหมดโทรแบบจำกัด';

  @override
  String get diagnostic_callingMode_standalone_caption =>
      'แบบสแตนด์อโลน - การแจ้งสายเรียกเข้าและการเลือกหูฟังอาจถูกจำกัด';

  @override
  String get diagnostic_callingMode_standalone_description =>
      'อุปกรณ์นี้ไม่รองรับเฟรมเวิร์กการโทรของระบบ (Telecom) ดังนั้นสายเรียกเข้าจะใช้บริการเบื้องหลังแบบจำกัด สายอาจล่าช้าหรือพลาดเมื่อระบบจำกัดแอปที่ทำงานเบื้องหลัง การเลือกหูฟังบลูทูธหรือแบบมีสายไม่สามารถใช้งานได้ในโหมดนี้';

  @override
  String get diagnostic_permission_camera_description => 'แอปนี้ต้องการสิทธิ์เข้าถึงกล้องเพื่อโทรแบบวิดีโอ';

  @override
  String get diagnostic_permission_camera_title => 'กล้อง';

  @override
  String get diagnostic_permission_contacts_description =>
      'แอปนี้ต้องการสิทธิ์ในการเข้าถึงรายชื่อติดต่อเพื่อโทรหาคนในสมุดที่อยู่ของคุณ';

  @override
  String get diagnostic_permission_contacts_title => 'รายชื่อติดต่อ';

  @override
  String get diagnosticPermissionDetails_button_managePermission => 'จัดการสิทธิ์';

  @override
  String get diagnosticPermissionDetails_button_requestPermission => 'ขอสิทธิ์';

  @override
  String get diagnosticPermissionDetails_title_statusPermission => 'สิทธิ์สถานะ';

  @override
  String get diagnostic_permission_microphone_description => 'แอปนี้ต้องการสิทธิ์เข้าถึงไมโครโฟนเพื่อโทรด้วยเสียง';

  @override
  String get diagnostic_permission_microphone_title => 'ไมโครโฟน';

  @override
  String get diagnostic_permission_notification_description => 'ช่วยให้แอปสามารถแสดงสายเรียกเข้าได้';

  @override
  String get diagnostic_permission_notification_title => 'การแจ้งเตือน';

  @override
  String get diagnostic_permissionStatus_denied => 'การเข้าถึงถูกปฏิเสธ';

  @override
  String get diagnostic_permissionStatus_granted => 'ได้รับสิทธิ์การเข้าถึงแล้ว';

  @override
  String get diagnostic_permissionStatus_limited => 'การเข้าถึงแบบจำกัด';

  @override
  String get diagnostic_permissionStatus_permanentlyDenied => 'ถูกปฏิเสธการเข้าถึงอย่างถาวร';

  @override
  String get diagnostic_permissionStatus_provisional => 'การเข้าถึงชั่วคราว';

  @override
  String get diagnostic_permissionStatus_restricted => 'การเข้าถึงถูกจำกัด';

  @override
  String get diagnostic_specialPermissionStatus_denied => 'การเข้าถึงถูกปฏิเสธ';

  @override
  String get diagnostic_specialPermissionStatus_granted => 'ได้รับสิทธิ์การเข้าถึงแล้ว';

  @override
  String get diagnostic_specialPermissionStatus_unknown => 'ไม่ทราบ';

  @override
  String get diagnostic_xiaomi_backgroundActivityStart_description =>
      'MIUI/HyperOS จำกัดการแสดงหน้าจอสายเรียกเข้าขณะที่แอปทำงานอยู่เบื้องหลัง หากไม่ได้เปิดสิทธิ์ \"แสดงหน้าต่างป๊อปอัปขณะทำงานอยู่เบื้องหลัง\" ให้กับแอปนี้';

  @override
  String get diagnostic_xiaomi_backgroundActivityStart_tile_title => 'แสดงหน้าต่างป๊อปอัปขณะทำงานอยู่เบื้องหลัง';

  @override
  String get diagnostic_xiaomi_groupTitle => 'สิทธิ์ของ Xiaomi';

  @override
  String get diagnostic_xiaomi_navigate_section => 'ไปที่ส่วนสิทธิ์หน้าจอล็อก';

  @override
  String get diagnostic_xiaomi_showWhenLocked_description =>
      'MIUI/HyperOS จำกัดการแสดงหน้าจอสายเรียกเข้าบนหน้าจอล็อก หากไม่ได้เปิดสิทธิ์ \"แสดงบนหน้าจอล็อก\" ให้กับแอปนี้';

  @override
  String get diagnostic_xiaomi_showWhenLocked_tile_title => 'แสดงบนหน้าจอล็อก';

  @override
  String get diagnosticPushDetails_configuration_title => 'การกำหนดค่าบริการแจ้งเตือนแบบพุช';

  @override
  String get diagnosticPushDetails_errorMessage_intro => 'ขั้นตอนบางอย่างที่ควรลอง:\n';

  @override
  String get diagnosticPushDetails_errorMessage_step1 => '1. ตรวจสอบว่าโทรศัพท์ของคุณเชื่อมต่ออินเทอร์เน็ตอยู่\n';

  @override
  String get diagnosticPushDetails_errorMessage_step2 =>
      '2. หากเชื่อมต่อแล้ว ตรวจสอบว่าโทรศัพท์ของคุณเข้าถึงบริการของ Google ได้โดยลองเข้าเว็บไซต์\n';

  @override
  String get diagnosticPushDetails_errorMessage_step3 =>
      '3. รอสักครู่แล้วลองใหม่ – เซิร์ฟเวอร์ messaging ของ Firebase อาจขัดข้องชั่วคราว\n';

  @override
  String get diagnosticPushDetails_errorMessage_step4 =>
      '4. รีสตาร์ท Google Play services เพื่อให้แน่ใจว่าทำงานได้อย่างถูกต้อง\n';

  @override
  String get diagnosticPushDetails_errorMessage_step5 =>
      '5. ตรวจสอบว่าได้ติดตั้ง Google Play services บนอุปกรณ์ของคุณแล้ว\n';

  @override
  String get diagnosticPushDetails_successMessage =>
      'ตั้งค่าบริการแจ้งเตือนสำเร็จแล้วและพร้อมใช้งานสำหรับรับข้อความและจัดการสายเรียกเข้า';

  @override
  String get diagnostic_pushTokenStatusType_progress => 'กำลังดำเนินการ';

  @override
  String get diagnostic_pushTokenStatusType_success => 'ตั้งค่าบริการสำเร็จ';

  @override
  String get diagnosticReportDialogAddNoteExpansionTileTitle => 'เพิ่มหมายเหตุ (ไม่บังคับ)';

  @override
  String get diagnosticReportDialogCancelButtonLabel => 'ยกเลิก';

  @override
  String get diagnosticReportDialogCommentTextFieldHintText => 'อธิบายสิ่งที่เกิดขึ้น...';

  @override
  String get diagnosticReportDialogContent => 'รายงานนี้มีรายละเอียดทางเทคนิคเพื่อช่วยให้เราระบุปัญหาการเชื่อมต่อ';

  @override
  String get diagnosticReportDialogIncludeSystemLogsSwitchTileSubtitle => 'ต้องใช้สิทธิ์เพิ่มเติม';

  @override
  String get diagnosticReportDialogIncludeSystemLogsSwitchTileTitle => 'รวมบันทึกระบบ';

  @override
  String get diagnosticReportDialogSendReportButtonLabel => 'ส่งรายงาน';

  @override
  String get diagnosticReportDialogTitle => 'ส่งรายงานการวินิจฉัย';

  @override
  String get diagnosticScreen_contacts_agreement_description =>
      'อนุญาตให้แอปเข้าถึงรายชื่อติดต่อของฉันเพื่อปรับปรุงประสบการณ์การใช้งาน';

  @override
  String get diagnosticScreen_contacts_agreement_group_title => 'ข้อตกลง';

  @override
  String get diagnosticScreen_contacts_agreement_title => 'ข้อตกลงเกี่ยวกับรายชื่อติดต่อ';

  @override
  String get diagnosticScreen_permissionsGroup_title => 'สิทธิ์การเข้าถึง';

  @override
  String get diagnosticScreen_pushNotificationService_title => 'บริการการแจ้งเตือนแบบพุช';

  @override
  String get diagnostic_network_groupTitle => 'เครือข่าย';

  @override
  String get diagnosticNetworkTest_status_offline => 'ออฟไลน์';

  @override
  String get diagnosticNetworkTest_status_reachable => 'เข้าถึงได้';

  @override
  String get diagnosticNetworkTest_status_restricted => 'ถูกจำกัด';

  @override
  String get diagnosticNetworkTest_status_checking => 'กำลังตรวจสอบ…';

  @override
  String get diagnosticNetworkTest_status_unreachable => 'เข้าถึงไม่ได้';

  @override
  String get diagnosticNetworkTestItem_subtitle_noNetwork => 'ไม่มีการเชื่อมต่อเครือข่าย';

  @override
  String diagnosticNetworkTestItem_subtitle_publicIps(String ips) {
    return 'สาธารณะ: $ips';
  }

  @override
  String get diagnosticNetworkTestItem_subtitle_stunBlocked => 'STUN ถูกบล็อก · ใช้ relay ได้';

  @override
  String get diagnosticNetworkTestItem_subtitle_stunUnreachable => 'ไม่สามารถเข้าถึง STUN · ภายในเครือข่ายเท่านั้น';

  @override
  String get diagnosticNetworkTestItem_subtitle_noCandidates => 'ไม่พบ ICE candidate';

  @override
  String get diagnosticNetworkTestItem_network_wifi => 'WiFi';

  @override
  String get diagnosticNetworkTestItem_network_mobile => 'มือถือ';

  @override
  String get diagnosticNetworkTestItem_network_ethernet => 'อีเทอร์เน็ต';

  @override
  String get diagnosticNetworkTestItem_network_vpn => 'VPN';

  @override
  String get diagnosticNetworkTestDetails_title => 'การเข้าถึงเครือข่าย';

  @override
  String get diagnosticNetworkTestDetails_description =>
      'ตรวจสอบว่าอุปกรณ์ของคุณสามารถโทรออกและรับสายผ่านอินเทอร์เน็ตได้หรือไม่ โดยการตรวจสอบการเชื่อมต่อเครือข่าย\nผู้สมัคร Server-reflexive (srflx) ยืนยันว่าสามารถเข้าถึง IP สาธารณะได้ผ่าน STUN ผู้สมัคร Relay หมายความว่าการเข้าถึงโดยตรงถูกบล็อกและต้องใช้เซิร์ฟเวอร์ TURN ส่วน Host-only หมายความว่าไม่สามารถเข้าถึง STUN ได้และทำได้เฉพาะการเชื่อมต่อภายในเครื่องเท่านั้น';

  @override
  String get diagnosticNetworkTestDetails_status => 'สถานะ';

  @override
  String get diagnosticNetworkTestDetails_candidates => 'Candidates';

  @override
  String get diagnosticNetworkTestDetails_noNetwork => 'ไม่มีการเชื่อมต่อเครือข่าย';

  @override
  String get diagnosticNetworkTestDetails_noCandidates => 'ไม่พบ ICE candidate';

  @override
  String get favorites_BodyCenter_empty => 'ขณะนี้คุณยังไม่มีหมายเลขโปรด\nเพิ่มรายการโปรดจากผู้ติดต่อโดยใช้ไอคอนรูปดาว';

  @override
  String get favorites_DeleteConfirmDialog_content => 'คุณแน่ใจหรือไม่ว่าต้องการลบหมายเลขโปรดปัจจุบัน?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'ยืนยันการลบ';

  @override
  String favorites_SnackBar_deleted(String name) {
    return 'ลบ $name แล้ว';
  }

  @override
  String get favorites_Text_blingTransferInitiated => 'กำลังโอนสายแบบไม่แจ้ง';

  @override
  String formatPhone(String style, String main, String ext) {
    String _temp0 = intl.Intl.selectLogic(style, {
      'full': '$main (ต่อ: $ext)',
      'simple': '$main',
      'only_ext': 'ต่อ: $ext',
      'empty': 'ไม่มีหมายเลขโทรศัพท์',
      'other': '$main',
    });
    return '$_temp0';
  }

  @override
  String get locale_default => 'ค่าเริ่มต้น';

  @override
  String get locale_en => 'อังกฤษ';

  @override
  String get locale_it => 'อิตาลี';

  @override
  String get locale_uk => 'ยูเครน';

  @override
  String get locale_th => 'ไทย';

  @override
  String get login_Button_coreUrlAssignProceed => 'ดำเนินการต่อ';

  @override
  String get login_Button_otpSigninRequestProceed => 'ดำเนินการต่อ';

  @override
  String get login_Button_otpSigninVerifyProceed => 'ยืนยัน';

  @override
  String get login_Button_otpSigninVerifyRepeat => 'ส่งรหัสอีกครั้ง';

  @override
  String login_Button_otpSigninVerifyRepeatInterval(int seconds) {
    return 'ส่งรหัสอีกครั้ง ($seconds วิ)';
  }

  @override
  String get login_Button_passwordSigninProceed => 'ดำเนินการต่อ';

  @override
  String get login_Button_signIn => 'เข้าสู่ระบบ';

  @override
  String get login_Button_signupRequestProceed => 'ดำเนินการต่อ';

  @override
  String get login_Button_signUpToDemoInstance => 'สมัคร / เข้าสู่ระบบ';

  @override
  String get login_Button_signupVerifyProceed => 'ยืนยัน';

  @override
  String get login_Button_signupVerifyRepeat => 'ส่งรหัสอีกครั้ง';

  @override
  String login_Button_signupVerifyRepeatInterval(int seconds) {
    return 'ส่งรหัสอีกครั้ง ($seconds วินาที)';
  }

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'เข้าสู่ระบบ WebTrit Cloud Backend ของคุณ';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'เวอร์ชันอินสแตนซ์ที่ระบุไม่รองรับ โปรดติดต่อผู้ดูแลระบบของคุณ (ปัจจุบัน: $actual, ที่รองรับ: $supportedConstraint)';
  }

  @override
  String login_AppVersionUnsupportedExceptionError(String actual, String minSupported) {
    return 'เวอร์ชันแอปของคุณไม่รองรับอีกต่อไป กรุณาอัปเดตแอปพลิเคชันเพื่อใช้งานต่อ (ปัจจุบัน: $actual, ขั้นต่ำที่ต้องใช้: $minSupported)';
  }

  @override
  String get login_RequestFailureDeliveryChannelUnspecifiedError =>
      'บัญชีนี้ไม่มีช่องทางติดต่อที่ตั้งค่าไว้สำหรับรับรหัสยืนยัน';

  @override
  String get login_RequestFailureDeliveryChannelUnspecifiedPhoneError =>
      'บัญชีที่ใช้หมายเลขโทรศัพท์นี้ไม่มีช่องทางติดต่อที่ตั้งค่าไว้สำหรับรับรหัสยืนยัน';

  @override
  String get login_RequestFailureDeliveryChannelUnspecifiedEmailError =>
      'บัญชีที่ใช้อีเมลนี้ไม่มีช่องทางติดต่อที่ตั้งค่าไว้สำหรับรับรหัสยืนยัน';

  @override
  String get login_RequestFailureEmptyEmailError => 'ไม่สามารถส่งรหัสยืนยันได้';

  @override
  String get login_RequestFailureIdentifierIsNotValid => 'ตัวระบุไม่ถูกต้องหรือไม่มีอยู่';

  @override
  String get login_RequestFailureIncorrectOtpCodeError => 'รหัสยืนยันไม่ถูกต้อง';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'ยืนยันแล้ว';

  @override
  String get login_RequestFailureOtpExpiredError => 'การยืนยันหมดอายุ';

  @override
  String get login_RequestFailureOtpNotFoundError => 'ไม่พบการยืนยัน';

  @override
  String get login_RequestFailureOtpVerificationAttemptsExceededError => 'เกินจำนวนครั้งในการยืนยัน';

  @override
  String get login_RequestFailureParametersApplyIssueError => 'ไม่สามารถประมวลผลข้อมูลที่ระบุได้';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'ไม่พบหมายเลขโทรศัพท์';

  @override
  String get login_RequestFailureIncorrectCredentialsError => 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง';

  @override
  String get login_RequestFailureUserNotFoundError => 'ไม่พบผู้ใช้';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'WebTrit Cloud Backend ของคุณไม่รองรับแอปนี้';

  @override
  String get login_SupportedLoginTypeMissedExceptionError =>
      'WebTrit Cloud Backend ปัจจุบันไม่รองรับประเภทการเข้าสู่ระบบใด ๆ ที่ใช้งานได้กับแอปนี้';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'หากคุณยังไม่มี WebTrit Cloud Backend ของคุณเอง โปรดติดต่อทีมขาย $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription =>
      'หากต้องการโทรผ่านระบบ VoIP ของคุณเอง โปรดป้อน URL ของ WebTrit Cloud Backend (ตามที่ผู้จัดการบัญชีของคุณให้มา) ด้านล่าง';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'ป้อน URL ของ WebTrit Cloud Backend ของคุณ';

  @override
  String get login_TextFieldLabelText_otpSigninCode => 'กรอกรหัสยืนยัน';

  @override
  String get login_TextFieldLabelText_otpSigninUserRef => 'กรอกหมายเลขโทรศัพท์หรืออีเมลของคุณ';

  @override
  String get login_TextFieldLabelText_otpSigninUserRefPhone => 'ป้อนหมายเลขโทรศัพท์ของคุณ';

  @override
  String get login_TextFieldLabelText_otpSigninUserRefEmail => 'กรอกอีเมลของคุณ';

  @override
  String get login_TextFieldLabelText_passwordSigninPassword => 'กรอกรหัสผ่านของคุณ';

  @override
  String get login_TextFieldLabelText_passwordSigninUserRef => 'กรอกหมายเลขโทรศัพท์หรืออีเมลของคุณ';

  @override
  String get login_TextFieldLabelText_signupCode => 'กรอกรหัสยืนยัน';

  @override
  String get login_TextFieldLabelText_signupEmail => 'กรอกอีเมลของคุณ';

  @override
  String get login_Text_otpSigninRequestPostDescription => '';

  @override
  String get login_Text_otpSigninRequestPreDescription => '';

  @override
  String login_Text_otpSigninVerifyPostDescriptionFromEmail(String email) {
    return 'หากคุณไม่เห็นอีเมลที่มีรหัสยืนยันจาก $email ในกล่องจดหมายของคุณ โปรดตรวจสอบโฟลเดอร์สแปม';
  }

  @override
  String get login_Text_otpSigninVerifyPostDescriptionGeneral =>
      'หากคุณไม่พบอีเมลที่มีรหัสยืนยันในกล่องจดหมาย โปรดตรวจสอบในโฟลเดอร์สแปม';

  @override
  String login_Text_otpSigninVerifyPreDescriptionUserRef(String userRef) {
    return 'รหัสยืนยันแบบใช้ครั้งเดียวถูกส่งไปยังอีเมลที่เชื่อมโยงกับหมายเลขโทรศัพท์หรืออีเมลที่ระบุ';
  }

  @override
  String get login_Text_passwordSigninPostDescription => '';

  @override
  String get login_Text_passwordSigninPreDescription => '';

  @override
  String get login_Text_signupRequestPostDescription => '';

  @override
  String get login_Text_signupRequestPostDescriptionDemo => 'หากคุณยังไม่มีบัญชี ระบบจะสร้างให้คุณโดยอัตโนมัติ';

  @override
  String get login_Text_signupRequestPreDescription => '';

  @override
  String get login_Text_signupRequestPreDescriptionDemo => '';

  @override
  String login_Text_signupVerifyPostDescriptionFromEmail(String email) {
    return 'หากคุณไม่พบอีเมลที่มีรหัสยืนยันจาก $email ในกล่องจดหมาย กรุณาตรวจสอบในโฟลเดอร์สแปม';
  }

  @override
  String get login_Text_signupVerifyPostDescriptionGeneral =>
      'หากคุณไม่เห็นอีเมลที่มีรหัสยืนยันในกล่องจดหมายของคุณ โปรดตรวจสอบโฟลเดอร์สแปม';

  @override
  String login_Text_signupVerifyPreDescriptionEmail(String email) {
    return 'ส่งรหัสยืนยันแบบใช้ครั้งเดียวไปยัง $email แล้ว';
  }

  @override
  String get login_Text_qrSigninScanHint => 'สแกนคิวอาร์โค้ดเพื่อเข้าสู่ระบบ';

  @override
  String get login_Text_qrSigninVerifyingTitle => 'กำลังเข้าสู่ระบบ...';

  @override
  String get login_Text_qrSigninVerifyingDescription => 'สแกนคิวอาร์โค้ดแล้ว กำลังตรวจสอบกับเซิร์ฟเวอร์';

  @override
  String get login_Text_qrSigninCameraPermissionTitle => 'การเข้าถึงกล้องถูกปิดอยู่';

  @override
  String get login_Text_qrSigninCameraPermissionDescription =>
      'ต้องการสิทธิ์เข้าถึงกล้องเพื่อสแกนคิวอาร์โค้ด โปรดเปิดใช้งานเพื่อดำเนินการต่อ';

  @override
  String get login_Button_qrSigninAllowCameraAccess => 'อนุญาตการเข้าถึงกล้อง';

  @override
  String get login_Button_qrSigninOpenSettings => 'เปิดการตั้งค่า';

  @override
  String get login_Text_qrSigninInvalidCodeError => 'คิวอาร์โค้ดนี้ใช้เข้าสู่ระบบไม่ได้';

  @override
  String get loginType_otpSignin => 'เข้าสู่ระบบด้วย OTP';

  @override
  String get loginType_passwordSignin => 'เข้าสู่ระบบด้วยรหัสผ่าน';

  @override
  String get loginType_qrSignin => 'คิวอาร์โค้ด';

  @override
  String get loginType_signup => 'สมัครสมาชิก';

  @override
  String get login_validationCoreUrlError => 'กรุณากรอก URL ที่ถูกต้อง';

  @override
  String get login_validationCoreUrlUnreachableError => 'ไม่สามารถเชื่อมต่อกับบริการ WebTrit ตามที่อยู่นี้ได้';

  @override
  String get login_validationEmailError => 'กรุณากรอกอีเมลที่ถูกต้อง';

  @override
  String get login_validationPhoneError => 'โปรดกรอกหมายเลขโทรศัพท์ที่ถูกต้อง';

  @override
  String get login_validationUserRefError => 'โปรดป้อนหมายเลขโทรศัพท์หรืออีเมลที่ถูกต้อง';

  @override
  String get logRecordsConsole_AppBarTitle => 'คอนโซลบันทึก';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'รีเฟรช';

  @override
  String get logRecordsConsole_Text_failure => 'เกิดข้อผิดพลาดที่ไม่คาดคิด';

  @override
  String logRecordsConsole_Text_recordsCountHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count รายการล่าสุด',
      one: '$count รายการล่าสุด',
    );
    return 'กำลังแสดง $_temp0 ใช้การแชร์เพื่อส่งออกบันทึกทั้งหมด';
  }

  @override
  String get logRecordsConsole_Button_infoClose => 'เข้าใจแล้ว';

  @override
  String get logRecordsConsole_PopupMenuItem_info => 'ข้อมูล';

  @override
  String get logRecordsConsole_PopupMenuItem_clear => 'ล้าง';

  @override
  String get main_BottomNavigationBarItemLabel_chats => 'แชท';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => 'รายชื่อ';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => 'รายการโปรด';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => 'แป้นกด';

  @override
  String get main_BottomNavigationBarItemLabel_recents => 'ล่าสุด';

  @override
  String get main_CompatibilityIssueDialogActions_logout => 'ออกจากระบบ';

  @override
  String get main_CompatibilityIssueDialogActions_update => 'อัปเดต';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
    String actual,
    String supportedConstraint,
  ) {
    return 'เวอร์ชัน WebTrit Cloud Backend ไม่รองรับ กรุณาติดต่อผู้ดูแลระบบของคุณ\n\nเวอร์ชันของอินสแตนซ์:\n$actual\n\nเวอร์ชันที่รองรับ:\n$supportedConstraint';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'ปัญหาความเข้ากันได้';

  @override
  String get main_AppUpdateRequiredDialog_title => 'ต้องอัปเดต';

  @override
  String get main_AppUpdateRequiredDialog_description =>
      'เวอร์ชันแอปของคุณไม่ได้รับการสนับสนุนอีกต่อไป กรุณาอัปเดตแอปพลิเคชันเพื่อใช้งานต่อ';

  @override
  String get main_AppUpdateRequiredDialog_currentVersionLabel => 'เวอร์ชันแอป';

  @override
  String get main_AppUpdateRequiredDialog_buildVersionLabel => 'เวอร์ชันบิลด์';

  @override
  String main_AppUpdateRequiredDialog_currentVersionValue(String storeVersion, String appVersion) {
    return '$appVersion (บิลด์ $storeVersion)';
  }

  @override
  String get main_AppUpdateRequiredDialog_minimumVersionLabel => 'เวอร์ชันขั้นต่ำที่ต้องการ';

  @override
  String get messaging_ActionBtn_retry => 'ลองใหม่';

  @override
  String get messaging_ChooseContact_cancel => 'ยกเลิก';

  @override
  String get messaging_ChooseContact_empty => 'ไม่พบรายชื่อติดต่อ';

  @override
  String get messaging_ChooseContact_title => 'เลือกรายชื่อติดต่อ:';

  @override
  String get messaging_ConfirmDialog_ask => 'คุณแน่ใจหรือไม่?';

  @override
  String get messaging_ConfirmDialog_cancel => 'ไม่';

  @override
  String get messaging_ConfirmDialog_confirm => 'ใช่';

  @override
  String get messaging_ConversationBuilders_back => 'ย้อนกลับ';

  @override
  String get messaging_ConversationBuilders_cancel => 'ยกเลิก';

  @override
  String messaging_ConversationBuilders_contactExtension(String extension) {
    return 'เบอร์ต่อ: $extension';
  }

  @override
  String get messaging_ConversationBuilders_contactOrNumberSearch_hint => 'ป้อนชื่อหรือหมายเลขโทรศัพท์';

  @override
  String get messaging_ConversationBuilders_contactSearch_hint => 'ค้นหารายชื่อติดต่อ';

  @override
  String get messaging_ConversationBuilders_create => 'สร้าง';

  @override
  String get messaging_ConversationBuilders_createGroup => 'สร้างกลุ่ม';

  @override
  String get messaging_ConversationBuilders_externalContacts_heading => 'รายชื่อติดต่อ Cloud PBX';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message1 =>
      'รายชื่อนี้มีหมายเลขโทรศัพท์ไม่ถูกต้อง ควรอยู่ในรูปแบบ ';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message2 => '. กรุณาแก้ไขในสมุดโทรศัพท์ของคุณ';

  @override
  String get messaging_ConversationBuilders_invalidNumber_ok => 'ปิด';

  @override
  String get messaging_ConversationBuilders_invalidNumber_title => 'หมายเลขโทรศัพท์ไม่ถูกต้อง';

  @override
  String get messaging_ConversationBuilders_invite_heading => 'เชิญผู้ใช้:';

  @override
  String get messaging_ConversationBuilders_localContacts_heading => 'ผู้ติดต่อในเครื่อง';

  @override
  String get messaging_ConversationBuilders_membersHeadline => 'สมาชิก';

  @override
  String get messaging_ConversationBuilders_nameFieldEmpty => 'โปรดกรอกชื่อกลุ่ม';

  @override
  String get messaging_ConversationBuilders_nameFieldLabel => 'ชื่อกลุ่ม';

  @override
  String get messaging_ConversationBuilders_nameFieldShort => 'ชื่อกลุ่มต้องมีอย่างน้อย 3 ตัวอักษร';

  @override
  String get messaging_ConversationBuilders_next_action => 'ถัดไป';

  @override
  String get messaging_ConversationBuilders_noContacts => 'ไม่มีรายชื่อติดต่อที่ตรงกับผลการค้นหา';

  @override
  String get messaging_ConversationBuilders_numberFormatExample =>
      '+ [รหัสประเทศ] [รหัสพื้นที่/ผู้ให้บริการ] [หมายเลขผู้ใช้]';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorError =>
      'หมายเลขโทรศัพท์ที่กรอกไม่ถูกต้อง ควรกรอกในรูปแบบ: ';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorHint => 'รูปแบบหมายเลขโทรศัพท์: ';

  @override
  String get messaging_ConversationBuilders_title_group => 'สร้างกลุ่ม';

  @override
  String get messaging_ConversationBuilders_title_new => 'แชทใหม่';

  @override
  String get messaging_Conversation_failure => 'เกิดข้อผิดพลาดในการโหลดการสนทนา';

  @override
  String get messaging_ConversationScreen_titleAvailable => 'ออนไลน์อยู่';

  @override
  String get messaging_ConversationScreen_titlePrefix => 'แชท:';

  @override
  String get messaging_ConversationsScreen_chatsSearch_hint => 'กรอกชื่อแชทหรือชื่อผู้ใช้';

  @override
  String get messaging_ConversationsScreen_empty => 'ยังไม่มีการสนทนา';

  @override
  String get messaging_ConversationsScreen_messages_title => 'ข้อความ';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_text =>
      'คุณต้องมีหมายเลขโทรศัพท์ที่เชื่อมโยงกับบัญชีของคุณเพื่อส่งข้อความ SMS';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_title => 'ไม่มีหมายเลขโทรศัพท์';

  @override
  String get messaging_ConversationsScreen_selectNumberSheet_title => 'เลือกหมายเลข';

  @override
  String get messaging_ConversationsScreen_smses_title => 'SMS';

  @override
  String get messaging_ConversationsScreen_smssSearch_hint => 'กรอกหมายเลขโทรศัพท์';

  @override
  String get messaging_ConversationsScreen_unsupported =>
      'ระบบปลายทางไม่รองรับการรับส่งข้อความ โปรดติดต่อผู้ดูแลระบบเพื่อเปิดใช้งาน';

  @override
  String get messaging_Conversations_tile_empty => 'ยังไม่มีข้อความ';

  @override
  String get messaging_Conversations_tile_you => 'คุณ';

  @override
  String get messaging_DialogInfo_deleteAsk => 'คุณแน่ใจหรือไม่ว่าต้องการลบบทสนทนานี้?';

  @override
  String get messaging_DialogInfo_deleteBtn => 'ลบบทสนทนา';

  @override
  String get messaging_DialogInfo_title => 'ข้อมูลผู้ติดต่อ';

  @override
  String get messaging_GroupAuthorities_moderator => 'ผู้ดูแล';

  @override
  String get messaging_GroupAuthorities_noauthorities => 'สมาชิก';

  @override
  String get messaging_GroupAuthorities_owner => 'เจ้าของ';

  @override
  String get messaging_GroupInfo_addUserBtnText => 'เพิ่มผู้ใช้';

  @override
  String get messaging_GroupInfo_deleteLeaveBtnText => 'ลบและออกจากกลุ่ม';

  @override
  String get messaging_GroupInfo_groupMembersHeadline => 'สมาชิกกลุ่ม';

  @override
  String get messaging_GroupInfo_leaveAndDeleteAsk => 'คุณแน่ใจหรือไม่ว่าต้องการออกและลบกลุ่มนี้?';

  @override
  String get messaging_GroupInfo_leaveAsk => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากกลุ่มนี้?';

  @override
  String get messaging_GroupInfo_leaveBtnText => 'ออกจากกลุ่ม';

  @override
  String get messaging_GroupInfo_makeModeratorAsk => 'คุณแน่ใจหรือไม่ว่าต้องการให้ผู้ใช้นี้เป็นผู้ดูแล?';

  @override
  String get messaging_GroupInfo_makeModeratorBtnText => 'ตั้งเป็นผู้ดูแล';

  @override
  String get messaging_GroupInfo_removeModeratorAsk => 'คุณแน่ใจหรือไม่ว่าต้องการถอดผู้ใช้นี้ออกจากผู้ดูแล?';

  @override
  String get messaging_GroupInfo_removeUserAsk => 'คุณแน่ใจหรือไม่ว่าต้องการลบผู้ใช้นี้ออกจากกลุ่ม?';

  @override
  String get messaging_GroupInfo_removeUserBtnText => 'ลบออก';

  @override
  String get messaging_GroupInfo_title => 'ข้อมูลกลุ่ม';

  @override
  String get messaging_GroupInfo_titlePrefix => 'กลุ่ม:';

  @override
  String get messaging_GroupInfo_unmakeModeratorBtnText => 'ยกเลิกการเป็นผู้ดูแล';

  @override
  String get messaging_MessageField_hint => 'พิมพ์ข้อความ';

  @override
  String get messaging_MessageListView_typingTrail => 'กำลังพิมพ์...';

  @override
  String get messaging_MessageView_delete => 'ลบ';

  @override
  String get messaging_MessageView_deleted => '[ลบแล้ว]';

  @override
  String get messaging_MessageView_edit => 'แก้ไข';

  @override
  String get messaging_MessageView_edited => '[แก้ไขแล้ว]';

  @override
  String get messaging_MessageView_forward => 'ส่งต่อ';

  @override
  String get messaging_MessageView_reply => 'ตอบกลับ';

  @override
  String get messaging_MessageView_textcopy => 'คัดลอกไปยังคลิปบอร์ด';

  @override
  String get messaging_MessageView_today => 'วันนี้';

  @override
  String get messaging_MessageView_yesterday => 'เมื่อวาน';

  @override
  String get messaging_ParticipantName_unknown => 'ผู้ใช้ที่ไม่รู้จัก';

  @override
  String get messaging_ParticipantName_you => 'คุณ';

  @override
  String get messaging_SmsSendingStatus_delivered => 'ส่งแล้ว';

  @override
  String get messaging_SmsSendingStatus_failed => 'ล้มเหลว';

  @override
  String get messaging_SmsSendingStatus_sent => 'ส่งแล้ว';

  @override
  String get messaging_SmsSendingStatus_waiting => 'กำลังรอ';

  @override
  String get messaging_StateBar_connecting => 'กำลังเชื่อมต่อ';

  @override
  String get messaging_StateBar_error => 'ถูกตัดการเชื่อมต่อ';

  @override
  String get messaging_StateBar_initializing => 'กำลังเริ่มต้น';

  @override
  String get notifications_errorSnackBarAction_callSdpConfiguration => 'การกำหนดค่า SDP ไม่ถูกต้อง';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'ตรวจสอบ';

  @override
  String get notifications_messageSnackBar_callVideoDowngraded => 'รับสายโดยปิดกล้อง - ไม่ได้รับอนุญาตให้ใช้กล้อง';

  @override
  String get notifications_messageSnackBarAction_callVideoDowngraded => 'การตั้งค่า';

  @override
  String get notifications_errorSnackBar_activeLineBlindTransferWarning =>
      'คุณกำลังอยู่ในสายกับผู้รับที่คุณพยายามโอนสายแบบไม่รอรับอยู่แล้ว';

  @override
  String get notifications_errorSnackBar_blindTransferFailed => 'การโอนสายล้มเหลว กำลังกลับสู่สายที่ใช้งานอยู่';

  @override
  String get notifications_errorSnackBar_appOffline => 'ขณะนี้แอปพลิเคชันของคุณออฟไลน์';

  @override
  String get notifications_errorSnackBar_appOnline => 'แอปพลิเคชันของคุณออนไลน์แล้ว';

  @override
  String get notifications_errorSnackBar_appUnregistered =>
      'ขออภัย ขณะนี้แอปพลิเคชันของคุณถูกตัดการเชื่อมต่อจากเซิร์ฟเวอร์หลักของ WebTrit จึงไม่สามารถโทรออกได้ในตอนนี้ กรุณาไปที่หน้าตั้งค่า แล้วปิดและเปิดสวิตช์สถานะออนไลน์อีกครั้งเพื่อเชื่อมต่อใหม่';

  @override
  String get notifications_errorSnackBar_callConnect => 'เชื่อมต่อกับ core ล้มเหลว กำลังพยายามเชื่อมต่อใหม่';

  @override
  String get notifications_errorSnackBar_callNegotiationTimeout =>
      'ไม่สามารถเชื่อมต่อสายได้ กรุณาลองใหม่อีกครั้งภายหลัง';

  @override
  String get notifications_errorSnackBar_generalUnableToCall => 'ไม่สามารถเชื่อมต่อการโทรได้ กรุณาลองอีกครั้งภายหลัง';

  @override
  String get notifications_errorSnackBar_callServiceBusyLine =>
      'ไม่สามารถโทรออกได้ในขณะนี้เนื่องจากสายไม่ว่าง โปรดลองอีกครั้งในภายหลัง';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect =>
      'ไม่สามารถเริ่มการโทรได้ โปรดตรวจสอบสถานะการเชื่อมต่อ';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed =>
      'เกิดข้อผิดพลาดในการยืนยันตัวตน กรุณาเข้าสู่ระบบใหม่';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'ไม่มีสายว่างสำหรับเริ่มการโทร';

  @override
  String get notifications_errorSnackBar_callMediaTrackSetup => 'การตั้งค่าการโทรล้มเหลว โปรดลองอีกครั้ง';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'ไม่สามารถเข้าถึงอุปกรณ์รับสื่อ โปรดตรวจสอบสิทธิ์ของแอป';

  @override
  String get notifications_errorSnackBar_callWhileOffline => 'ไม่สามารถเริ่มการโทรได้ กรุณาตรวจสอบสถานะการเชื่อมต่อ';

  @override
  String get notifications_errorSnackBar_callWhileUnregistered =>
      'ขณะนี้คุณไม่สามารถโทรออกได้ โปรดตรวจสอบสถานะบัญชีของคุณหรือติดต่อฝ่ายสนับสนุน';

  @override
  String get notifications_errorSnackBar_sessionExpired => 'เซสชันของคุณหมดอายุแล้ว กรุณาเข้าสู่ระบบอีกครั้ง';

  @override
  String get notifications_errorSnackBar_accountNotFound =>
      'ไม่พบบัญชีของคุณ อาจถูกปิดใช้งานหรือถูกลบ กรุณาติดต่อผู้ดูแลระบบของคุณ';

  @override
  String get notifications_errorSnackBar_SignalingConnectFailed =>
      'การเชื่อมต่อกับ core ล้มเหลว กำลังพยายามเชื่อมต่อใหม่';

  @override
  String notifications_errorSnackBar_signalingDisconnectWithCodeName(String codeName) {
    return 'ถูกตัดการเชื่อมต่อจาก core ด้วยรหัส: $codeName';
  }

  @override
  String notifications_errorSnackBar_signalingDisconnectWithSystemReason(String reason) {
    return 'ตัดการเชื่อมต่อจาก core เนื่องจากสาเหตุต่อไปนี้: $reason';
  }

  @override
  String notifications_errorSnackBar_emergencyNumber(String number) {
    return '$number เป็นหมายเลขฉุกเฉินและไม่สามารถโทรออกจากแอปได้';
  }

  @override
  String get notifications_errorSnackBarAction_emergencyNumber => 'เปิดแป้นโทร';

  @override
  String get notifications_errorSnackBar_SignalingSessionMissed => 'เกิดข้อผิดพลาดในการยืนยันตัวตน โปรดเข้าสู่ระบบใหม่';

  @override
  String get notifications_errorSnackBar_sipRegistrationFailed_Unavailable =>
      'การลงทะเบียนกับระบบ VoIP ระยะไกลล้มเหลว บริการไม่พร้อมใช้งาน';

  @override
  String get notifications_errorSnackBar_sipRegistrationFailed_Unexpected =>
      'การลงทะเบียนกับระบบ VoIP ระยะไกลล้มเหลวเนื่องจากข้อผิดพลาดที่ไม่คาดคิด';

  @override
  String notifications_errorSnackBar_sipRegistrationFailed_WithSystemReason(String reason) {
    return 'การลงทะเบียนกับระบบ VoIP ปลายทางล้มเหลวด้วยเหตุผลต่อไปนี้: $reason';
  }

  @override
  String get notifications_errorSnackBar_sipServiceUnavailable => 'เกิดข้อผิดพลาดในการยืนยันตัวตนกับระบบ VoIP ระยะไกล';

  @override
  String get notifications_messageSnackBar_appOffline => 'แอปพลิเคชันของคุณออฟไลน์อยู่ในขณะนี้';

  @override
  String get notifications_successSnackBar_appOnline => 'แอปพลิเคชันของคุณออนไลน์อยู่';

  @override
  String get notifications_missedCall_title => 'สายที่ไม่ได้รับ';

  @override
  String get notifications_missedCall_unknownCaller => 'ไม่ทราบ';

  @override
  String get numberActions_audioCall => 'โทรด้วยเสียง';

  @override
  String numberActions_callFrom(String number) {
    return 'โทรจาก $number';
  }

  @override
  String get numberActions_callLog => 'ดูประวัติการโทร';

  @override
  String get numberActions_chat => 'ส่งข้อความแชท';

  @override
  String get numberActions_copyCallId => 'คัดลอกรหัสสาย';

  @override
  String get numberActions_copyNumber => 'คัดลอกหมายเลข';

  @override
  String get numberActions_delete => 'ลบ';

  @override
  String get numberActions_sendSms => 'ส่งข้อความ SMS';

  @override
  String get numberActions_transfer => 'โอนสายปัจจุบัน';

  @override
  String get numberActions_videoCall => 'วิดีโอคอล';

  @override
  String get numberActions_viewContact => 'ดูรายชื่อติดต่อ';

  @override
  String get permission_Button_request => 'ดำเนินการต่อ';

  @override
  String get permission_manageFullScreenNotificationInstructions_step1 => 'ไปที่การตั้งค่าของโทรศัพท์';

  @override
  String get permission_manageFullScreenNotificationInstructions_step2 =>
      'ไปที่ \'Special App Access\' ในส่วน \'Apps & notifications\'';

  @override
  String get permission_manageFullScreenNotificationInstructions_step3 =>
      'ค้นหาและแตะที่ \'จัดการ intent แบบเต็มหน้าจอ\'';

  @override
  String get permission_manageFullScreenNotificationInstructions_step4 =>
      'เลือกแอปที่คุณต้องการจัดการการแจ้งเตือนแบบเต็มหน้าจอ';

  @override
  String get permission_manageFullScreenNotificationInstructions_step5 =>
      'สลับสิทธิ์เพื่อเปิดหรือปิดการแจ้งเตือนแบบเต็มหน้าจอสำหรับแอปนั้น';

  @override
  String get permission_manageFullScreenNotificationPermissions => 'จัดการสิทธิ์การแจ้งเตือนแบบเต็มหน้าจอ';

  @override
  String get permission_manufacturer_Button_gotIt => 'เข้าใจแล้ว';

  @override
  String get permission_manufacturer_Button_toSettings => 'เปิดการตั้งค่าแอป';

  @override
  String get permission_manufacturer_Text_heading =>
      'เพื่อมอบประสบการณ์การใช้งานที่ดีที่สุด แอปจำเป็นต้องได้รับอนุญาตสิทธิ์ต่อไปนี้ด้วยตนเอง:';

  @override
  String get permission_manufacturer_Text_trailing => 'สามารถเปลี่ยนสิทธิ์ได้ทุกเมื่อในอนาคต';

  @override
  String get permission_manufacturer_Text_xiaomi_tip1 => 'ไปที่ \"การตั้งค่าแอป\" → \"การแจ้งเตือน\"';

  @override
  String get permission_manufacturer_Text_xiaomi_tip2 => 'ค้นหาและเปิดใช้งาน \"Lockscreen notifications\"';

  @override
  String get permission_manufacturer_Text_xiaomi_tip3 =>
      'เปิดใช้งาน \"แสดงบนหน้าจอล็อก\" เพื่อให้สายเรียกเข้าแสดงบนหน้าจอล็อกได้';

  @override
  String get permission_Text_description =>
      'เพื่อมอบประสบการณ์การใช้งานที่ดีที่สุด แอปจำเป็นต้องได้รับสิทธิ์ต่อไปนี้: ไมโครโฟนสำหรับการโทรด้วยเสียง กล้องสำหรับการโทรวิดีโอ และรายชื่อติดต่อเพื่อให้ติดต่อได้ง่ายจากแอป\n\nคุณสามารถเปลี่ยนสิทธิ์เหล่านี้ได้ตลอดเวลาในภายหลัง';

  @override
  String get persistentConnectionReminderContent =>
      'คุณต้องเปิดแอปด้วยตนเองอย่างน้อยหนึ่งครั้งหลังจากที่โทรศัพท์รีสตาร์ท เพื่อสร้างการเชื่อมต่อถาวรขึ้นใหม่และรับสายเรียกเข้า';

  @override
  String get persistentConnectionReminderTitle => 'การแจ้งเตือนสำคัญ';

  @override
  String get batteryOptimizationWarningTitle => 'การปรับแต่งแบตเตอรี่กำลังทำงาน';

  @override
  String get batteryOptimizationWarningContent =>
      'การปรับแต่งแบตเตอรี่กำลังทำงานอยู่บนอุปกรณ์นี้ ซึ่งอาจทำให้พลาดสายเมื่อหน้าจอดับ ปิดการตั้งค่านี้เพื่อรักษาการเชื่อมต่อให้คงอยู่ตลอด';

  @override
  String get batteryOptimizationWarningOpenSettings => 'เปิดการตั้งค่า';

  @override
  String get presence_activity_appointment_name => 'อยู่ในนัดหมาย';

  @override
  String get presence_activity_away_name => 'ไม่อยู่';

  @override
  String get presence_activity_busy_name => 'ไม่ว่าง';

  @override
  String get presence_activity_doNotDisturb_name => 'ห้ามรบกวน';

  @override
  String get presence_activity_inTransit_name => 'อยู่ระหว่างเดินทาง';

  @override
  String get presence_activity_meal_name => 'กำลังรับประทานอาหาร';

  @override
  String get presence_activity_meeting_name => 'อยู่ในการประชุม';

  @override
  String get presence_activity_none_name => 'ไม่มี';

  @override
  String get presence_activity_onThePhone_name => 'กำลังคุยสาย';

  @override
  String get presence_activity_permanentAbsence_name => 'ไม่อยู่ถาวร';

  @override
  String get presence_activity_sleeping_name => 'กำลังนอนหลับ';

  @override
  String get presence_activity_travel_name => 'กำลังเดินทาง';

  @override
  String get presence_activity_vacation_name => 'ลาพักร้อน';

  @override
  String get presence_infoView_activity => 'กิจกรรม:';

  @override
  String get presence_infoView_available => 'พร้อมใช้งาน:';

  @override
  String get presence_infoView_available_false => 'ติดต่อไม่ได้';

  @override
  String get presence_infoView_available_true => 'ว่าง';

  @override
  String get presence_infoView_client => 'ไคลเอนต์:';

  @override
  String get presence_infoView_device => 'อุปกรณ์:';

  @override
  String get presence_infoView_localTime => 'เวลาท้องถิ่น:';

  @override
  String get presence_infoView_note => 'หมายเหตุ:';

  @override
  String get presence_infoView_statusIcon => 'ไอคอนสถานะ:';

  @override
  String get presence_infoView_timeZone => 'เขตเวลา:';

  @override
  String get presence_infoView_title => 'ข้อมูลสถานะการแสดงตน:';

  @override
  String get presence_infoView_updated => 'อัปเดตเมื่อ:';

  @override
  String presence_infoView_source(Object source) {
    return 'แหล่งที่มา: $source';
  }

  @override
  String get presence_infoView_source_direct => 'โดยตรง';

  @override
  String get presence_infoView_source_sip => 'sip';

  @override
  String get presence_infoView_source_sipAndDirect => 'sip และ direct';

  @override
  String get presence_preset_absent_name => 'ไม่อยู่';

  @override
  String get presence_preset_absent_note => 'ไม่อยู่';

  @override
  String get presence_preset_appointment_name => 'นัดหมาย';

  @override
  String get presence_preset_appointment_note => 'มีนัดหมาย';

  @override
  String get presence_preset_available_name => 'ว่าง';

  @override
  String get presence_preset_away_name => 'ไม่อยู่';

  @override
  String get presence_preset_away_note => 'ไม่อยู่';

  @override
  String get presence_preset_dnd_name => 'ห้ามรบกวน';

  @override
  String get presence_preset_dnd_note => 'ห้ามรบกวน';

  @override
  String get presence_preset_inTransit_name => 'เดินทาง';

  @override
  String get presence_preset_inTransit_note => 'อยู่ระหว่างเดินทาง';

  @override
  String get presence_preset_meal_name => 'มื้ออาหาร';

  @override
  String get presence_preset_meal_note => 'กำลังรับประทานอาหาร';

  @override
  String get presence_preset_meeting_name => 'ประชุม';

  @override
  String get presence_preset_meeting_note => 'อยู่ในการประชุม';

  @override
  String get presence_preset_sleeping_name => 'กำลังนอนหลับ';

  @override
  String get presence_preset_sleeping_note => 'กำลังนอนหลับ';

  @override
  String get presence_preset_travel_name => 'กำลังเดินทาง';

  @override
  String get presence_preset_travel_note => 'กำลังเดินทาง';

  @override
  String get presence_preset_unavailable_name => 'ไม่ว่าง';

  @override
  String get presence_preset_vacation_name => 'ลาพักร้อน';

  @override
  String get presence_preset_vacation_note => 'ลาพักร้อน';

  @override
  String get presence_settings_activity_label => 'กิจกรรม';

  @override
  String get presence_settings_activity_tooltip =>
      'อธิบายกิจกรรมปัจจุบันโดยละเอียดยิ่งขึ้น ใช้องค์ประกอบ \"activities\" ของส่วนขยาย SIP \"RPID\" ในเนื้อหา pidf (ดู RFC 4480)';

  @override
  String get presence_settings_availability_title => 'สถานะความพร้อม:';

  @override
  String get presence_settings_availability_tooltip =>
      'แสดงสถานะความพร้อมในการสื่อสารทั่วไปภายในบริการ SIP โดยใช้องค์ประกอบ \"Status\" ของ SIP ในเนื้อหา pidf ด้วยค่า \"open/closed\" (ดู RFC 3863)';

  @override
  String get presence_settings_config_title => 'การกำหนดค่า:';

  @override
  String get presence_settings_dnd_title => 'ปฏิเสธสาย (DND)';

  @override
  String get presence_settings_dnd_tooltip =>
      'เมื่อเปิดใช้งาน สายเรียกเข้าทั้งหมดจะถูกปฏิเสธโดยอัตโนมัติจากเซิร์ฟเวอร์ด้วยการตอบกลับ \"603 Declined\"';

  @override
  String get presence_settings_note_label => 'หมายเหตุ';

  @override
  String get presence_settings_note_tooltip =>
      'ข้อความสั้น ๆ ที่อธิบายรายละเอียดสถานะปัจจุบัน ใช้องค์ประกอบ \"note\" ของ SIP ในเนื้อหา pidf (ดู RFC 3863)';

  @override
  String get presence_settings_presets_label => 'เลือกค่าที่ตั้งไว้ล่วงหน้า';

  @override
  String get presence_settings_presets_label_custom => 'กำหนดเอง';

  @override
  String get presence_settings_presets_title => 'ค่าที่ตั้งไว้ล่วงหน้า:';

  @override
  String get presence_settings_statusIcon_none => 'ไม่มี';

  @override
  String get presence_settings_statusIcon_title => 'ไอคอนสถานะ:';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'ขณะนี้คุณไม่มี$filterสายที่โทรล่าสุด';
  }

  @override
  String get recents_DeleteConfirmDialog_content => 'คุณแน่ใจหรือไม่ว่าต้องการลบประวัติการโทรปัจจุบัน?';

  @override
  String get recents_DeleteConfirmDialog_title => 'ยืนยันการลบ';

  @override
  String get recents_HistoryTile_missedCallText => 'ไม่ได้รับ';

  @override
  String recents_snackBar_deleted(String name) {
    return 'ลบ $name แล้ว';
  }

  @override
  String get recents_Text_blingTransferInitiated => 'กำลังโอนสายแบบไม่รอรับ';

  @override
  String get recentsVisibilityFilter_all => 'ทั้งหมด';

  @override
  String get recentsVisibilityFilter_all_preposit => 'ทั้งหมด';

  @override
  String get recentsVisibilityFilter_incoming => 'สายเข้า';

  @override
  String get recentsVisibilityFilter_incoming_preposit => 'สายเข้า';

  @override
  String get recentsVisibilityFilter_missed => 'สายที่ไม่ได้รับ';

  @override
  String get recentsVisibilityFilter_missed_preposit => 'สายที่ไม่ได้รับ';

  @override
  String get recentsVisibilityFilter_outgoing => 'สายโทรออก';

  @override
  String get recentsVisibilityFilter_outgoing_preposit => 'โทรออก';

  @override
  String recentTimeAfterMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.yMd(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String recentTimeBeforeMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String get request_Id => 'รหัสคำขอ';

  @override
  String get request_StatusCode => 'รหัสสถานะ';

  @override
  String get request_StatusName => 'ชื่อสถานะ';

  @override
  String get sessionStatus_AppBar_waitingForNetwork => 'กำลังรอเครือข่าย...';

  @override
  String get sessionStatus_AppBar_waitingForConnection => 'กำลังรอการเชื่อมต่อ...';

  @override
  String get sessionStatus_AppBar_disconnected => 'ตัดการเชื่อมต่อแล้ว';

  @override
  String get sessionStatus_AppBar_connecting => 'กำลังเชื่อมต่อ...';

  @override
  String get sessionStatus_pushNotificationServiceProblem => 'เกิดปัญหากับการตั้งค่าบริการ push notification';

  @override
  String get session_Teardown_progressText => 'กำลังออกจากระบบ...';

  @override
  String get settings_AboutText_ApplicationEmbeddedLinks => 'ลิงก์ที่ฝังในแอปพลิเคชัน';

  @override
  String get settings_AboutText_ThirdPartyLicenses => 'ใบอนุญาตของบุคคลที่สาม';

  @override
  String get settings_AboutText_AppSessionIdentifier => 'ตัวระบุเซสชันของแอปพลิเคชัน';

  @override
  String get settings_AboutText_AppVersion => 'เวอร์ชันแอป';

  @override
  String get settings_AboutText_BundleVersion => 'เวอร์ชันบันเดิล';

  @override
  String get settings_AboutText_CallkeepVersion => 'เวอร์ชัน CallKeep';

  @override
  String get settings_AboutText_CoreVersion => 'เวอร์ชัน WebTrit Cloud Backend';

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AboutText_FCMPushNotificationToken => 'โทเค็นการแจ้งเตือนแบบพุช FCM';

  @override
  String get settings_AboutText_StoreVersion => 'เวอร์ชันบิลด์ในสโตร์';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'คุณแน่ใจหรือไม่ว่าต้องการลบบัญชี?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'ยืนยันการลบบัญชี';

  @override
  String get settings_AccountDeleteNotSupported_message => 'ขออภัย ผลิตภัณฑ์ของคุณไม่รองรับการลบบัญชี';

  @override
  String get settings_AppBarTitle_myAccount => 'บัญชีของฉัน';

  @override
  String get settings_audioProcessing_Section_AGC_title => 'ปรับระดับเสียงอัตโนมัติ';

  @override
  String get settings_audioProcessing_Section_AM_title => 'การสะท้อนเสียง';

  @override
  String get settings_audioProcessing_Section_EC_title => 'การตัดเสียงสะท้อน';

  @override
  String get settings_audioProcessing_Section_HPF_title => 'ตัวกรองความถี่สูงผ่าน';

  @override
  String get settings_audioProcessing_Section_NS_title => 'การลดเสียงรบกวน';

  @override
  String get settings_audioProcessing_Section_title => 'การประมวลผลเสียงเบื้องต้น';

  @override
  String get settings_audioProcessing_Section_tooltip =>
      'สามารถใช้เพื่อปรับคุณภาพเสียงสำหรับความต้องการหรือสภาพแวดล้อมเฉพาะ เช่น การบันทึกในสตูดิโอ หรือไมโครโฟนภายนอก \n\nข้ามการประมวลผลเสียง - สั่งให้ระบบไม่ใช้การประมวลผลเสียงด้วยฮาร์ดแวร์ (ต้องรีสตาร์ทแอป)';

  @override
  String get settings_audioProcessing_Section_VP_title => 'ข้ามการประมวลผลเสียง';

  @override
  String get settings_call_codecs_preferred_audio_default => 'อัตโนมัติ';

  @override
  String get settings_call_codecs_preferred_audio_tip =>
      'โคเดกเสียงที่ต้องการจะถูกใช้สำหรับการโทรด้วยเสียง หากอุปกรณ์ไม่รองรับโคเดกนี้ สายจะถูกเชื่อมต่อด้วยโคเดกถัดไปที่ใช้ได้';

  @override
  String get settings_call_codecs_preferred_audio_title => 'โคเดกเสียงที่ต้องการ';

  @override
  String get settings_call_codecs_preferred_video_default => 'อัตโนมัติ';

  @override
  String get settings_call_codecs_preferred_video_tip =>
      'codec วิดีโอที่ต้องการจะใช้สำหรับการโทรแบบวิดีโอ หากอุปกรณ์ไม่รองรับ codec นี้ การโทรจะใช้ codec ถัดไปที่ใช้งานได้';

  @override
  String get settings_call_codecs_preferred_video_title => 'โคเดกวิดีโอที่ต้องการ';

  @override
  String get settings_callerId_cancel_button => 'ยกเลิก';

  @override
  String get settings_callerId_defaultTitle => 'Caller ID เริ่มต้น';

  @override
  String get settings_callerId_dialcode => 'รหัสโทรออก:';

  @override
  String get settings_callerId_dialCodeMatching_title => 'การจับคู่รหัสโทร';

  @override
  String get settings_callerId_duplicate_dialcode_error => 'โปรดเลือกรหัสโทรอื่น รหัสนี้ถูกใช้งานแล้ว';

  @override
  String get settings_callerId_number => 'หมายเลข:';

  @override
  String get settings_callerId_number_hint => 'เลือกหมายเลข';

  @override
  String get settings_callerId_save_button => 'บันทึก';

  @override
  String get settings_connectionSection_title => 'การเชื่อมต่อและพฤติกรรมการโทร';

  @override
  String get settings_connectionSection_tooltip =>
      'กำหนดค่าวิธีที่อุปกรณ์ของคุณจัดการการตั้งค่าการเชื่อมต่อ การเจรจาสื่อ และการอัปเดตสายระหว่างการสื่อสารแบบ peer-to-peer';

  @override
  String get settings_encoding_AppBar_reset_tooltip => 'รีเซ็ตเป็นค่าเริ่มต้น';

  @override
  String get settings_encoding_Section_audio_ptime => 'ptime เป้าหมายของเสียง: ';

  @override
  String get settings_encoding_Section_audio_ptime_limit => 'ขีดจำกัด ptime ของเสียง: ';

  @override
  String get settings_encoding_Section_bandwidth_prefix => 'อัตราการสุ่มตัวอย่าง: ';

  @override
  String get settings_encoding_Section_bitrate_prefix => 'บิตเรต: ';

  @override
  String get settings_encoding_Section_bitrate_title => 'การตั้งค่าบิตเรตของโคเดก';

  @override
  String get settings_encoding_Section_bitrate_tooltip =>
      'ปรับการตั้งค่าบิตเรตสำหรับโคเดกเสียงและวิดีโอ ค่าที่ต่ำลงจะลดการใช้แบนด์วิดท์แต่กระทบต่อคุณภาพ ค่าที่สูงขึ้นจะเพิ่มคุณภาพแต่ก็เพิ่มการใช้แบนด์วิดท์ด้วย';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeREMBFeedback => 'ลบ REMB feedback';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeREMBFeedback_tooltip =>
      'ลบบรรทัด goog-remb RTCP feedback ออกจาก SDP ปิดการประเมินแบนด์วิดท์ฝั่งผู้รับบนบางอุปกรณ์';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback => 'ลบ TWCC feedback';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback_tooltip =>
      'ลบ transport-cc RTCP feedback และ transport-wide-cc extmap ออกจาก SDP ปิดการควบคุมความแออัดแบบ transport-wide';

  @override
  String get settings_encoding_Section_rtp_extensions_title => 'ส่วนขยาย RTP';

  @override
  String get settings_encoding_Section_rtp_extensions_tooltip =>
      'ปิดใช้ RTP header extensions แต่ละรายการจากการเจรจา SDP';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_twcc => 'TWCC';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_absSendTime => 'Abs-Send-Time';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_playoutDelay => 'Playout-Delay';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_videoContentType => 'Video-Content-Type';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_videoTiming => 'Video-Timing';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_colorSpace => 'Color-Space';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_audioLevel => 'Audio-Level';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_tOffset => 'TOffset';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_videoOrientation => 'Video-Orientation';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_rtpStreamId => 'RTP-Stream-ID';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeExtmap_repairedRtpStreamId => 'Repaired-RTP-Stream-ID';

  @override
  String get settings_encoding_Section_extra_sdp_mod_remapTE8 => 'รีแมปรหัส TE_8k เป็น 101';

  @override
  String get settings_encoding_Section_extra_sdp_mod_remapTE8_tooltip =>
      'เปลี่ยนประเภท payload TE8 เป็น 101 ใน SDP เพื่อความเข้ากันได้ที่ดีขึ้นกับ SIP endpoint บางตัว';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps => 'ลบบรรทัด rtpmap แบบสแตติก';

  @override
  String get settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps_tooltip =>
      'ลบบรรทัด static RTP map สำหรับโคเดกเสียง (เช่น PCMU, PCMA) ออกจาก SDP เพื่อลดขนาด SDP อาจช่วยแก้ปัญหาการแยกส่วน MTU บน SIP endpoint บางตัว';

  @override
  String get settings_encoding_Section_extra_sdp_mod_title => 'การปรับแต่ง SDP เพิ่มเติม';

  @override
  String get settings_encoding_Section_measure_hz => 'Hz';

  @override
  String get settings_encoding_Section_measure_kbps => 'Kbps';

  @override
  String get settings_encoding_Section_measure_ms => 'มิลลิวินาที';

  @override
  String get settings_encoding_Section_opus_bandwidth => 'กำหนดแบนด์วิดท์เอง: ';

  @override
  String get settings_encoding_Section_opus_bitrate => 'แทนที่อัตราบิต: ';

  @override
  String get settings_encoding_Section_opus_channels => 'แทนที่โหมดช่องสัญญาณ: ';

  @override
  String get settings_encoding_Section_opus_dtx => 'การแทนที่โหมด DTX: ';

  @override
  String get settings_encoding_Section_opus_samplingRate => 'แทนที่อัตราการสุ่มตัวอย่าง: ';

  @override
  String get settings_encoding_Section_opus_title => 'การปรับแต่งโคเดก Opus';

  @override
  String get settings_encoding_Section_opus_tooltip =>
      'ปรับการตั้งค่า codec เฉพาะของ opus สามารถใช้เพื่อลดการใช้แบนด์วิดท์หรือปรับปรุงคุณภาพเสียง';

  @override
  String get settings_encoding_Section_packetization_title => 'การแบ่งแพ็กเก็ตเสียง';

  @override
  String get settings_encoding_Section_packetization_tooltip =>
      'ปรับเวลาการแบ่งแพ็กเก็ตเสียงเป็นมิลลิวินาที สามารถใช้เพื่อลดความหน่วงของเสียงหรือแก้ปัญหาขนาด MTU ของเครือข่าย';

  @override
  String get settings_encoding_Section_packetization_warning_title => 'คำเตือน:';

  @override
  String get settings_encoding_Section_packetization_warning_message =>
      'โคเดกบางตัวอาจมีปัญหากับค่า ptime ที่ไม่ใช่ค่าเริ่มต้น ทำให้เกิดเสียงผิดเพี้ยนหรือเงียบ ใช้เฉพาะเมื่อคุณรู้ว่ากำลังทำอะไรอยู่';

  @override
  String get settings_encoding_Section_preset => 'ค่าที่กำหนดไว้ล่วงหน้า';

  @override
  String get settings_encoding_Section_preset_balance => 'สมดุล';

  @override
  String get settings_encoding_Section_preset_balance_tooltip => 'ปรับสมดุลระหว่างคุณภาพสายกับการใช้ข้อมูล';

  @override
  String get settings_encoding_Section_preset_eco => 'แบนด์วิดท์ต่ำ';

  @override
  String get settings_encoding_Section_preset_eco_tooltip =>
      'ใช้ข้อมูลอินเทอร์เน็ตน้อยลงและทำงานได้ดีกว่าบนการเชื่อมต่อที่ช้าหรือไม่เสถียร';

  @override
  String get settings_encoding_Section_preset_custom => 'กำหนดเอง';

  @override
  String get settings_encoding_Section_preset_custom_tooltip => 'ปรับแต่งการตั้งค่าคุณภาพสายด้วยตนเอง';

  @override
  String get settings_encoding_Section_preset_default => 'แนะนำ';

  @override
  String get settings_encoding_Section_preset_default_tooltip =>
      'การตั้งค่าคุณภาพสื่อเริ่มต้นที่เลือกไว้สำหรับแอปพลิเคชันนี้ ใช้ได้ดีกับการโทรส่วนใหญ่';

  @override
  String get settings_encoding_Section_preset_bypass => 'โหมดความเข้ากันได้';

  @override
  String get settings_encoding_Section_preset_bypass_tooltip =>
      'ข้ามการใช้การตั้งค่าคุณภาพสื่อ และใช้การตั้งค่าการโทรแบบไม่แก้ไข ช่วยแก้ปัญหาความเข้ากันได้';

  @override
  String get settings_encoding_Section_preset_full_flex => 'Full Flex';

  @override
  String get settings_encoding_Section_preset_quality => 'คุณภาพดีที่สุด';

  @override
  String get settings_encoding_Section_preset_quality_tooltip =>
      'ให้คุณภาพเสียงและวิดีโอที่ดีที่สุด ต้องใช้การเชื่อมต่ออินเทอร์เน็ตที่รวดเร็วและเสถียร';

  @override
  String get settings_encoding_Section_preset_title => 'การตั้งค่าการเข้ารหัสสื่อ';

  @override
  String get settings_encoding_Section_preset_tooltip =>
      'ค่าพรีเซ็ตการปรับแต่งสำหรับ codec เสียงและวิดีโอ ค่าที่ต่ำกว่าจะลดการใช้แบนด์วิดท์แต่กระทบคุณภาพ ค่าที่สูงกว่าจะเพิ่มคุณภาพแต่ก็เพิ่มการใช้แบนด์วิดท์ด้วย พรีเซ็ต Default คือการตั้งค่าที่แนะนำโดยผู้ให้บริการของคุณตามความเหมาะสมของสภาพแวดล้อม';

  @override
  String get settings_encoding_Section_ptime_prefix => 'Ptime: ';

  @override
  String get settings_encoding_Section_rtp_override_audio => 'การแทนที่โปรไฟล์เสียง';

  @override
  String get settings_encoding_Section_rtp_override_title => 'เปิด/ปิดและจัดลำดับโปรไฟล์ RTP ใหม่';

  @override
  String get settings_encoding_Section_rtp_override_tooltip =>
      'สามารถใช้เพื่อกำหนดลำดับความสำคัญของโปรไฟล์ rtp เสียงและวิดีโอใหม่ หรือยกเว้นบางโปรไฟล์จากรายการเจรจา SDP ซึ่งสามารถใช้เพื่อบังคับใช้โคเดกเฉพาะ หรือยกเว้นโคเดกบางตัวหากอุปกรณ์ เครือข่าย หรือระบบปลายทางรองรับได้ไม่ดี';

  @override
  String get settings_encoding_Section_rtp_override_video => 'แทนที่โปรไฟล์วิดีโอ';

  @override
  String get settings_encoding_Section_rtp_override_warning_message =>
      'การแทนที่อาจส่งผลต่อความเข้ากันได้กับอุปกรณ์หรือระบบสื่ออื่น และทำให้เกิดข้อผิดพลาดในการโทร ใช้เฉพาะเมื่อคุณรู้ว่ากำลังทำอะไรอยู่';

  @override
  String get settings_encoding_Section_rtp_override_warning_title => 'คำเตือน:';

  @override
  String get settings_encoding_Section_target_audio_bitrate => 'บิตเรตเสียงเป้าหมาย: ';

  @override
  String get settings_encoding_Section_target_video_bitrate => 'บิตเรตวิดีโอเป้าหมาย: ';

  @override
  String get settings_encoding_Section_value_auto => 'อัตโนมัติ';

  @override
  String get settings_encoding_Section_value_disable => 'ปิด';

  @override
  String get settings_encoding_Section_value_enable => 'เปิดใช้งาน';

  @override
  String get settings_encoding_Section_value_mono => 'โมโน';

  @override
  String get settings_encoding_Section_value_off => 'ปิด';

  @override
  String get settings_encoding_Section_value_on => 'เปิด';

  @override
  String get settings_encoding_Section_value_stereo => 'สเตอริโอ';

  @override
  String get settings_iceSettings_Section_netfilter_skipv4 => 'ข้าม IPv4 candidate';

  @override
  String get settings_iceSettings_Section_netfilter_skipv6 => 'ข้าม candidates แบบ IPv6';

  @override
  String get settings_iceSettings_Section_netfilter_title => 'โปรโตคอลเครือข่าย';

  @override
  String get settings_iceSettings_Section_noskip => 'ไม่กรอง';

  @override
  String get settings_iceSettings_Section_title => 'การกรองตัวเลือก ICE';

  @override
  String get settings_iceSettings_Section_tooltip =>
      'การกรองตัวเลือก ICE ตามการตั้งค่าเครือข่ายอาจช่วยหลีกเลี่ยงปัญหาเครือข่ายได้';

  @override
  String get settings_iceSettings_Section_trfilter_skipTcp => 'ข้าม TCP candidates';

  @override
  String get settings_iceSettings_Section_trfilter_skipUdp => 'ข้าม UDP candidates';

  @override
  String get settings_iceSettings_Section_trfilter_title => 'โปรโตคอลการขนส่ง';

  @override
  String get settings_ListViewTileTitle_about => 'เกี่ยวกับ';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'ลบบัญชี';

  @override
  String get settings_ListViewTileTitle_call_codecs => 'โคเดกการโทร';

  @override
  String get settings_ListViewTileTitle_cacheManagement => 'พื้นที่เก็บข้อมูลและแคช';

  @override
  String get settings_ListViewTileTitle_callerId => 'หมายเลขผู้โทร';

  @override
  String get settings_ListViewTileTitle_encoding => 'การเข้ารหัสสื่อ';

  @override
  String get settings_ListViewTileTitle_features => 'บริการ';

  @override
  String get settings_ListViewTileTitle_help => 'ช่วยเหลือ';

  @override
  String get settings_ListViewTileTitle_language => 'ภาษา';

  @override
  String get settings_ListViewTileTitle_logout => 'ออกจากระบบ';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => 'คอนโซลบันทึกล็อก';

  @override
  String get settings_ListViewTileTitle_mediaSettings => 'การตั้งค่าสื่อ';

  @override
  String get settings_ListViewTileTitle_network => 'การตั้งค่าเครือข่าย';

  @override
  String get settings_ListViewTileTitle_presence => 'SIP Presence';

  @override
  String get settings_ListViewTileTitle_registered => 'ออนไลน์';

  @override
  String get settings_ListViewTileTitle_self_config => 'หน้าตั้งค่าด้วยตนเอง';

  @override
  String get settings_ListViewTileTitle_settings => 'การตั้งค่า';

  @override
  String get settings_ListViewTileTitle_termsConditions => 'ข้อกำหนดและเงื่อนไข';

  @override
  String get settings_ListViewTileTitle_themeMode => 'โหมดธีม';

  @override
  String get settings_ListViewTileTitle_toolbox => 'กล่องเครื่องมือ';

  @override
  String get settings_ListViewTileTitle_voicemail => 'ข้อความเสียง';

  @override
  String get settings_LogoutConfirmDialog_content => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?';

  @override
  String get settings_LogoutConfirmDialog_title => 'ยืนยันการออกจากระบบ';

  @override
  String get settings_missingMicrophoneIndicator_title => 'ไม่มีสิทธิ์ใช้ไมโครโฟน ไม่สามารถโทรออกได้';

  @override
  String get settings_network_fallbackCalls_description =>
      'หากไม่ได้รับการแจ้งเตือนแบบพุชเกี่ยวกับสาย แอปจะรับ SMS พิเศษและแสดงหน้าจอสายเรียกเข้า';

  @override
  String get settings_network_fallbackCalls_title => 'สายเรียกเข้าสำรอง';

  @override
  String get settings_network_incomingCallType_pushNotification_description =>
      'เมื่อไม่ได้ใช้งานแอป แอปจะหยุดทำงานและใช้ทรัพยากรน้อยที่สุด ซึ่งช่วยประหยัดแบตเตอรี่ ระหว่างที่มีสายเรียกเข้า เซิร์ฟเวอร์จะส่ง push notification ไปยังโทรศัพท์ เพื่อให้ระบบปฏิบัติการมือถือเปิดแอปขึ้นมารับสาย อย่างไรก็ตาม วิธีนี้ไม่รับประกันว่าจะได้รับทุกสาย หากโทรศัพท์ไม่ได้ใช้งานเป็นเวลานาน Android บางเวอร์ชันอาจจำกัด push notification ซึ่งอาจทำให้คุณพลาดสายเรียกเข้าได้';

  @override
  String get settings_network_incomingCallType_pushNotification_title => 'การแจ้งเตือนแบบพุช';

  @override
  String get settings_network_incomingCallType_socket_description =>
      'แอปจะทำงานต่อในเบื้องหลังและรักษาการเชื่อมต่อกับเซิร์ฟเวอร์ไว้เสมอ ซึ่งจะเพิ่มโอกาสในการรับสายเรียกเข้า แต่อาจทำให้แบตเตอรี่หมดเร็วขึ้น';

  @override
  String get settings_network_incomingCallType_socket_title => 'การเชื่อมต่อถาวรกับเซิร์ฟเวอร์';

  @override
  String get settings_network_incomingCallType_title => 'การส่งสายเรียกเข้า';

  @override
  String get settings_network_smsFallback_toggle => 'SMS เป็นช่องทางสำรอง';

  @override
  String get settings_videoCapturing_Section_framerate_prefix => 'เฟรม: ';

  @override
  String get settings_videoCapturing_Section_framerate_title => 'อัตราเฟรมของภาพ';

  @override
  String get settings_videoCapturing_Section_resolution_prefix => 'จุดแนวตั้ง: ';

  @override
  String get settings_videoCapturing_Section_resolution_title => 'ความละเอียดของภาพ';

  @override
  String get settings_videoCapturing_Section_title => 'การจับภาพวิดีโอ';

  @override
  String get settings_videoCapturing_Section_tooltip =>
      'สามารถใช้เพื่อปรับคุณภาพวิดีโอให้เหมาะกับความต้องการหรือสภาพแวดล้อมเฉพาะ';

  @override
  String get settings_videoOffer_option_ignore =>
      'ตอบรับโดยไม่ใช้วิดีโอ\nจะไม่มีการเพิ่มแทร็กจนกว่าจะมีการเจรจาภายหลัง';

  @override
  String get settings_videoOffer_option_includeInactive =>
      'รวมแทร็กวิดีโอที่ไม่ได้ใช้งาน\nช่วยให้เข้ากันได้กับวิดีโอ offer สำหรับการเปิดใช้งานในอนาคต';

  @override
  String get settings_videoOffer_title => 'กำหนดวิธีที่อุปกรณ์นี้ตอบสนองต่อข้อเสนอที่มีวิดีโอรวมอยู่ด้วย';

  @override
  String get signalingResponseCode_ambiguousRequest => 'เราไม่สามารถเข้าใจคำขอของคุณได้';

  @override
  String get signalingResponseCode_busyEverywhere =>
      'ผู้ใช้ที่คุณพยายามติดต่อกำลังสายไม่ว่าง กรุณาลองใหม่อีกครั้งภายหลัง';

  @override
  String get signalingResponseCode_callNotExist => 'คำขอที่ไม่ตรงกับบทสนทนาหรือธุรกรรมใด ๆ\n';

  @override
  String get signalingResponseCode_declineCall => 'สายถูกปฏิเสธ';

  @override
  String get signalingResponseCode_errorAttachingPlugin =>
      'เราพบปัญหาในการเชื่อมต่อฟีเจอร์หนึ่ง โปรดลองใหม่อีกครั้งภายหลัง';

  @override
  String get signalingResponseCode_errorDetachingPlugin =>
      'เราพบปัญหาในการยกเลิกการเชื่อมต่อคุณสมบัติหนึ่ง กรุณาลองใหม่ภายหลัง';

  @override
  String get signalingResponseCode_errorSendingMessage =>
      'เราไม่สามารถส่งข้อความของคุณได้ ตรวจสอบเครือข่ายของคุณแล้วลองอีกครั้ง';

  @override
  String get signalingResponseCode_exchangeRoutingError =>
      'เราไม่พบเส้นทางในการดำเนินการตามคำขอของคุณ โปรดลองอีกครั้งในภายหลัง';

  @override
  String get signalingResponseCode_handleNotFound => 'เราไม่พบสิ่งที่คุณกำลังค้นหา โปรดลองอีกครั้ง';

  @override
  String get signalingResponseCode_incompatibleDestination => 'ปลายทางที่คุณพยายามติดต่อไม่เข้ากัน';

  @override
  String get signalingResponseCode_invalidElementType => 'มีบางอย่างไม่ถูกต้อง โปรดลองอีกครั้ง';

  @override
  String get signalingResponseCode_invalidJson => 'เกิดข้อผิดพลาดในการประมวลผลข้อมูลของคุณ กรุณาลองใหม่อีกครั้ง';

  @override
  String get signalingResponseCode_invalidJsonObject =>
      'ข้อมูลบางส่วนที่ระบุไม่ถูกต้อง กรุณาตรวจสอบอีกครั้งแล้วลองใหม่';

  @override
  String get signalingResponseCode_invalidNumberFormat => 'รูปแบบหมายเลขไม่ถูกต้อง';

  @override
  String get signalingResponseCode_invalidPath => 'การกระทำที่ร้องขอไม่พร้อมใช้งาน โปรดลองตัวเลือกอื่น';

  @override
  String get signalingResponseCode_invalidSdp => 'เราพบข้อผิดพลาดทางเทคนิค กรุณาลองใหม่ภายหลัง';

  @override
  String get signalingResponseCode_invalidStream => 'สตรีมที่ร้องขอไม่พร้อมใช้งาน โปรดลองอีกครั้ง';

  @override
  String get signalingResponseCode_loopDetected => 'เราตรวจพบลูปในการโทร โปรดลองอีกครั้ง';

  @override
  String get signalingResponseCode_missingMandatoryElement => 'ข้อมูลที่จำเป็นขาดหายไป โปรดกรอกข้อมูลที่จำเป็นทั้งหมด';

  @override
  String get signalingResponseCode_missingRequest => 'เกิดข้อผิดพลาดกับคำขอของคุณ กรุณาลองอีกครั้ง';

  @override
  String get signalingResponseCode_normalUnspecified => 'เกิดข้อผิดพลาด โปรดลองอีกครั้งในภายหลัง';

  @override
  String get signalingResponseCode_notAcceptable =>
      'สายนี้ถูกทำเครื่องหมายว่าไม่สามารถยอมรับได้ กรุณาตรวจสอบเส้นทางการโทรออกของคุณ!';

  @override
  String get signalingResponseCode_notAcceptingNewSessions =>
      'เราไม่สามารถเริ่มเซสชันใหม่ได้ในขณะนี้ กรุณาลองใหม่ภายหลัง';

  @override
  String get signalingResponseCode_notFoundRoutesInReplyFromBE =>
      'เราไม่พบเส้นทางสำหรับดำเนินการตามคำขอของคุณ โปรดลองอีกครั้งในภายหลัง';

  @override
  String get signalingResponseCode_pluginNotFound => 'ส่วนประกอบที่จำเป็นหายไป โปรดลองรีสตาร์ทแอป';

  @override
  String get signalingResponseCode_rejected => 'สายถูกปฏิเสธ';

  @override
  String get signalingResponseCode_requestTerminated => 'คำขอของคุณถูกยกเลิก โปรดลองอีกครั้ง';

  @override
  String get signalingResponseCode_sessionIdInUse => 'เซสชันนี้กำลังใช้งานอยู่แล้ว โปรดลองใช้เซสชันอื่น';

  @override
  String get signalingResponseCode_sessionNotFound => 'ไม่พบเซสชันของคุณ โปรดเข้าสู่ระบบและลองอีกครั้ง';

  @override
  String get signalingResponseCode_tokenNotFound =>
      'โทเค็นการเข้าถึงของคุณหายไปหรือไม่ถูกต้อง กรุณาเข้าสู่ระบบอีกครั้ง';

  @override
  String get signalingResponseCode_transportSpecificError =>
      'เกิดปัญหาในการเชื่อมต่อ โปรดตรวจสอบเครือข่ายของคุณและลองอีกครั้ง';

  @override
  String get signalingResponseCodeType_callHangup => 'สายถูกวางแล้ว';

  @override
  String get signalingResponseCodeType_plugin => 'ฟีเจอร์ที่จำเป็นทำงานไม่ถูกต้อง ลองรีสตาร์ทแอป';

  @override
  String get signalingResponseCodeType_request => 'มีปัญหากับคำขอของคุณ โปรดลองอีกครั้ง';

  @override
  String get signalingResponseCodeType_session => 'เกิดปัญหากับเซสชันของคุณ โปรดลงชื่อเข้าใช้ใหม่หรือรีสตาร์ทแอป';

  @override
  String get signalingResponseCodeType_token => 'โทเค็นการเข้าถึงของคุณไม่ถูกต้อง กรุณาเข้าสู่ระบบอีกครั้ง';

  @override
  String get signalingResponseCodeType_transport =>
      'เรากำลังมีปัญหาในการสื่อสารกับเซิร์ฟเวอร์ โปรดตรวจสอบการเชื่อมต่อของคุณแล้วลองอีกครั้ง';

  @override
  String get signalingResponseCodeType_unauthorized => 'คุณไม่มีสิทธิ์ที่เหมาะสม โปรดเข้าสู่ระบบหรือติดต่อฝ่ายสนับสนุน';

  @override
  String get signalingResponseCodeType_unknown => 'เกิดปัญหาที่ไม่คาดคิด โปรดลองอีกครั้งในภายหลัง';

  @override
  String get signalingResponseCodeType_webrtc => 'เกิดปัญหากับการเชื่อมต่อสาย กรุณาวางสายแล้วลองอีกครั้ง';

  @override
  String get signalingResponseCode_unauthorizedAccess =>
      'คุณไม่มีสิทธิ์เข้าถึงฟีเจอร์นี้ หากคุณคิดว่านี่เป็นข้อผิดพลาด โปรดติดต่อฝ่ายสนับสนุน';

  @override
  String get signalingResponseCode_unauthorizedRequest => 'ไม่สามารถอนุญาตคำขอของคุณได้ กรุณาลองเข้าสู่ระบบอีกครั้ง';

  @override
  String get signalingResponseCode_unexpectedAnswer => 'เราได้รับการตอบกลับที่ไม่คาดคิด กรุณาลองอีกครั้ง';

  @override
  String get signalingResponseCode_unknownError => 'เกิดข้อผิดพลาดที่ไม่คาดคิด โปรดลองอีกครั้งในภายหลัง';

  @override
  String get signalingResponseCode_unknownRequest => 'เราไม่รู้จักคำขอนั้น โปรดลองอีกครั้งหรือติดต่อฝ่ายสนับสนุน';

  @override
  String get signalingResponseCode_unsupportedJsepType => 'การตั้งค่าปัจจุบันของคุณไม่รองรับการดำเนินการนี้';

  @override
  String get signalingResponseCode_unwanted => 'ผู้รับทำเครื่องหมายว่าการโทรนี้ไม่พึงประสงค์';

  @override
  String get signalingResponseCode_userBusy => 'ผู้ใช้ไม่ว่าง';

  @override
  String get signalingResponseCode_userNotExist => 'ไม่มีผู้ใช้นี้';

  @override
  String get signalingResponseCode_unableToComplete => 'ไม่สามารถดำเนินการโทรให้เสร็จสมบูรณ์ได้';

  @override
  String get signalingResponseCode_wrongWebrtcState => 'เกิดข้อผิดพลาดเกี่ยวกับการโทร โปรดวางสายและลองอีกครั้ง';

  @override
  String get socketError_connectionRefused => 'การเชื่อมต่อถูกปฏิเสธ';

  @override
  String get socketError_connectionRefusedDescription =>
      'เซิร์ฟเวอร์ปฏิเสธการเชื่อมต่อ เซิร์ฟเวอร์อาจหยุดทำงานหรือปฏิเสธคำขอ กรุณาลองใหม่ภายหลัง';

  @override
  String get socketError_connectionReset => 'การเชื่อมต่อถูกรีเซ็ต';

  @override
  String get socketError_connectionResetDescription => 'การเชื่อมต่อถูกรีเซ็ตโดยเซิร์ฟเวอร์ โปรดลองอีกครั้ง';

  @override
  String get socketError_connectionTimedOut => 'หมดเวลาการเชื่อมต่อ';

  @override
  String get socketError_connectionTimedOutDescription =>
      'การเชื่อมต่อหมดเวลา ซึ่งอาจเกิดจากการเชื่อมต่ออินเทอร์เน็ตที่ช้าหรือไม่เสถียร โปรดตรวจสอบการเชื่อมต่อของคุณแล้วลองอีกครั้ง';

  @override
  String get socketError_default => 'ข้อผิดพลาดเครือข่าย';

  @override
  String socketError_defaultDescription(int? errorCode) {
    return 'เกิดข้อผิดพลาดเครือข่ายที่ไม่คาดคิด (รหัสข้อผิดพลาด: $errorCode) อาจเกิดจากปัญหาเครือข่ายหรือปัญหาเซิร์ฟเวอร์ โปรดลองอีกครั้งในภายหลัง';
  }

  @override
  String get socketError_networkUnreachable => 'เข้าถึงเครือข่ายไม่ได้';

  @override
  String get socketError_networkUnreachableDescription =>
      'ไม่สามารถเข้าถึงเครือข่ายได้ อาจเกิดจากการเชื่อมต่ออินเทอร์เน็ตที่อ่อน ข้อจำกัดของเครือข่ายเช่นไฟร์วอลล์ หรือการตั้งค่า DNS ที่ไม่ถูกต้อง หากคุณอยู่ในเครือข่ายของที่ทำงานหรือเครือข่ายที่ถูกจำกัด โปรดติดต่อผู้ดูแลระบบเครือข่ายของคุณ หรือลองใช้เครือข่ายอื่น';

  @override
  String get socketError_serverUnreachable => 'ไม่สามารถเข้าถึงเซิร์ฟเวอร์ได้เนื่องจากปัญหาเครือข่าย';

  @override
  String get socketError_serverUnreachableDescription =>
      'ไม่สามารถเข้าถึงเซิร์ฟเวอร์ได้ อาจเกิดจากไม่มีการเชื่อมต่ออินเทอร์เน็ตหรือเซิร์ฟเวอร์อยู่ระหว่างการบำรุงรักษา กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของคุณแล้วลองใหม่';

  @override
  String get system_notifications_screen_list_empty => 'ยังไม่มีการแจ้งเตือน';

  @override
  String get system_notifications_screen_title => 'การแจ้งเตือน';

  @override
  String get themeMode_dark => 'มืด';

  @override
  String get themeMode_light => 'สว่าง';

  @override
  String get themeMode_system => 'ระบบ';

  @override
  String get undefined_autoprovision_invalidToken =>
      'ข้อมูลรับรองการตั้งค่าอัตโนมัติถูกปฏิเสธโดยเซิร์ฟเวอร์ โปรดขอลิงก์การตั้งค่าใหม่';

  @override
  String get undefined_autoprovision_invalidToken_title => 'การกำหนดค่าไม่ถูกต้อง';

  @override
  String get undefined_stackScreenNotSupported => 'ไม่รองรับฟีเจอร์นี้ โปรดติดต่อผู้ดูแลระบบ';

  @override
  String get undefined_stackScreenNotSupported_title => 'ไม่รองรับฟีเจอร์นี้';

  @override
  String get user_agreement_agrement_link => 'ข้อกำหนดและเงื่อนไขของข้อตกลง';

  @override
  String get user_agreement_button_text => 'ดำเนินการต่อ';

  @override
  String user_agreement_checkbox_text(Object url) {
    return 'ฉันได้อ่าน $url และยอมรับเงื่อนไขแล้ว';
  }

  @override
  String user_agreement_description(Object appName) {
    return 'ยินดีต้อนรับสู่ $appName';
  }

  @override
  String get validationBlankError => 'โปรดกรอกค่า';

  @override
  String get voicemail_Cache_description =>
      'การเล่นข้อความเสียงจะเก็บสำเนาเสียงไว้ในเครื่องเพื่อเล่นซ้ำได้ทันที การล้างจะคืนพื้นที่ และเสียงจะถูกดาวน์โหลดใหม่เมื่อเล่นครั้งถัดไป';

  @override
  String get voicemail_Cache_title => 'เสียงข้อความเสียง';

  @override
  String get voicemail_Description_notSupported =>
      'core ของคุณไม่รองรับฟีเจอร์ข้อความเสียง โปรดติดต่อผู้ดูแลระบบของคุณเพื่อขอข้อมูลเพิ่มเติม';

  @override
  String get voicemail_Dialog_deleteSelectedContent =>
      'ข้อความเสียงที่เลือกจะถูกลบอย่างถาวร คุณต้องการดำเนินการต่อหรือไม่?';

  @override
  String get voicemail_Dialog_deleteSelectedTitle => 'ลบข้อความเสียงที่เลือกหรือไม่?';

  @override
  String get voicemail_Dialog_deleteSingleContent => 'ข้อความเสียงนี้จะถูกลบอย่างถาวร คุณต้องการดำเนินการต่อหรือไม่?';

  @override
  String get voicemail_Dialog_deleteSingleTitle => 'ลบข้อความเสียง?';

  @override
  String get voicemail_Label_call => 'โทร';

  @override
  String get voicemail_Label_delete => 'ลบ';

  @override
  String get voicemail_Label_deleteAll => 'ลบข้อความเสียงทั้งหมดหรือไม่';

  @override
  String get voicemail_Label_deleteAllDescription =>
      'การดำเนินการนี้จะลบข้อความเสียงทั้งหมดของคุณอย่างถาวร ไม่สามารถยกเลิกได้';

  @override
  String get voicemail_Label_empty => 'ไม่มีข้อความเสียง';

  @override
  String get voicemail_Label_markAsHeard => 'ทำเครื่องหมายว่าฟังแล้ว';

  @override
  String get voicemail_Label_markAsNew => 'ทำเครื่องหมายว่าใหม่';

  @override
  String get voicemail_Label_playbackError => 'เล่นไม่สำเร็จ';

  @override
  String get voicemail_Label_retry => 'ลองอีกครั้ง';

  @override
  String get voicemail_Snackbar_notConfigured => 'ติดต่อผู้ดูแลระบบของคุณเพื่อเปิดใช้งานข้อความเสียง';

  @override
  String get voicemail_Title_notSupported => 'ไม่รองรับฟีเจอร์นี้';

  @override
  String get voicemail_RecordsCache_description =>
      'สำเนารายการข้อความเสียงที่ดึงจากเซิร์ฟเวอร์ซึ่งเก็บไว้ในเครื่อง (ไฟล์เสียงเป็นส่วนแยกต่างหาก) การล้างจะลบรายการในเครื่อง และรายการจะถูกดาวน์โหลดใหม่เมื่อรีเฟรชครั้งถัดไป';

  @override
  String get voicemail_RecordsCache_title => 'ข้อความเสียงที่บันทึกไว้';

  @override
  String get voicemail_Transcript_inProgress => 'กำลังถอดเสียง...';

  @override
  String get voicemail_Transcript_unavailable => 'ไม่มีข้อความถอดเสียง';

  @override
  String get voicemail_TranscriptionModel_accurateSubtitle =>
      'ความแม่นยำสูงสุดบนอุปกรณ์ ช้ากว่า (ดาวน์โหลดโมเดล ~1.5 GB)';

  @override
  String get voicemail_TranscriptionModel_accurateTitle => 'แม่นยำ';

  @override
  String get voicemail_TranscriptionModel_balancedSubtitle => 'ความแม่นยำดี (ดาวน์โหลดโมเดล ~466 MB)';

  @override
  String get voicemail_TranscriptionModel_balancedTitle => 'สมดุล';

  @override
  String get voicemail_TranscriptionModel_defaultLabel => 'ค่าเริ่มต้น';

  @override
  String get voicemail_TranscriptionModel_fastSubtitle => 'ผลลัพธ์เร็ว ความแม่นยำต่ำกว่า (ดาวน์โหลดโมเดล ~142 MB)';

  @override
  String get voicemail_TranscriptionModel_fastTitle => 'เร็ว';

  @override
  String get voicemail_TranscriptionModel_note =>
      'มีผลกับการถอดเสียงใหม่ โมเดลจะถูกดาวน์โหลดเมื่อใช้งานครั้งแรก ข้อความถอดเสียงเดิมจะยังคงอยู่';

  @override
  String get voicemail_TranscriptionModel_title => 'โมเดลถอดเสียง';

  @override
  String get voicemail_Widget_screenTitle => 'ข้อความเสียง';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'ลองใหม่';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'ข้าม';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'ข้อผิดพลาดของทรัพยากรเว็บ';

  @override
  String webview_defaultError_details(String description, int code) {
    return '$description (รหัส: $code)';
  }

  @override
  String get webview_defaultError_reload => 'โหลดใหม่';

  @override
  String get webview_defaultError_title => 'เกิดข้อผิดพลาดบางอย่าง';

  @override
  String get webview_sslError_details => 'รายละเอียด';

  @override
  String get webview_sslError_details_type => 'ประเภท';

  @override
  String get webview_sslError_details_url => 'URL';

  @override
  String get webview_sslError_message => 'ใบรับรองของไซต์นี้ไม่น่าเชื่อถือ ไม่สามารถแสดงหน้านี้ได้';

  @override
  String get webview_sslError_title => 'การเชื่อมต่อของคุณไม่เป็นส่วนตัว';

  @override
  String get webview_sslError_tryAgain => 'ลองใหม่';

  @override
  String get cdr_disconnectReason_unknown => 'ไม่ทราบ';

  @override
  String get cdr_disconnectReason_validCauseCodeNotYetReceived => 'ยังไม่ได้รับรหัสสาเหตุที่ถูกต้อง';

  @override
  String get cdr_disconnectReason_unallocatedNumber => 'หมายเลขที่ไม่ได้จัดสรร (ไม่ได้กำหนด)';

  @override
  String get cdr_disconnectReason_noRouteToSpecifiedTransitNetworkWan =>
      'ไม่มีเส้นทางไปยังเครือข่ายทรานสิตที่ระบุ (WAN)';

  @override
  String get cdr_disconnectReason_noRouteToDestination => 'ไม่มีเส้นทางไปยังปลายทาง';

  @override
  String get cdr_disconnectReason_sendSpecialInformationTone => 'ส่งสัญญาณเสียงแจ้งข้อมูลพิเศษ';

  @override
  String get cdr_disconnectReason_misdialledTrunkPrefix => 'กดรหัสนำหน้าทรังก์ผิด';

  @override
  String get cdr_disconnectReason_channelUnacceptable => 'ช่องสัญญาณไม่สามารถยอมรับได้';

  @override
  String get cdr_disconnectReason_callAwardedAndBeingDeliveredInAnEstablishedChannel =>
      'สายได้รับการจัดสรรและกำลังส่งในช่องสัญญาณที่สร้างไว้แล้ว';

  @override
  String get cdr_disconnectReason_prefix0DialedButNotAllowedPreemption =>
      'กดรหัสนำหน้า 0 แต่ไม่ได้รับอนุญาต (Preemption)';

  @override
  String get cdr_disconnectReason_prefix1DialedButNotAllowedPreemptionReserved =>
      'กดรหัสนำหน้า 1 แต่ไม่ได้รับอนุญาต (สงวนสำหรับการแย่งใช้สาย)';

  @override
  String get cdr_disconnectReason_prefix1DialedButNotRequired => 'กดรหัสนำหน้า 1 แต่ไม่จำเป็น';

  @override
  String get cdr_disconnectReason_moreDigitsReceivedThanAllowedCallIsProceeding =>
      'ได้รับตัวเลขมากกว่าที่อนุญาต การโทรกำลังดำเนินต่อ';

  @override
  String get cdr_disconnectReason_normalCallClearing => 'วางสายตามปกติ';

  @override
  String get cdr_disconnectReason_userBusy => 'ผู้ใช้ไม่ว่าง';

  @override
  String get cdr_disconnectReason_noUserResponding => 'ไม่มีผู้ใช้ตอบรับ';

  @override
  String get cdr_disconnectReason_noAnswerFromUser => 'ผู้ใช้ไม่รับสาย';

  @override
  String get cdr_disconnectReason_subscriberIsAbsent => 'ไม่พบผู้ใช้บริการ';

  @override
  String get cdr_disconnectReason_callRejected => 'สายถูกปฏิเสธ';

  @override
  String get cdr_disconnectReason_numberChanged => 'หมายเลขถูกเปลี่ยน';

  @override
  String get cdr_disconnectReason_reverseChargingRejected => 'การเรียกเก็บเงินปลายทางถูกปฏิเสธ';

  @override
  String get cdr_disconnectReason_callSuspended => 'การโทรถูกระงับ';

  @override
  String get cdr_disconnectReason_callResumed => 'การโทรกลับมาดำเนินต่อ';

  @override
  String get cdr_disconnectReason_nonSelectedUserClearing => 'ผู้ใช้ที่ไม่ได้ถูกเลือกวางสาย';

  @override
  String get cdr_disconnectReason_destinationOutOfOrder => 'ปลายทางใช้งานไม่ได้';

  @override
  String get cdr_disconnectReason_invalidNumberFormatIncompleteNumber => 'รูปแบบหมายเลขไม่ถูกต้อง (หมายเลขไม่ครบ)';

  @override
  String get cdr_disconnectReason_facilityRejected => 'บริการถูกปฏิเสธ';

  @override
  String get cdr_disconnectReason_responseToStatusEnquiry => 'การตอบกลับต่อ STATUS ENQUIRY';

  @override
  String get cdr_disconnectReason_normalUnspecified => 'ปกติ ไม่ระบุ';

  @override
  String get cdr_disconnectReason_circuitOutOfOrder => 'วงจรขัดข้อง';

  @override
  String get cdr_disconnectReason_noCircuitChannelAvailable => 'ไม่มีวงจร/ช่องสัญญาณที่ว่าง';

  @override
  String get cdr_disconnectReason_destinationUnattainableRequireVpciVciIsNotAvailable =>
      'ไม่สามารถเข้าถึงปลายทางได้ (VPCI VCI ที่ต้องการไม่พร้อมใช้งาน)';

  @override
  String get cdr_disconnectReason_vpciVciAssignmentFailure => 'การกำหนด VPCI VCI ล้มเหลว';

  @override
  String get cdr_disconnectReason_degradedServiceCallRateIsnNotValid => 'บริการลดประสิทธิภาพ (อัตราการโทรไม่ถูกต้อง)';

  @override
  String get cdr_disconnectReason_networkWanOutOfOrder => 'เครือข่าย (WAN) ใช้งานไม่ได้';

  @override
  String get cdr_disconnectReason_transitDelayRangeCannotBeAchievedPermanentFrameModeIsOutOfService =>
      'ไม่สามารถบรรลุช่วงการหน่วงเวลาส่งผ่านได้ (โหมดเฟรมถาวรไม่พร้อมให้บริการ)';

  @override
  String get cdr_disconnectReason_throughputRangeCannotBeAchievedPermanentFrameModeIsOperational =>
      'ไม่สามารถทำให้อยู่ในช่วงปริมาณงานที่กำหนดได้ (โหมดเฟรมถาวรกำลังทำงาน)';

  @override
  String get cdr_disconnectReason_temporaryFailure => 'ข้อขัดข้องชั่วคราว';

  @override
  String get cdr_disconnectReason_switchingEquipmentCongestion => 'อุปกรณ์สลับสายหนาแน่น';

  @override
  String get cdr_disconnectReason_accessInformationDiscarded => 'ข้อมูลการเข้าถึงถูกละทิ้ง';

  @override
  String get cdr_disconnectReason_requestedCircuitChannelNotAvailable => 'วงจรช่องสัญญาณที่ร้องขอไม่พร้อมใช้งาน';

  @override
  String get cdr_disconnectReason_preEmptedNoVpciVciIsAvailable => 'ถูกแย่งใช้งาน (ไม่มี VPCI VCI ที่พร้อมใช้งาน)';

  @override
  String get cdr_disconnectReason_precedenceCallBlocked => 'การโทรลำดับความสำคัญถูกบล็อก';

  @override
  String get cdr_disconnectReason_resourceUnavailableUnspecified => 'ทรัพยากรไม่พร้อมใช้งาน - ไม่ระบุ';

  @override
  String get cdr_disconnectReason_dspError => 'ข้อผิดพลาด DSP';

  @override
  String get cdr_disconnectReason_qualityOfServiceUnavailable => 'ไม่มีคุณภาพการบริการ';

  @override
  String get cdr_disconnectReason_requestedFacilityNotSubscribed => 'บริการที่ร้องขอยังไม่ได้สมัครใช้งาน';

  @override
  String get cdr_disconnectReason_reverseChargingNotAllowed => 'ไม่อนุญาตให้เรียกเก็บเงินย้อนกลับ';

  @override
  String get cdr_disconnectReason_outgoingCallsBarred => 'การโทรออกถูกระงับ';

  @override
  String get cdr_disconnectReason_outgoingCallsBarredWithinCug => 'การโทรออกถูกระงับภายใน CUG';

  @override
  String get cdr_disconnectReason_incomingCallsBarred => 'สายเรียกเข้าถูกระงับ';

  @override
  String get cdr_disconnectReason_incomingCallsBarredWithinCug => 'สายเรียกเข้าถูกระงับภายใน CUG';

  @override
  String get cdr_disconnectReason_callWaitingNotSubscribed => 'ไม่ได้สมัครใช้บริการสายเรียกซ้อน';

  @override
  String get cdr_disconnectReason_bearerCapabilityNotAuthorized => 'ไม่ได้รับอนุญาตสำหรับความสามารถของช่องสัญญาณ';

  @override
  String get cdr_disconnectReason_bearerCapabilityNotPresentlyAvailable =>
      'ความสามารถของช่องสัญญาณไม่พร้อมใช้งานในขณะนี้';

  @override
  String get cdr_disconnectReason_inconsistancyInTheInformationAndClass => 'ข้อมูลและคลาสไม่สอดคล้องกัน';

  @override
  String get cdr_disconnectReason_serviceOrOptionNotAvailableUnspecified =>
      'บริการหรือตัวเลือกไม่พร้อมใช้งาน ไม่ระบุสาเหตุ';

  @override
  String get cdr_disconnectReason_bearerServiceNotImplemented => 'ไม่ได้ติดตั้ง bearer service';

  @override
  String get cdr_disconnectReason_channelTypeNotImplemented => 'ไม่รองรับประเภทช่องสัญญาณ';

  @override
  String get cdr_disconnectReason_transitNetworkSelectionNotImplemented => 'ไม่ได้ติดตั้งการเลือกเครือข่ายส่งผ่าน';

  @override
  String get cdr_disconnectReason_messageNotImplemented => 'ข้อความไม่ได้ถูกใช้งาน';

  @override
  String get cdr_disconnectReason_requestedFacilityNotImplemented => 'ฟังก์ชันที่ร้องขอยังไม่ได้ถูกนำมาใช้';

  @override
  String get cdr_disconnectReason_onlyRestrictedDigitalInformationBearerCapabilityIsAvailable =>
      'มีเฉพาะความสามารถ bearer ข้อมูลดิจิทัลแบบจำกัดเท่านั้น';

  @override
  String get cdr_disconnectReason_serviceOrOptionNotImplementedUnspecified =>
      'ยังไม่ได้นำบริการหรือตัวเลือกมาใช้งาน ไม่ระบุ';

  @override
  String get cdr_disconnectReason_invalidCallReferenceValue => 'ค่าอ้างอิงการโทรไม่ถูกต้อง';

  @override
  String get cdr_disconnectReason_identifiedChannelDoesNotExist => 'ช่องสัญญาณที่ระบุไม่มีอยู่';

  @override
  String get cdr_disconnectReason_aSuspendedCallExistsButThisCallIdentityDoesNot =>
      'มีสายที่ถูกพักอยู่ แต่ข้อมูลระบุสายนี้ไม่มีอยู่';

  @override
  String get cdr_disconnectReason_callIdentityInUse => 'รหัสประจำสายกำลังถูกใช้งาน';

  @override
  String get cdr_disconnectReason_noCallSuspended => 'ไม่มีสายที่พักไว้';

  @override
  String get cdr_disconnectReason_callHavingTheRequestedCallIdentityHasBeenCleared =>
      'สายที่มีรหัสสายที่ร้องขอถูกยกเลิกแล้ว';

  @override
  String get cdr_disconnectReason_calledUserNotMemberOfCug => 'ผู้ใช้ที่ถูกเรียกไม่ได้เป็นสมาชิกของ CUG';

  @override
  String get cdr_disconnectReason_incompatibleDestination => 'ปลายทางไม่เข้ากัน';

  @override
  String get cdr_disconnectReason_nonExistentAbbreviatedAddressEntry => 'ไม่มีรายการที่อยู่แบบย่อนี้';

  @override
  String get cdr_disconnectReason_destinationAddressMissingAndDirectCallNotSubscribed =>
      'ไม่มีที่อยู่ปลายทาง และไม่ได้สมัครใช้การโทรตรง';

  @override
  String get cdr_disconnectReason_invalidTransitNetworkSelectionNationalUse =>
      'การเลือกเครือข่ายทรานซิตไม่ถูกต้อง (ใช้ภายในประเทศ)';

  @override
  String get cdr_disconnectReason_invalidFacilityParameter => 'พารามิเตอร์ facility ไม่ถูกต้อง';

  @override
  String get cdr_disconnectReason_mandatoryInformationElementIsMissingAalParameterIsNotSupported =>
      'ขาดองค์ประกอบข้อมูลที่จำเป็น (ไม่รองรับพารามิเตอร์ AAL)';

  @override
  String get cdr_disconnectReason_invalidMessageUnspecified => 'ข้อความไม่ถูกต้อง ไม่ระบุสาเหตุ';

  @override
  String get cdr_disconnectReason_mandatoryInformationElementIsMissing => 'ขาดองค์ประกอบข้อมูลที่จำเป็น';

  @override
  String get cdr_disconnectReason_messageTypeNonExistentOrNotImplemented => 'ประเภทข้อความไม่มีอยู่หรือไม่ได้ติดตั้ง';

  @override
  String get cdr_disconnectReason_messageNotCompatibleWithCallStateOrMessageTypeNonExistentOrNotImplemented =>
      'ข้อความไม่เข้ากันกับสถานะการโทร หรือประเภทข้อความไม่มีอยู่หรือไม่ได้ถูกใช้งาน';

  @override
  String get cdr_disconnectReason_informationElementNonexistantOrNotImplemented =>
      'ไม่มี information element อยู่หรือยังไม่ได้ถูกนำมาใช้';

  @override
  String get cdr_disconnectReason_invalidInformationElementContents => 'เนื้อหาขององค์ประกอบข้อมูลไม่ถูกต้อง';

  @override
  String get cdr_disconnectReason_messageNotCompatibleWithCallState => 'ข้อความไม่เข้ากันกับสถานะการโทร';

  @override
  String get cdr_disconnectReason_recoveryOnTimerExpiry => 'กู้คืนเมื่อตัวจับเวลาหมดอายุ';

  @override
  String get cdr_disconnectReason_parameterNonExistentOrNotImplementedPassedOn =>
      'พารามิเตอร์ไม่มีอยู่หรือไม่ได้ใช้งาน - ส่งต่อไป';

  @override
  String get cdr_disconnectReason_urecognizedParameterMessageDiscarded => 'พารามิเตอร์ที่ไม่รู้จัก ข้อความถูกละทิ้ง';

  @override
  String get cdr_disconnectReason_protocolErrorUnspecified => 'ข้อผิดพลาดโปรโตคอล ไม่ระบุสาเหตุ';

  @override
  String get cdr_disconnectReason_internetworkingUnspecified => 'การเชื่อมโยงระหว่างเครือข่าย ไม่ระบุ';

  @override
  String get cdr_disconnectReason_nextNodeIsUnreachable => 'ไม่สามารถเข้าถึงโหนดถัดไปได้';

  @override
  String get cdr_disconnectReason_holstTelephonyServiceProviderModuleHtspmIsOutOfService =>
      'โมดูลผู้ให้บริการโทรศัพท์ Holst (HTSPM) ไม่อยู่ในสถานะให้บริการ';

  @override
  String get cdr_disconnectReason_dtlTransitIsNotMyNodeId => 'DTL transit ไม่ใช่ node ID ของฉัน';

  @override
  String get devTools_AppBarTitle => 'เครื่องมือนักพัฒนา';

  @override
  String get devTools_signalingService_groupTitle => 'บริการส่งสัญญาณ';

  @override
  String get devTools_signalingService_simulateKill_title => 'จำลองการปิดบริการ';

  @override
  String get devTools_signalingService_simulateKill_subtitle => 'หยุดบริการเบื้องหน้าโดยไม่ตัดการเชื่อมต่ออย่างถูกต้อง';

  @override
  String get devTools_signalingService_simulateKill_confirmMessage =>
      'บริการสัญญาณจะหยุดทำงานทันที และจะเริ่มทำงานใหม่โดยอัตโนมัติหากข้อมูลรับรองถูกต้อง';

  @override
  String get devTools_signalingService_simulateKill_confirm => 'หยุดการทำงาน';

  @override
  String get devTools_signalingService_simulateKill_cancel => 'ยกเลิก';
}
