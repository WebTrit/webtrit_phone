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
  String get autoprovision_errorSnackBar_invalidToken => 'Автоматичні облікові дані для конфігурації були відхилені сервером. Будь ласка, подайте запит на нове посилання на конфігурацію.';

  @override
  String get autoprovision_ReloginDialog_confirm => 'Підтвердити';

  @override
  String get autoprovision_ReloginDialog_decline => 'Відмовитися';

  @override
  String get autoprovision_ReloginDialog_text => 'Ви хочете використати нові облікові дані для аутентифікації, надані у посиланні? Поточна сесія буде завершена';

  @override
  String get autoprovision_ReloginDialog_title => 'Підтвердження повторного входу';

  @override
  String get autoprovision_successSnackBar_used => 'Ваші налаштування було успішно отримано, додаток готовий до використання';

  @override
  String get call_CallActionsTooltip_accept => 'Прийняти';

  @override
  String get call_CallActionsTooltip_accept_inviteToAttendedTransfer => 'Прийняти переадресацію';

  @override
  String get call_CallActionsTooltip_attended_transfer => 'Керована переадресація виклику';

  @override
  String get call_CallActionsTooltip_decline_inviteToAttendedTransfer => 'Відхилити переадресацію';

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
  String get call_CallActionsTooltip_transfer => 'Переадресація';

  @override
  String get call_CallActionsTooltip_transfer_choose => 'Вибрати номер';

  @override
  String get call_CallActionsTooltip_unattended_transfer => 'Некерована переадресація виклику';

  @override
  String get call_CallActionsTooltip_unhold => 'Поновити дзвінок';

  @override
  String get call_CallActionsTooltip_unmute => 'Увімкнути мікрофон';

  @override
  String get call_description_held => 'На утриманні';

  @override
  String get call_description_incoming => 'Вхідний дзвінок';

  @override
  String get call_description_inviteToAttendedTransfer => 'Вас запросили приєднатися до переадресації з підтвердженням';

  @override
  String get call_description_outgoing => 'Вихідний дзвінок';

  @override
  String get call_description_requestToAttendedTransfer => 'Запит на переадрасацію';

  @override
  String get call_description_transferProcessing => 'Обробка переадресації';

  @override
  String get call_description_transfer_requested => 'Запит на переадресацію';

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
  String get callStatus_inProgress => 'Процес підключення';

  @override
  String get callStatus_ready => 'Підключення встановлено';

  @override
  String get connectToYourOwnVoIPSystem_Button_Action => 'Підключітись до власної VoIP-системи';

  @override
  String get contacts_ExternalTabButton_refresh => 'Оновити';

  @override
  String get contacts_ExternalTabText_empty => 'Немає контактів';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'Контакти не знайдено';

  @override
  String get contacts_ExternalTabText_failure => 'Не вдалося отримати контакти хмарного PBX';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'Надати доступ до контактів вашого телефону';

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
  String get contacts_Text_blingTransferInitiated => 'Безумовне переведення дзвінка';

  @override
  String get copyToClipboard_floatingSnackBar => 'Текст скопійовано';

  @override
  String get copyToClipboard_popupMenuItem => 'Скопіювати в буфер обміну';

  @override
  String get default_ClientExceptionError => 'Сталася проблема з клієнтом HTTP';

  @override
  String get default_ErrorDetails => 'Деталі помилки';

  @override
  String get default_ErrorMessage => 'Повідомлення про помилку';

  @override
  String get default_ErrorPath => 'Шлях помилки';

  @override
  String get default_ErrorTransactionId => 'Ідентифікатор транзакції';

  @override
  String get default_FormatExceptionError => 'Виникла проблема формату відповіді';

  @override
  String get default_RequestFailureError => 'Сталася помилка на сервері';

  @override
  String get default_SocketExceptionError => 'Виникла проблема з мережею';

  @override
  String get default_TlsExceptionError => 'Виникла проблема з безпековим мережевим протоколом (TLS/SSL)';

  @override
  String get default_TypeErrorError => 'Виникла проблема з відповіддю';

  @override
  String get default_UnauthorizedRequestFailureError => 'Сталася помилка несанкціонованого запиту';

  @override
  String get favorites_BodyCenter_empty => 'Наразі у вас немає обраних номерів.\nДодайте обрані номери з Контактів, використовуючи іконку зірочки';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Ви впевнені, що хочете видалити поточний обраний номер?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Підтвердити видалення';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name видалено';
  }

  @override
  String get favorites_Text_blingTransferInitiated => 'Безумовне переведення дзвінка';

  @override
  String get inviteFriends_Dialog_close => 'Приховати це повідомлення';

  @override
  String get inviteFriends_Dialog_invite => 'Запросити';

  @override
  String get inviteFriends_Dialog_title => 'Запросити друзів спробувати WebTrit';

  @override
  String get locale_default => 'За замовчуванням';

  @override
  String get locale_en => 'Англійська';

  @override
  String get locale_it => 'Італійська';

  @override
  String get locale_uk => 'Українська';

  @override
  String get login_Button_coreUrlAssignProceed => 'Продовжити';

  @override
  String get login_Button_otpSigninRequestProceed => 'Продовжити';

  @override
  String get login_Button_otpSigninVerifyProceed => 'Перевірити';

  @override
  String get login_Button_otpSigninVerifyRepeat => 'Повторно надіслати код';

  @override
  String login_Button_otpSigninVerifyRepeatInterval(int seconds) {
    return 'Повторно надіслати код ($seconds с)';
  }

  @override
  String get login_Button_passwordSigninProceed => 'Продовжити';

  @override
  String get login_Button_signIn => 'Увійти';

  @override
  String get login_Button_signupRequestProceed => 'Продовжити';

  @override
  String get login_Button_signUpToDemoInstance => 'Зареєструватися';

  @override
  String get login_Button_signupVerifyProceed => 'Перевірити';

  @override
  String get login_Button_signupVerifyRepeat => 'Повторно надіслати код';

  @override
  String login_Button_signupVerifyRepeatInterval(int seconds) {
    return 'Повторно надіслати код ($seconds с)';
  }

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Увійти до свого WebTrit Cloud Backend';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Непідтримувана версія екземпляра, будь ласка, зверніться до адміністратора вашої системи (фактична: $actual, підтримувана: $supportedConstraint)';
  }

  @override
  String get login_requestCredentials_button => 'Зареєструватися';

  @override
  String get login_requestCredentials_DialogContent => 'Будь ласка, надайте базову інформацію і зазначте у повідомленні, що ви хотіли б отримати обліковий запис. Наші адміністратори перевірять інформацію і надішлють деталі облікового запису на вашу електронну пошту.';

  @override
  String get login_requestCredentials_DialogTitle => 'Запит на обліковий запис';

  @override
  String get login_requestCredentials_title => 'Зареєструватися';

  @override
  String get login_RequestFailureEmptyEmailError => 'Не вдалося відправити код підтвердження';

  @override
  String get login_RequestFailureIdentifierIsNotValid => 'Ідентифікатор недійсний, або не існує';

  @override
  String get login_RequestFailureIncorrectOtpCodeError => 'Невірний код підтвердження';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Перевірка вже пройдена';

  @override
  String get login_RequestFailureOtpExpiredError => 'Термін дії перевірки закінчився';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Код верифікації не знайдено';

  @override
  String get login_RequestFailureOtpVerificationAttemptsExceededError => 'Перевищено кількість спроб підтвердження';

  @override
  String get login_RequestFailureParametersApplyIssueError => 'Надані дані не можуть бути оброблені';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Номер телефону не знайдено';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'Помилка конфігурації сервера додатка - сповістіть свого постачальника послуг';

  @override
  String get login_SupportedLoginTypeMissedExceptionError => 'Поточний WebTrit Cloud Backend не підтримує жодного типу входу, сумісного з цим додатком';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Якщо у вас ще немає власного екземпляра WebTrit, зв\'яжіться з відділом продажів за адресою $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'Щоб робити дзвінки через вашу власну систему VoIP, будь ласка, введіть URL WebTrit Cloud Backend (як це було надано вашим менеджером) нижче.';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Введіть URL вашого WebTrit Cloud Backend';

  @override
  String get login_TextFieldLabelText_otpSigninCode => 'Введіть код підтвердження';

  @override
  String get login_TextFieldLabelText_otpSigninUserRef => 'Введіть свій номер телефону чи електронну пошту';

  @override
  String get login_TextFieldLabelText_passwordSigninPassword => 'Введіть ваш пароль';

  @override
  String get login_TextFieldLabelText_passwordSigninUserRef => 'Введіть свій номер телефону чи електронну пошту';

  @override
  String get login_TextFieldLabelText_signupCode => 'Введіть код підтвердження';

  @override
  String get login_TextFieldLabelText_signupEmail => 'Введіть свою електронну пошту';

  @override
  String get login_Text_otpSigninRequestPostDescription => '';

  @override
  String get login_Text_otpSigninRequestPreDescription => '';

  @override
  String login_Text_otpSigninVerifyPostDescriptionFromEmail(String email) {
    return 'Якщо ви не бачите електронного листа з кодом підтвердження від $email у своїй скринці вхідних, будь ласка, перевірте папку спаму.';
  }

  @override
  String get login_Text_otpSigninVerifyPostDescriptionGeneral => 'Якщо ви не бачите електронного листа з кодом підтвердження у своїй скринці вхідних, будь ласка, перевірте папку спаму.';

  @override
  String login_Text_otpSigninVerifyPreDescriptionUserRef(String userRef) {
    return 'На електронну пошту, прив\'язану до наданого номера телефону чи електронної пошти, надіслано одноразовий код підтвердження.';
  }

  @override
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return 'На електронну пошту, прив\'язану до телефону tel:$phone, надіслано одноразовий код підтвердження.';
  }

  @override
  String get login_Text_passwordSigninPostDescription => '';

  @override
  String get login_Text_passwordSigninPreDescription => '';

  @override
  String get login_Text_signupRequestPostDescription => '';

  @override
  String get login_Text_signupRequestPostDescriptionDemo => 'Якщо у вас ще немає облікового запису, він буде автоматично створений';

  @override
  String get login_Text_signupRequestPreDescription => '';

  @override
  String get login_Text_signupRequestPreDescriptionDemo => '';

  @override
  String login_Text_signupVerifyPostDescriptionFromEmail(String email) {
    return 'Якщо ви не бачите електронного листа з кодом підтвердження від $email у своїй скринці вхідних, будь ласка, перевірте папку спаму.';
  }

  @override
  String get login_Text_signupVerifyPostDescriptionGeneral => 'Якщо ви не бачите електронного листа з кодом підтвердження у своїй скринці вхідних, будь ласка, перевірте папку спаму.';

  @override
  String login_Text_signupVerifyPreDescriptionEmail(String email) {
    return 'На $email надіслано одноразовий код підтвердження.';
  }

  @override
  String get loginType_otpSignin => 'Увійти за OTP';

  @override
  String get loginType_passwordSignin => 'Вхід за паролем';

  @override
  String get loginType_signup => 'Зареєструватися';

  @override
  String get login_validationCoreUrlError => 'Будь ласка, введіть правильний URL';

  @override
  String get login_validationEmailError => 'Будь ласка, введіть правильну електронну пошту';

  @override
  String get login_validationPhoneError => 'Будь ласка, введіть правильний номер телефону';

  @override
  String get login_validationUserRefError => 'Будь ласка, введіть правильний номер телефону чи електронну пошту';

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
  String get main_BottomNavigationBarItemLabel_chats => 'Чати';

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
  String get notifications_errorSnackBar_appOffline => 'Ваш додаток зараз офлайн.';

  @override
  String get notifications_errorSnackBar_appOnline => 'Ваш додаток онлайн.';

  @override
  String get notifications_errorSnackBar_appUnregistered => 'Вибачте, ваш додаток наразі відключений від серверів WebTrit та не може здійснювати запити. Будь ласка, перейдіть на сторінку налаштувань і перемістіть вимикач стану онлайн у вимкнути й увімкнути знову, щоб відновити з\'єднання.';

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
  String get permission_manufacturer_Button_gotIt => 'Зрозуміло';

  @override
  String get permission_manufacturer_Button_toSettings => 'Відкрийте налаштування програми';

  @override
  String get permission_manufacturer_Text_heading => 'Щоб забезпечити найкращу взаємодію з користувачем, програмі потрібно вручну надати такі дозволи:';

  @override
  String get permission_manufacturer_Text_trailing => 'Дозволи можуть бути змінені в будь-який час у майбутньому.';

  @override
  String get permission_manufacturer_Text_xiaomi_tip1 => '1. Перейдіть у «Налаштування програми» → «Сповіщення».';

  @override
  String get permission_manufacturer_Text_xiaomi_tip2 => '2. Знайдіть і ввімкніть «Сповіщення на екрані блокування».';

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
  String get recents_Text_blingTransferInitiated => 'Безумовне переведення дзвінка';

  @override
  String get recentsVisibilityFilter_all => 'Всі';

  @override
  String get recentsVisibilityFilter_all_preposit => 'всі';

  @override
  String get recentsVisibilityFilter_incoming => 'Вхідні';

  @override
  String get recentsVisibilityFilter_incoming_preposit => 'вхідні';

  @override
  String get recentsVisibilityFilter_missed => 'Пропущені';

  @override
  String get recentsVisibilityFilter_missed_preposit => 'пропущені';

  @override
  String get recentsVisibilityFilter_outgoing => 'Вихідні';

  @override
  String get recentsVisibilityFilter_outgoing_preposit => 'вихідні';

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
  String get request_Id => 'Ідентифікатор запиту';

  @override
  String get request_StatusCode => 'Код статусу запиту';

  @override
  String get settings_AboutText_AppVersion => 'Версія додатка';

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AboutText_StoreVersion => 'Версія збірки в магазині';

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
  String get settings_ListViewTileTitle_registered => 'Зареєстровано';

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
  String get undefine_DeeplinkConfigurationInvalid_text => 'Облікові дані автоматичної конфігурації недійсні, увійдіть';

  @override
  String get underDevelopment => 'Ця сторінка знаходиться в розробці.';

  @override
  String get user_agreement_agrement_link => 'угодою';

  @override
  String get user_agreement_button_text => 'Продовжити';

  @override
  String user_agreement_checkbox_text(Object url) {
    return 'Я прочитав $url і погоджуюся з умовами';
  }

  @override
  String user_agreement_description(Object appName) {
    return 'Ласкаво просимо до $appName';
  }

  @override
  String get validationBlankError => 'Будь ласка, введіть значення';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_demo => 'Demo';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Retry';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Skip';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Web resource error';

  @override
  String get chats_Conversation_failure => 'Помилка завантаження розмови';

  @override
  String get chats_ActionBtn_retry => 'Повторить спробу';

  @override
  String get chats_MessageView_textcopy => 'Копіювати в буфер обміну';

  @override
  String get chats_MessageView_reply => 'Відповісти';

  @override
  String get chats_MessageView_forward => 'Переслати';

  @override
  String get chats_MessageView_edit => 'Редагувати';

  @override
  String get chats_MessageView_delete => 'Видалити';

  @override
  String get chats_MessageView_forwarded => '[переслано]';

  @override
  String get chats_MessageView_edited => '[відредаговано]';

  @override
  String get chats_MessageView_deleted => '[видалено]';

  @override
  String get chats_SmsSendingStatus_waiting => 'очікування';

  @override
  String get chats_SmsSendingStatus_sent => 'надіслано';

  @override
  String get chats_SmsSendingStatus_failed => 'не вдалось';

  @override
  String get chats_SmsSendingStatus_delivered => 'доставлено';

  @override
  String get chats_ParticipantName_you => 'Ви';

  @override
  String get chats_StateBar_initializing => 'ІНІЦІАЛІЗАЦІЯ';

  @override
  String get chats_StateBar_connecting => 'ПІДКЛЮЧЕННЯ';

  @override
  String get chats_StateBar_error => 'ВІДКЛЮЧЕНО';

  @override
  String get chats_ConversationsScreen_startDialog => 'Почати діалог';

  @override
  String get chats_ConversationsScreen_empty => 'Немає переписок';

  @override
  String get chats_ConversationsScreen_messages_title => 'Повідомлення';

  @override
  String get chats_ConversationsScreen_smses_title => 'SMS';

  @override
  String get chats_ConversationsScreen_selectNumberSheet_title => 'Виберіть номер';

  @override
  String get chats_ConversationsScreen_noNumberAlert_title => 'Немає номера телефону';

  @override
  String get chats_ConversationsScreen_noNumberAlert_text => 'Щоб надсилати SMS-повідомлення, потрібно мати номер телефону, прив’язаний до вашого облікового запису';

  @override
  String get chats_Conversations_tile_empty => 'Поки немає повідомлень';

  @override
  String get chats_Conversations_tile_you => 'Ви';

  @override
  String get chats_MessageListView_field_hint => 'Введіть повідомлення';

  @override
  String get chats_ConversationScreen_titlePrefix => 'Діалог:';

  @override
  String get chats_ConversationScreen_deleteDialog => 'Видалити діалог';

  @override
  String get chats_ConversationScreen_deleteAsk => 'Ви впевнені, що хочете видалити цей діалог?';

  @override
  String get chats_NewConversation_createGroup => 'Створити групу';

  @override
  String get chats_NewConversation_title => 'Новий чат';

  @override
  String get chats_NewConversation_cancel => 'Скасувати';

  @override
  String get chats_NewConversation_create => 'Створити';

  @override
  String get chats_NewConversation_externalContacts_heading => 'Контакти Хмарної АТС';

  @override
  String get chats_NewConversation_localContacts_heading => 'Локальні контакти';

  @override
  String get chats_NewConversation_contactSearch_hint => 'Пошук контактів';

  @override
  String get chats_NewConversation_contactOrNumberSearch_hint => 'Знайдіть або введіть номер телефону';

  @override
  String get chats_NewConversation_invite_heading => 'Запросити користувачів:';

  @override
  String get chats_NewConversation_next_action => 'Далі';

  @override
  String get chats_NewConversation_back_action => 'Назад';

  @override
  String get chats_GroupScreen_titlePrefix => 'Група:';

  @override
  String get chats_AddContactDialog_title => 'Виберіть контакт:';

  @override
  String get chats_AddContactDialog_empty => 'Контакти не знайдено';

  @override
  String get chats_AddContactDialog_cancel => 'Скасувати';

  @override
  String get chats_ConfirmDialog_ask => 'Ви впевнені?';

  @override
  String get chats_ConfirmDialog_confirm => 'Так';

  @override
  String get chats_ConfirmDialog_cancel => 'Ні';

  @override
  String get chats_GroupAuthorities_noauthorities => 'учасник';

  @override
  String get chats_GroupAuthorities_moderator => 'модератор';

  @override
  String get chats_GroupAuthorities_owner => 'власник';

  @override
  String get chats_GroupInfo_title => 'Інформація про групу';

  @override
  String get chats_GroupInfo_leaveAsk => 'Ви впевнені, що бажаєте залишити цю групу?';

  @override
  String get chats_GroupInfo_leaveAndDeleteAsk => 'Ви впевнені, що бажаєте залишити та видалити цю групу?';

  @override
  String get chats_GroupInfo_removeUserAsk => 'Ви впевнені, що хочете видалити цього користувача з групи?';

  @override
  String get chats_GroupInfo_makeModeratorAsk => 'Ви впевнені, що хочете зробити цього користувача модератором?';

  @override
  String get chats_GroupInfo_removeModeratorAsk => 'Ви впевнені, що хочете видалити цього користувача з модераторів?';

  @override
  String get chats_GroupInfo_titlePrefix => 'Група:';

  @override
  String get chats_GroupInfo_groupMembersHeadline => 'Члени групи';

  @override
  String get chats_GroupInfo_addUserBtnText => 'Додати користувача';

  @override
  String get chats_GroupInfo_leaveBtnText => 'Вийти з групи';

  @override
  String get chats_GroupInfo_deleteLeaveBtnText => 'Видалити і залишити';

  @override
  String get chats_GroupInfo_makeModeratorBtnText => 'Зробити модератором';

  @override
  String get chats_GroupInfo_unmakeModeratorBtnText => 'Прибрати модератора';

  @override
  String get chats_GroupInfo_removeUserBtnText => 'Видалити';

  @override
  String get chats_GroupNameDialog_title => 'Назва групи';

  @override
  String get chats_GroupNameDialog_fieldLabel => 'Назва групи';

  @override
  String get chats_GroupNameDialog_fieldHint => 'Введіть назву групи';

  @override
  String get chats_GroupNameDialog_fieldValidation_empty => 'Будь ласка, введіть назву групи';

  @override
  String get chats_GroupNameDialog_fieldValidation_short => 'Назва групи занадто коротка';

  @override
  String get chats_GroupNameDialog_saveBtnText => 'Зберегти';

  @override
  String get chats_GroupNameDialog_cancelBtnText => 'Скасувати';

  @override
  String get chats_GroupBuilderScreen_screenTitle => 'Створити групу';

  @override
  String get chats_GroupBuilderScreen_groupNameHeadline => 'Назва групи';

  @override
  String get chats_GroupBuilderScreen_membersHeadline => 'Члени групи';

  @override
  String get chats_GroupBuilderScreen_addUserBtnText => 'Додати користувача';

  @override
  String get chats_GroupBuilderScreen_submitBtnText => 'Надіслати';

  @override
  String get chats_GroupBuilderScreen_nameFieldLabel => 'Назва групи';

  @override
  String get chats_GroupBuilderScreen_nameFieldEmpty => 'Будь ласка, введіть назву групи';

  @override
  String get chats_GroupBuilderScreen_nameFieldShort => 'Назва групи має містити не менше 3 символів';

  @override
  String get chats_GroupBuilderScreen_connectionError => 'Помилка підключення, спробуйте пізніше';

  @override
  String get chats_GroupBuilderScreen_submitError => 'Під час створення групи сталася помилка, повторіть спробу';

  @override
  String get account_selfCarePasswordExpired_message => 'Термін дії вашого пароля самообслуговування минув. Оновіть його за допомогою самообслуговування.\nДоки пароль не буде змінено, доступ до служби буде обмежено.';
}
