import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get alertDialogActions_no => 'Ні';

  @override
  String get alertDialogActions_ok => 'Ок';

  @override
  String get alertDialogActions_yes => 'Так';

  @override
  String get call_CallActionsTooltip_accept => 'Прийняти';

  @override
  String get call_CallActionsTooltip_disableCamera => 'Вимкнути камеру';

  @override
  String get call_CallActionsTooltip_disableSpeaker => 'Вимкнути динамік';

  @override
  String get call_CallActionsTooltip_enableCamera => 'Увімкнути камеру';

  @override
  String get call_CallActionsTooltip_enableSpeaker => 'Увімкнути динамік';

  @override
  String get call_CallActionsTooltip_hangup => 'Завершити';

  @override
  String get call_CallActionsTooltip_hangupAndAccept => 'Завершити та прийняти';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'Приховати клавіатуру';

  @override
  String get call_CallActionsTooltip_hold => 'Утримати дзвінок';

  @override
  String get call_CallActionsTooltip_holdAndAccept => 'Утримати та прийняти';

  @override
  String get call_CallActionsTooltip_mute => 'Вимкнути мікрофон';

  @override
  String get call_CallActionsTooltip_showKeypad => 'Показати клавіатуру';

  @override
  String get call_CallActionsTooltip_swap => 'Перемкнути дзвінки';

  @override
  String get call_CallActionsTooltip_transfer => 'Передати';

  @override
  String get call_CallActionsTooltip_unhold => 'Поновити дзвінок';

  @override
  String get call_CallActionsTooltip_unmute => 'Увімкнути мікрофон';

  @override
  String get call_description_held => 'На утриманні';

  @override
  String get call_description_incoming => 'Вхідний дзвінок';

  @override
  String get call_description_outgoing => 'Вихідний дзвінок';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Помилка';

  @override
  String get callStatus_appUnregistered => 'Незареєстровано';

  @override
  String get callStatus_connectError => 'Помилка підключення';

  @override
  String get callStatus_connectIssue => 'Проблема з\'єднання';

  @override
  String get callStatus_connectivityNone => 'Немає інтернет-з\'єднання';

  @override
  String get callStatus_inProgress => 'Підключення в процесі';

  @override
  String get callStatus_ready => 'Підключення встановлено';

  @override
  String get contacts_ExternalTabButton_refresh => 'Оновити';

  @override
  String get contacts_ExternalTabText_empty => 'Немає контактів';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'Контакти не знайдено';

  @override
  String get contacts_ExternalTabText_failure => 'Не вдалося отримати контакти хмарного PBX';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'Надайте доступ до контактів вашого телефону';

  @override
  String get contacts_LocalTabButton_refresh => 'Оновити';

  @override
  String get contacts_LocalTabText_empty => 'Немає контактів';

  @override
  String get contacts_LocalTabText_emptyOnSearching => 'Контакти не знайдено';

  @override
  String get contacts_LocalTabText_failure => 'Не вдалося отримати контакти вашого телефону';

  @override
  String get contacts_LocalTabText_permissionFailure => 'Відсутні дозволи на отримання контактів вашого телефону';

  @override
  String get contactsSourceExternal => 'Хмарний PBX';

  @override
  String get contactsSourceLocal => 'Ваш телефон';

  @override
  String get copyToClipboard_floatingSnackBar => 'Текст скопійовано';

  @override
  String get copyToClipboard_popupMenuItem => 'Скопіювати в буфер обміну';

  @override
  String get default_ClientExceptionError => 'Сталася проблема з клієнтом HTTP';

  @override
  String get default_FormatExceptionError => 'Виникла проблема формату відповіді';

  @override
  String get default_RequestFailureError => 'Сталася помилка на сервері';

  @override
  String get default_SocketExceptionError => 'Виникла проблема з мережею';

  @override
  String get default_TlsExceptionError => 'Виникла проблема з безпечним мережевим протоколом (TLS/SSL)';

  @override
  String get default_TypeErrorError => 'Виникла проблема з відповіддю';

  @override
  String get default_UnauthorizedRequestFailureError => 'Сталася помилка несанкціонованого запиту';

  @override
  String get favorites_BodyCenter_empty => 'Наразі у вас немає обраних номерів.\nДодайте обрані номери з Контактів, використовуючи іконку зірочки.';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Ви впевнені, що хочете видалити поточний обраний номер?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Підтвердіть видалення';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name видалено';
  }

  @override
  String get locale_default => 'За замовчуванням';

  @override
  String get locale_en => 'Англійська';

  @override
  String get locale_uk => 'Українська';

  @override
  String get login_Button_coreUrlAssignProceed => 'Продовжити';

  @override
  String get login_Button_otpRequestProceed => 'Продовжити';

  @override
  String get login_Button_otpVerifyProceed => 'Перевірити';

  @override
  String get login_Button_otpVerifyRepeat => 'Повторно надіслати код';

  @override
  String login_Button_otpVerifyRepeatInterval(int seconds) {
    return 'Повторно надіслати код ($seconds с)';
  }

  @override
  String get login_Button_signIn => 'Увійти';

  @override
  String get login_Button_signUpToDemoInstance => 'Зареєструватися';

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Увійдіть до свогоWebTrit Cloud Backend';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Непідтримувана версія екземпляра, будь ласка, зверніться до адміністратора вашої системи (фактична: $actual, підтримувана: $supportedConstraint)';
  }

  @override
  String get login_RequestFailureEmptyEmailError => 'Не вдалося відправити код підтвердження';

  @override
  String get login_RequestFailureIncorrectOtpCodeError => 'Невірний код підтвердження';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Перевірка вже пройдена';

  @override
  String get login_RequestFailureOtpExpiredError => 'Перевірка вичерпана';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Код верифікації не знайдено';

  @override
  String get login_RequestFailureOtpVerificationAttemptsExceededError => 'Перевищено кількість спроб підтвердження';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Номер телефону не знайдено';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'Помилка конфігурації сервера додатка - сповістіть свого постачальника послуг';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Якщо у вас ще немає власного екземпляра WebTrit, зв\'яжіться з командою продажів за адресою $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'Щоб робити дзвінки через вашу власну систему VoIP, будь ласка, введіть URL WebTrit Cloud Backend (як це було надано вашим менеджером з облікового запису) нижче.';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Введіть URL вашого WebTrit Cloud Backend';

  @override
  String get login_TextFieldLabelText_otpRequestEmail => 'Введіть свою електронну пошту';

  @override
  String get login_TextFieldLabelText_otpRequestPhone => 'Введіть свій номер телефону';

  @override
  String get login_TextFieldLabelText_otpVerifyCode => 'Введіть код підтвердження';

  @override
  String get login_Text_otpRequestDemoDescription => 'Якщо у вас ще немає облікового запису, він буде автоматично створений для вас.';

  @override
  String get login_Text_otpRequestDescription => '';

  @override
  String login_Text_otpVerifyCheckSpamFrom(String email) {
    return 'Якщо ви не бачите електронного листа з кодом підтвердження від $email у своїй скринці вхідних, будь ласка, перевірте папку спаму.';
  }

  @override
  String get login_Text_otpVerifyCheckSpamGeneral => 'Якщо ви не бачите електронного листа з кодом підтвердження у своїй скринці вхідних, будь ласка, перевірте папку спаму.';

  @override
  String login_Text_otpVerifySentToEmail(String email) {
    return 'На $email надіслано одноразовий код підтвердження.';
  }

  @override
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return 'На електронну пошту, прив\'язану до телефону tel:$phone, надіслано одноразовий код підтвердження.';
  }

  @override
  String get login_validationCoreUrlError => 'Будь ласка, введіть правильний URL';

  @override
  String get login_validationEmailError => 'Будь ласка, введіть правильну електронну пошту';

  @override
  String get login_validationPhoneError => 'Будь ласка, введіть правильний номер телефону';

  @override
  String get logRecordsConsole_AppBarTitle => 'Консоль журналу';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Оновити';

  @override
  String get logRecordsConsole_Text_failure => 'Виникла неочікувана помилка';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => 'Контакти';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => 'Обрані';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => 'Клавіатура';

  @override
  String get main_BottomNavigationBarItemLabel_recents => 'Останні';

  @override
  String get main_CompatibilityIssueDialogActions_logout => 'Вийти';

  @override
  String get main_CompatibilityIssueDialogActions_update => 'Оновити';

  @override
  String get main_CompatibilityIssueDialogActions_verify => 'Перевірити знову';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Несумісна версія WebTrit Cloud Backend, будь ласка, зв\'яжіться з адміністратором вашої системи.\n\nВерсія екземпляру:\n$actual\n\nПідтримувана версія:\n$supportedConstraint\n';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Проблема сумісності';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Перевірити';

  @override
  String get notifications_errorSnackBar_callConnect => 'Підключення до ядра не вдалося, спроба з\'єднання';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'Не вдається ініціювати дзвінок, перевірте статус з\'єднання';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'Поточна сесія з\'єднання недійсна, будь ласка, увійдіть знову';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'Немає вільних ліній для ініціювання дзвінка';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'Немає доступу до медіа-входу, будь ласка, перевірте дозволи програми';

  @override
  String get notImplemented => 'Вибачте, ця функція ще не реалізована';

  @override
  String get permission_Button_request => 'Продовжити';

  @override
  String get permission_Text_description => 'Для забезпечення найкращого досвіду користувача програма потребує наступні дозволи: мікрофон для аудіодзвінків, камера для відеодзвінків та доступ до контактів для спрощення їх використання в програмі.\n\nДозволи можуть бути змінені у майбутньому.';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'Зараз у вас немає жодних $filter останніх дзвінків.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => 'Ви впевнені, що хочете видалити поточний журнал дзвінків?';

  @override
  String get recents_DeleteConfirmDialog_title => 'Підтвердження видалення';

  @override
  String get recents_errorSnackBar_loadFailure => 'Упс... сталася помилка ☹️';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name видалено';
  }

  @override
  String get recentsVisibilityFilter_all => 'Всі';

  @override
  String get recentsVisibilityFilter_incoming => 'Вхідні';

  @override
  String get recentsVisibilityFilter_missed => 'Пропущені';

  @override
  String get recentsVisibilityFilter_outgoing => 'Вихідні';

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
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'Ви впевнені, що хочете видалити обліковий запис?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Підтвердіть видалення облікового запису';

  @override
  String get settings_AppBarTitle_myAccount => 'Мій обліковий запис';

  @override
  String get settings_ForceLogoutConfirmDialog_content => 'Ви впевнені, що хочете примусово вийти?';

  @override
  String get settings_ForceLogoutConfirmDialog_title => 'Підтвердіть примусовий вихід';

  @override
  String get settings_ListViewTileTitle_about => 'Про програму';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Видалити обліковий запис';

  @override
  String get settings_ListViewTileTitle_help => 'Допомога';

  @override
  String get settings_ListViewTileTitle_language => 'Мова';

  @override
  String get settings_ListViewTileTitle_logout => 'Вийти';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => 'Консоль записів журналу';

  @override
  String get settings_ListViewTileTitle_network => 'Налаштування мережі';

  @override
  String get settings_ListViewTileTitle_registered => 'Зареєстровані';

  @override
  String get settings_ListViewTileTitle_settings => 'НАЛАШТУВАННЯ';

  @override
  String get settings_ListViewTileTitle_termsConditions => 'Умови та положення';

  @override
  String get settings_ListViewTileTitle_themeMode => 'Режим теми';

  @override
  String get settings_ListViewTileTitle_toolbox => 'ІНСТРУМЕНТИ';

  @override
  String get settings_LogoutConfirmDialog_content => 'Ви впевнені, що хочете вийти?';

  @override
  String get settings_LogoutConfirmDialog_title => 'Підтвердження виходу';

  @override
  String get themeMode_dark => 'Темний';

  @override
  String get themeMode_light => 'Світлий';

  @override
  String get themeMode_system => 'Системний';

  @override
  String get underDevelopment => 'Ця сторінка знаходиться в розробці.';

  @override
  String get validationBlankError => 'Будь ласка, введіть значення';
}
