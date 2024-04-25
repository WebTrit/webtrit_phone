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
  String get call_CallActionsTooltip_transfer_choose => 'Вибрати номер';

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
  String get call_description_transferProcessing => 'Обробка переадресації';

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
  String get contacts_Text_blingTransferInitiated => 'Сліпе переадресування';

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
  String get default_ErrorMessage => '';

  @override
  String get default_ErrorDetails => 'Details';

  @override
  String get default_ErrorPath => '';

  @override
  String get request_StatusCode => '';

  @override
  String get request_Id => '';

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
  String get favorites_Text_blingTransferInitiated => 'Сліпе переадресування';

  @override
  String get locale_default => 'За замовчуванням';

  @override
  String get locale_en => 'Англійська';

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
  String get login_ButtonTooltip_signInToYourInstance => 'Увійдіть до свого WebTrit Cloud Backend';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Непідтримувана версія екземпляра, будь ласка, зверніться до адміністратора вашої системи (фактична: $actual, підтримувана: $supportedConstraint)';
  }

  @override
  String get login_RequestFailureEmptyEmailError => 'Не вдалося відправити код підтвердження';

  @override
  String get login_RequestFailureIdentifierIsNotValid => '';

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
  String get login_RequestFailureParametersApplyIssueError => 'Надані дані не можуть бути оброблені';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Номер телефону не знайдено';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'Помилка конфігурації сервера додатка - сповістіть свого постачальника послуг';

  @override
  String get login_SupportedLoginTypeMissedExceptionError => 'Поточний WebTrit Cloud Backend не підтримує жодного типу входу, сумісного з цим додатком';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Якщо у вас ще немає власного екземпляра WebTrit, зв\'яжіться з командою продажів за адресою $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'Щоб робити дзвінки через вашу власну систему VoIP, будь ласка, введіть URL WebTrit Cloud Backend (як це було надано вашим менеджером з облікового запису) нижче.';

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
  String get login_Text_signupRequestPostDescriptionDemo => 'Якщо у вас ще немає облікового запису, він буде автоматично створений для вас.';

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
  String get notifications_errorSnackBar_appUnregistered => 'Вибачте, ваш додаток наразі відключений від основних серверів WebTrit і тому не може здійснювати дзвінки. Будь ласка, перейдіть на сторінку налаштувань та перемістіть перемикач онлайн-статусу в положення \'вимкнуто\' і знову в положення \'увімкнуто\', щоб відновити з\'єднання';

  @override
  String get notifications_errorSnackBar_appOffline => 'Ваш додаток наразі офлайн';

  @override
  String get notImplemented => 'Вибачте, ця функція ще не реалізована';

  @override
  String get permission_Button_request => 'Продовжити';

  @override
  String get permission_Text_description => 'Для забезпечення найкращого досвіду користувача програма потребує наступні дозволи: мікрофон для аудіодзвінків, камера для відеодзвінків та доступ до контактів для спрощення їх використання в програмі.\n\nДозволи можуть бути змінені у майбутньому.';

  @override
  String user_agreement_checkbox_text(String url) {
    return 'Я прочитав і погоджуюсь з $url, включаючи умови користування.';
  }

  @override
  String user_agreement_description(String appName) {
    return 'Вітаємо до $appName';
  }

  @override
  String get user_agreement_button_text => 'Продовжити';

  @override
  String get user_agreement_agrement_link => 'угодою';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'Зараз у вас немає жодних $filterостанніх дзвінків.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => 'Ви впевнені, що хочете видалити поточний журнал дзвінків?';

  @override
  String get recents_DeleteConfirmDialog_title => 'Підтвердження видалення';

  @override
  String get recents_errorSnackBar_loadFailure => 'Упс... сталася помилка ☹️';

  @override
  String get notifications_errorSnackBar_appOnline => 'Ваш додаток онлайн';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name видалено';
  }

  @override
  String get recents_Text_blingTransferInitiated => 'Сліпе переадресування';

  @override
  String get recentsVisibilityFilter_all => 'Всі';

  @override
  String get recentsVisibilityFilter_incoming => 'Вхідні';

  @override
  String get recentsVisibilityFilter_missed => 'Пропущені';

  @override
  String get recentsVisibilityFilter_outgoing => 'Вихідні';

  @override
  String get recentsVisibilityFilter_all_preposit => 'всіх';

  @override
  String get recentsVisibilityFilter_incoming_preposit => 'вхідних';

  @override
  String get recentsVisibilityFilter_missed_preposit => 'пропущених';

  @override
  String get recentsVisibilityFilter_outgoing_preposit => 'вихідних';

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
  String get settings_AboutText_AppVersion => 'Версія додатка';

  @override
  String get settings_AboutText_StoreVersion => 'Версія збірки в магазині';

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
  String get settings_ListViewTileTitle_registered => 'В мережі';

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

  @override
  String get autoprovision_ReloginDialog_title => 'Підтвердження повторного входу';

  @override
  String get autoprovision_ReloginDialog_text => 'Ви бажаєте використовувати нові облікові дані автентифікації, надані за посиланням? Ви вийдете з поточного сеансу.';

  @override
  String get autoprovision_ReloginDialog_confirm => 'Підтвердити';

  @override
  String get autoprovision_ReloginDialog_decline => 'Відхилити';

  @override
  String get autoprovision_errorSnackBar_invalidToken => 'Облікові дані авто-конфігурації були відхилені сервером. Будь ласка, надішліть запит на нове посилання авто-конфігурації';

  @override
  String get autoprovision_successSnackBar_used => 'Ваші налаштування успішно отримано, ваш додаток готовий до використання';

  @override
  String get undefine_DeeplinkConfigurationInvalid_text => 'Автоматичні налаштування облікових даних недійсні, будь ласка, увійдіть у систему';
}
