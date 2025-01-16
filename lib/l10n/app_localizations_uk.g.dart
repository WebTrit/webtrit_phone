import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get account_selfCarePasswordExpired_message => 'Термін дії вашого пароля самообслуговування минув. Оновіть його за допомогою самообслуговування.\nДоки пароль не буде змінено, доступ до служби буде обмежено.';

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
  String get call_FailureAcknowledgeDialog_title => 'Помилка';

  @override
  String get callProcessingStatus_answering => 'Прийняття виклику, будь ласка, зачекайте…';

  @override
  String get callProcessingStatus_disconnecting => 'Відключення дзвінка, будь ласка, зачекайте…';

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
  String get call_ThumbnailAvatar_currentlyNoActiveCall => 'Зараз немає активних дзвінків';

  @override
  String get common_noInternetConnection_message => 'Схоже, ви не підключені до Інтернету. Перевірте своє підключення і спробуйте ще раз.';

  @override
  String get common_noInternetConnection_retryButton => 'Спробуйте ще раз';

  @override
  String get common_noInternetConnection_title => 'Немає підключення до Інтернету';

  @override
  String get common_problemWithLoadingPage => 'Виникла проблема з завантаженням сторінки.';

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
  String get default_CannotRemoveOwnerMessagingSocketException => 'Неможливо видалити власника';

  @override
  String get default_ChatMemberNotFoundMessagingSocketException => 'Учасник чату не знайдений';

  @override
  String get default_ChatNotFoundMessagingSocketException => 'Чат не знайдено';

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
  String get default_ForbiddenMessagingSocketException => 'Доступ заборонено';

  @override
  String get default_FormatExceptionError => 'Виникла проблема формату відповіді';

  @override
  String get default_InternalErrorMessagingSocketException => 'Внутрішня помилка сервера';

  @override
  String get default_InvalidChatTypeMessagingSocketException => 'Недійсний тип чату';

  @override
  String get default_MessagingSocketException => 'Помилка з\'єднання з сервером';

  @override
  String get default_JoinCrashedMessagingSocketException => 'Під час приєднання до розмови сталася помилка';

  @override
  String get default_RequestFailureError => 'Сталася помилка на сервері';

  @override
  String get default_SelfAuthorityAssignmentForbiddenMessagingSocketException => 'Призначення власних прав заборонено';

  @override
  String get default_SelfRemovalForbiddenMessagingSocketException => 'Видалення самого себе заборонено';

  @override
  String get default_SmsConversationNotFoundMessagingSocketException => 'SMS-розмова не знайдена';

  @override
  String get default_SocketExceptionError => 'Виникла проблема з мережею';

  @override
  String get default_TimeoutExceptionError => 'Сталася проблема з таймаутом сервера';

  @override
  String get default_TimeoutMessagingSocketException => 'Час очікування відповіді сервера закінчився';

  @override
  String get default_TlsExceptionError => 'Виникла проблема з безпековим мережевим протоколом (TLS/SSL)';

  @override
  String get default_TypeErrorError => 'Виникла проблема з відповіддю';

  @override
  String get default_UnauthorizedMessagingSocketException => 'Помилка авторизації';

  @override
  String get default_UnauthorizedRequestFailureError => 'Сталася помилка несанкціонованого запиту';

  @override
  String get default_UserAlreadyInChatMessagingSocketException => 'Користувач вже в чаті';

  @override
  String default_UnknownExceptionError(String error) {
    return 'Сталася невідома помилка: $error';
  }

  @override
  String get diagnostic_AppBar_title => 'Діагностика';

  @override
  String get diagnostic_battery_groupTitle => 'Батарея';

  @override
  String get diagnostic_batteryMode_optimized_description => 'Фонова активність додатка керується системою для економії батареї. Може працювати некоректно для вхідних дзвінків, що активуються через push-сповіщення.';

  @override
  String get diagnostic_batteryMode_optimized_title => 'Оптимізовано';

  @override
  String get diagnostic_batteryMode_restricted_description => 'Фонова активність додатка суворо обмежена для збереження заряду батареї. Можливі пропущені вхідні дзвінки.';

  @override
  String get diagnostic_batteryMode_restricted_title => 'Обмежено';

  @override
  String get diagnostic_batteryMode_unknown_description => 'Статус режиму батареї невідомий. Додаток може поводитися непередбачувано.';

  @override
  String get diagnostic_batteryMode_unknown_title => 'Невідомо';

  @override
  String get diagnostic_batteryMode_unrestricted_description => 'Додаток має повний доступ для роботи у фоновому режимі без обмежень.';

  @override
  String get diagnostic_batteryMode_unrestricted_title => 'Без обмежень';

  @override
  String get diagnostic_battery_navigate_section => 'Перейдіть до розділу «Батарея»';

  @override
  String get diagnostic_battery_tile_title => 'Режим батареї';

  @override
  String get diagnostic_permission_camera_description => 'Цей додаток потребує дозволу на доступ до камери для здійснення відеодзвінків.';

  @override
  String get diagnostic_permission_camera_title => 'Камера';

  @override
  String get diagnostic_permission_contacts_description => 'Цей додаток потребує дозволу на доступ до контактів для здійснення дзвінків із вашої телефонної книги.';

  @override
  String get diagnostic_permission_contacts_title => 'Контакти';

  @override
  String get diagnosticPermissionDetails_button_managePermission => 'Керування дозволами';

  @override
  String get diagnosticPermissionDetails_button_requestPermission => 'Запит дозволу';

  @override
  String get diagnosticPermissionDetails_title_statusPermission => 'Статус дозволу';

  @override
  String get diagnostic_permission_microphone_description => 'Цей додаток потребує дозволу на доступ до мікрофона для здійснення аудіодзвінків.';

  @override
  String get diagnostic_permission_microphone_title => 'Мікрофон';

  @override
  String get diagnostic_permission_notification_description => 'Дозволяє додатку активувати вхідні дзвінки.';

  @override
  String get diagnostic_permission_notification_title => 'Сповіщення';

  @override
  String get diagnostic_permissionStatus_denied => 'Доступ заборонено';

  @override
  String get diagnostic_permissionStatus_granted => 'Доступ надано';

  @override
  String get diagnostic_permissionStatus_limited => 'Обмежений доступ';

  @override
  String get diagnostic_permissionStatus_permanentlyDenied => 'Доступ назавжди заборонено';

  @override
  String get diagnostic_permissionStatus_provisional => 'Тимчасовий доступ';

  @override
  String get diagnostic_permissionStatus_restricted => 'Обмежений доступ';

  @override
  String get diagnosticPushDetails_configuration_title => 'Налаштування служби push-сповіщень';

  @override
  String get diagnosticPushDetails_errorMessage_intro => 'Декілька кроків, які можна спробувати:\n';

  @override
  String get diagnosticPushDetails_errorMessage_step1 => '1. Переконайтеся, що ваш телефон підключений до Інтернету.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step2 => '2. Якщо підключено, перевірте, чи може ваш телефон отримати доступ до сервісів Google, відвідавши веб-сайт.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step3 => '3. Зачекайте кілька хвилин і спробуйте знову – сервери Firebase можуть тимчасово не працювати.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step4 => '4. Перезапустіть сервіси Google Play, щоб переконатися, що вони працюють належним чином.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step5 => '5. Переконайтеся, що сервіси Google Play встановлені на вашому пристрої.\n';

  @override
  String get diagnosticPushDetails_successMessage => 'Служба сповіщень успішно налаштована та готова до використання для отримання повідомлень і обробки вхідних дзвінків.';

  @override
  String get diagnostic_pushTokenStatusType_progress => 'В процесі';

  @override
  String get diagnostic_pushTokenStatusType_success => 'Служба успішно налаштована ';

  @override
  String get diagnosticScreen_permissionsGroup_title => 'Дозволи';

  @override
  String get diagnosticScreen_pushNotificationService_title => 'Служба push-сповіщень';

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
  String get main_BottomNavigationBarItemLabel_chats => 'Чати';

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
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Несумісна версія WebTrit Cloud Backend, будь ласка, зв\'яжіться з адміністратором вашої системи.\n\nВерсія екземпляру:\n$actual\n\nПідтримувана версія:\n$supportedConstraint\n';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Проблема сумісності';

  @override
  String get messaging_ActionBtn_retry => 'Повторить спробу';

  @override
  String get messaging_ChooseContact_cancel => 'Скасувати';

  @override
  String get messaging_ChooseContact_empty => 'Контакти не знайдено';

  @override
  String get messaging_ChooseContact_title => 'Виберіть контакт:';

  @override
  String get messaging_ConfirmDialog_ask => 'Ви впевнені?';

  @override
  String get messaging_ConfirmDialog_cancel => 'Ні';

  @override
  String get messaging_ConfirmDialog_confirm => 'Так';

  @override
  String get messaging_ConversationBuilders_addUserBtnText => 'Додати користувача';

  @override
  String get messaging_ConversationBuilders_back => 'Назад';

  @override
  String get messaging_ConversationBuilders_back_action => 'Назад';

  @override
  String get messaging_ConversationBuilders_cancel => 'Скасувати';

  @override
  String get messaging_ConversationBuilders_connectionError => 'Помилка підключення, спробуйте пізніше';

  @override
  String get messaging_ConversationBuilders_contactOrNumberSearch_hint => 'Введіть ім\'я або номер телефону';

  @override
  String get messaging_ConversationBuilders_contactSearch_hint => 'Пошук контактів';

  @override
  String get messaging_ConversationBuilders_create => 'Створити';

  @override
  String get messaging_ConversationBuilders_createGroup => 'Створити групу';

  @override
  String get messaging_ConversationBuilders_externalContacts_heading => 'Контакти Хмарної АТС';

  @override
  String get messaging_ConversationBuilders_groupNameHeadline => 'Назва групи';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message1 => 'Контакт має недійсний номер телефону. Він має бути у форматі ';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message2 => '. Будь ласка, виправте це у своїй телефонній книзі.';

  @override
  String get messaging_ConversationBuilders_invalidNumber_ok => 'Закрити';

  @override
  String get messaging_ConversationBuilders_invalidNumber_title => 'Невірний номер телефону';

  @override
  String get messaging_ConversationBuilders_invite_heading => 'Запросити користувачів:';

  @override
  String get messaging_ConversationBuilders_localContacts_heading => 'Локальні контакти';

  @override
  String get messaging_ConversationBuilders_membersHeadline => 'Члени групи';

  @override
  String get messaging_ConversationBuilders_nameFieldEmpty => 'Будь ласка, введіть назву групи';

  @override
  String get messaging_ConversationBuilders_nameFieldLabel => 'Назва групи';

  @override
  String get messaging_ConversationBuilders_nameFieldShort => 'Назва групи має містити не менше 3 символів';

  @override
  String get messaging_ConversationBuilders_next_action => 'Далі';

  @override
  String get messaging_ConversationBuilders_noContacts => 'Немає контактів, що відповідають результату пошуку';

  @override
  String get messaging_ConversationBuilders_numberFormatExample => '+ [код країни] [код регіону/оператора] [номер абонента]';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorError => 'Введений номер телефону недійсний. Його слід ввести у форматі: ';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorHint => 'Формат номера телефону: ';

  @override
  String get messaging_ConversationBuilders_submitBtnText => 'Надіслати';

  @override
  String get messaging_ConversationBuilders_submitError => 'Під час створення групи сталася помилка, повторіть спробу';

  @override
  String get messaging_ConversationBuilders_title_group => 'Створити групу';

  @override
  String get messaging_ConversationBuilders_title_new => 'Новий чат';

  @override
  String get messaging_Conversation_failure => 'Помилка завантаження розмови';

  @override
  String get messaging_ConversationScreen_titlePrefix => 'Діалог:';

  @override
  String get messaging_ConversationsScreen_chatsSearch_hint => 'Введіть ім\'я чату або користувача';

  @override
  String get messaging_ConversationsScreen_empty => 'Немає переписок';

  @override
  String get messaging_ConversationsScreen_messages_title => 'Повідомлення';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_text => 'Щоб надсилати SMS-повідомлення, потрібно мати номер телефону, прив’язаний до вашого облікового запису';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_title => 'Немає номера телефону';

  @override
  String get messaging_ConversationsScreen_selectNumberSheet_title => 'Виберіть номер';

  @override
  String get messaging_ConversationsScreen_smses_title => 'SMS';

  @override
  String get messaging_ConversationsScreen_smssSearch_hint => 'Введіть номер телефону';

  @override
  String get messaging_ConversationsScreen_startDialog => 'Почати діалог';

  @override
  String get messaging_ConversationsScreen_unsupported => 'Обмін повідомленнями не підтримується віддаленою системою, зверніться до свого адміністратора, щоб увімкнути його';

  @override
  String get messaging_Conversations_tile_empty => 'Поки немає повідомлень';

  @override
  String get messaging_Conversations_tile_you => 'Ви';

  @override
  String get messaging_DialogInfo_deleteAsk => 'Ви впевнені, що хочете видалити цей діалог?';

  @override
  String get messaging_DialogInfo_deleteBtn => 'Видалити діалог';

  @override
  String get messaging_DialogInfo_title => 'Контактна інформація';

  @override
  String get messaging_GroupAuthorities_moderator => 'модератор';

  @override
  String get messaging_GroupAuthorities_noauthorities => 'учасник';

  @override
  String get messaging_GroupAuthorities_owner => 'власник';

  @override
  String get messaging_GroupInfo_addUserBtnText => 'Додати користувача';

  @override
  String get messaging_GroupInfo_deleteLeaveBtnText => 'Видалити і залишити';

  @override
  String get messaging_GroupInfo_groupMembersHeadline => 'Члени групи';

  @override
  String get messaging_GroupInfo_leaveAndDeleteAsk => 'Ви впевнені, що бажаєте залишити та видалити цю групу?';

  @override
  String get messaging_GroupInfo_leaveAsk => 'Ви впевнені, що бажаєте залишити цю групу?';

  @override
  String get messaging_GroupInfo_leaveBtnText => 'Вийти з групи';

  @override
  String get messaging_GroupInfo_makeModeratorAsk => 'Ви впевнені, що хочете зробити цього користувача модератором?';

  @override
  String get messaging_GroupInfo_makeModeratorBtnText => 'Зробити модератором';

  @override
  String get messaging_GroupInfo_removeModeratorAsk => 'Ви впевнені, що хочете видалити цього користувача з модераторів?';

  @override
  String get messaging_GroupInfo_removeUserAsk => 'Ви впевнені, що хочете видалити цього користувача з групи?';

  @override
  String get messaging_GroupInfo_removeUserBtnText => 'Видалити';

  @override
  String get messaging_GroupInfo_title => 'Інформація про групу';

  @override
  String get messaging_GroupInfo_titlePrefix => 'Група:';

  @override
  String get messaging_GroupInfo_unmakeModeratorBtnText => 'Прибрати модератора';

  @override
  String get messaging_GroupNameDialog_cancelBtnText => 'Скасувати';

  @override
  String get messaging_GroupNameDialog_fieldHint => 'Введіть назву групи';

  @override
  String get messaging_GroupNameDialog_fieldLabel => 'Назва групи';

  @override
  String get messaging_GroupNameDialog_fieldValidation_empty => 'Будь ласка, введіть назву групи';

  @override
  String get messaging_GroupNameDialog_fieldValidation_short => 'Назва групи занадто коротка';

  @override
  String get messaging_GroupNameDialog_saveBtnText => 'Зберегти';

  @override
  String get messaging_GroupNameDialog_title => 'Назва групи';

  @override
  String get messaging_GroupScreen_titlePrefix => 'Група:';

  @override
  String get messaging_MessageField_hint => 'Введіть повідомлення';

  @override
  String get messaging_MessageListView_typingTrail => 'надруковує...';

  @override
  String get messaging_MessageView_delete => 'Видалити';

  @override
  String get messaging_MessageView_deleted => '[видалено]';

  @override
  String get messaging_MessageView_edit => 'Редагувати';

  @override
  String get messaging_MessageView_edited => '[відредаговано]';

  @override
  String get messaging_MessageView_forward => 'Переслати';

  @override
  String get messaging_MessageView_forwarded => '[переслано]';

  @override
  String get messaging_MessageView_reply => 'Відповісти';

  @override
  String get messaging_MessageView_textcopy => 'Копіювати в буфер обміну';

  @override
  String get messaging_NewConversation_createGroup => '';

  @override
  String get messaging_NewConversation_title => '';

  @override
  String get messaging_ParticipantName_you => 'Ви';

  @override
  String get messaging_SmsSendingStatus_delivered => 'доставлено';

  @override
  String get messaging_SmsSendingStatus_failed => 'не вдалось';

  @override
  String get messaging_SmsSendingStatus_sent => 'надіслано';

  @override
  String get messaging_SmsSendingStatus_waiting => 'очікування';

  @override
  String get messaging_StateBar_connecting => 'ПІДКЛЮЧЕННЯ';

  @override
  String get messaging_StateBar_error => 'ВІДКЛЮЧЕНО';

  @override
  String get messaging_StateBar_initializing => 'ІНІЦІАЛІЗАЦІЯ';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Перевірити';

  @override
  String get notifications_errorSnackBar_activeLineBlindTransferWarning => 'Ви вже на лінії з одержувачем, до якого намагаєтеся здійснити безумовний переказ';

  @override
  String get notifications_messageSnackBar_appOffline => 'Ваш додаток зараз офлайн.';

  @override
  String get notifications_successSnackBar_appOnline => 'Ваш додаток онлайн.';

  @override
  String get notifications_errorSnackBar_callWhileUnregistered => 'Вибачте, ваш додаток наразі відключений від серверів WebTrit та не може здійснювати запити. Будь ласка, перейдіть на сторінку налаштувань і перемістіть вимикач стану онлайн у вимкнути й увімкнути знову, щоб відновити з\'єднання.';

  @override
  String get notifications_errorSnackBar_SignalingConnectFailed => 'Підключення до ядра не вдалося, спроба з\'єднання';

  @override
  String get notifications_errorSnackBar_callWhileOffline => 'Не вдається ініціювати дзвінок, перевірте статус з\'єднання';

  @override
  String get notifications_errorSnackBar_SignalingSessionMissed => 'Помилка автентифікації, будь ласка увійдіть знову';

  @override
  String notifications_errorSnackBar_signalingDisconnectWithSystemReason(String reason) {
    return 'Відключено від ядра з причини: $reason';
  }

  @override
  String notifications_errorSnackBar_signalingDisconnectWithCodeName(String codeName) {
    return 'Від’єднано від ядра за кодом: $codeName';
  }

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'Немає вільних ліній для ініціювання дзвінка';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'Немає доступу до медіа-входу, будь ласка, перевірте дозволи програми';

  @override
  String get notifications_errorSnackBar_sipRegistrationFailed_Unavailable => 'Помилка реєстрації у віддаленій системі VoIP, послуга недоступна';

  @override
  String notifications_errorSnackBar_sipRegistrationFailed_WithSystemReason(String reason) {
    return 'Помилка реєстрації у віддаленій системі VoIP з причини: $reason';
  }

  @override
  String get notifications_errorSnackBar_sipRegistrationFailed_Unexpected => 'Помилка реєстрації у віддаленій системі VoIP через неочікувану помилку';

  @override
  String get permission_Button_request => 'Продовжити';

  @override
  String get permission_manageFullScreenNotificationInstructions_step1 => 'Go to your phone\'s Settings.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step2 => 'Navigate to \'Special App Access\' under the \'Apps & notifications\' section.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step3 => 'Find and tap on \'Manage full screen intents\'.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step4 => 'Select the app for which you want to manage full-screen notifications.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step5 => 'Toggle the permission to enable or disable full-screen notifications for that app.';

  @override
  String get permission_manageFullScreenNotificationPermissions => 'Manage Full-Screen Notification Permissions';

  @override
  String get permission_manufacturer_Button_gotIt => 'Зрозуміло';

  @override
  String get permission_manufacturer_Button_toSettings => 'Відкрийте налаштування програми';

  @override
  String get permission_manufacturer_Text_heading => 'Щоб забезпечити найкращу взаємодію з користувачем, програмі потрібно вручну надати такі дозволи:';

  @override
  String get permission_manufacturer_Text_trailing => 'Дозволи можуть бути змінені в будь-який час у майбутньому.';

  @override
  String get permission_manufacturer_Text_xiaomi_tip1 => 'Перейдіть у «Налаштування програми» → «Сповіщення».';

  @override
  String get permission_manufacturer_Text_xiaomi_tip2 => 'Знайдіть і ввімкніть «Сповіщення на екрані блокування».';

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
  String get recents_HistoryTile_missedCallText => 'Пропущено';

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
  String get request_StatusName => 'Назва статусу запиту';

  @override
  String get sessionStatus_pushNotificationServiceProblem => 'Проблема з налаштуванням служби пуш-сповіщень';

  @override
  String get settings_AboutText_AppSessionIdentifier => 'Ідентифікатор сесії застосунку';

  @override
  String get settings_AboutText_AppVersion => 'Версія додатка';

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AboutText_FCMPushNotificationToken => 'Токен для Push-повідомлень FCM';

  @override
  String get settings_AboutText_StoreVersion => 'Версія збірки в магазині';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'Ви впевнені, що хочете видалити обліковий запис?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Підтвердіть видалення облікового запису';

  @override
  String get settings_AppBarTitle_myAccount => 'Мій обліковий запис';

  @override
  String get settings_call_codecs_preferred_audio_default => 'Автоматично';

  @override
  String get settings_call_codecs_preferred_audio_tip => 'Використовується для аудіодзвінків. Якщо кодек не підтримується пристроєм, дзвінок буде встановлено за допомогою наступного доступного кодеку.';

  @override
  String get settings_call_codecs_preferred_audio_title => 'Предпочитайомий відеокодек';

  @override
  String get settings_call_codecs_preferred_video_default => 'Автоматично';

  @override
  String get settings_call_codecs_preferred_video_tip => 'Використовується для відеодзвінків. Якщо кодек не підтримується пристроєм, дзвінок буде встановлено за допомогою наступного доступного кодеку.';

  @override
  String get settings_call_codecs_preferred_video_title => 'Предпочитайомий відеокодек';

  @override
  String get settings_ListViewTileTitle_about => 'Про програму';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Видалити обліковий запис';

  @override
  String get settings_ListViewTileTitle_call_codecs => 'Кодеки дзвінка';

  @override
  String get settings_ListViewTileTitle_self_config => 'Сторінка спец-налаштувань';

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
  String get settings_network_incomingCallType_pushNotification_description => 'Коли додаток не використувується, він зупиняється і не використовує ресурси, що дозволяє мінімізувати споживання батареї. Під час вхідного дзвінку <brand> сервер посилає push нотифікацію на телефон, після чого мобільна операціонна система запускає додаток для отримання дзвінка. Цей спосіб не гарантує отримання всіх дзвінків, бо якщо телефон довго не використовується, то деякі версії Android можуть обмежити отримання push нотифікацій, і ви можете не отримати вхідний дзвінок.';

  @override
  String get settings_network_incomingCallType_pushNotification_title => 'Пуш-нотифікація';

  @override
  String get settings_network_incomingCallType_socket_description => 'Додаток залишається працювати в фоні та завжди підтримує активне підключення до сервера. Це збільшує шанси отримати вхідний дзвінок, але може швидше розряджати батарею.';

  @override
  String get settings_network_incomingCallType_socket_title => 'Постійне підключення до серверу';

  @override
  String get settings_network_incomingCallType_title => 'Тип вхідного дзвінка';

  @override
  String get signalingResponseCode_errorAttachingPlugin => 'Ми зіткнулися з проблемою підключення функції. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_errorDetachingPlugin => 'Ми зіткнулися з проблемою відключення функції. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_errorSendingMessage => 'Ми не змогли відправити ваше повідомлення. Перевірте мережу і спробуйте ще раз.';

  @override
  String get signalingResponseCode_handleNotFound => 'Ми не змогли знайти те, що ви шукаєте. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_invalidElementType => 'Щось пішло не так. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_invalidJson => 'Сталася помилка під час обробки ваших даних. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_invalidJsonObject => 'Деяка інформація, яку ви надали, є недійсною. Будь ласка, перевірте і спробуйте ще раз.';

  @override
  String get signalingResponseCode_invalidPath => 'Запитувана дія недоступна. Будь ласка, спробуйте інший варіант.';

  @override
  String get signalingResponseCode_invalidSdp => 'Ми зіткнулися з технічною помилкою. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_invalidStream => 'Запитуваний потік недоступний. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_missingMandatoryElement => 'Необхідна інформація відсутня. Будь ласка, заповніть усі обов\'язкові поля.';

  @override
  String get signalingResponseCode_missingRequest => 'Щось пішло не так із вашим запитом. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_notAcceptingNewSessions => 'Ми не можемо розпочати нові сесії зараз. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_notFoundRoutesInReplyFromBE => 'Ми не змогли знайти маршрут для виконання вашого запиту. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_pluginNotFound => 'Відсутній необхідний компонент. Спробуйте перезапустити додаток.';

  @override
  String get signalingResponseCode_sessionIdInUse => 'Ця сесія вже активна. Спробуйте використовувати іншу сесію.';

  @override
  String get signalingResponseCode_sessionNotFound => 'Не вдалося знайти вашу сесію. Будь ласка, увійдіть у систему і спробуйте ще раз.';

  @override
  String get signalingResponseCode_tokenNotFound => 'Ваш токен доступу відсутній або недійсний. Будь ласка, увійдіть у систему знову.';

  @override
  String get signalingResponseCode_transportSpecificError => 'Виникла проблема з підключенням. Перевірте свою мережу і спробуйте знову.';

  @override
  String get signalingResponseCode_normalUnspecified => 'Щось пішло не так. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_callNotExist => 'Дзвінок не існує.';

  @override
  String get signalingResponseCode_loopDetected => 'Ми не можемо знайти маршрут для виконання вашого запиту. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_exchangeRoutingError => 'Ми не можемо знайти маршрут для виконання вашого запиту. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_invalidNumberFormat => 'Невірний формат номера';

  @override
  String get signalingResponseCode_ambiguousRequest => 'Ваш запит не може бути виконаний. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_userBusy => 'Користувач, якого ви намагаєтеся знайти, зайнятий. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_requestTerminated => 'Ваш запит було відхилено. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_incompatibleDestination => 'Ваш запит не може бути виконаний.';

  @override
  String get signalingResponseCode_busyEverywhere => 'Всі лінії зайняті. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_declineCall => 'Ваш дзвінок було відхилено.';

  @override
  String get signalingResponseCode_userNotExist => 'Користувача, якого ви намагаєтеся знайти, не існує.';

  @override
  String get signalingResponseCode_notAcceptable => 'Ваш запит не може бути виконаний. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_unwanted => 'Ваш запит не може бути виконаний. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_rejected => 'Ваш запит було відхилено. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCodeType_plugin => 'Не працює необхідна функція. Спробуйте перезапустити додаток.';

  @override
  String get signalingResponseCodeType_request => 'Сталася помилка у вашому запиті. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCodeType_session => 'Виникла проблема з вашою сесією. Будь ласка, увійдіть у систему знову або перезапустіть додаток.';

  @override
  String get signalingResponseCodeType_token => 'Ваш токен доступу недійсний. Будь ласка, увійдіть у систему знову.';

  @override
  String get signalingResponseCodeType_transport => 'Ми маємо труднощі з підключенням до сервера. Перевірте ваше з\'єднання та спробуйте знову.';

  @override
  String get signalingResponseCodeType_unauthorized => 'У вас немає належного доступу. Будь ласка, увійдіть у систему або зверніться до служби підтримки.';

  @override
  String get signalingResponseCodeType_unknown => 'Сталася несподівана помилка. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCodeType_webrtc => 'Виникла проблема з підключенням дзвінка. Завершіть дзвінок і спробуйте знову.';

  @override
  String get signalingResponseCodeType_callHangup => 'Ваш дзвінок було завершено.';

  @override
  String get signalingResponseCode_unauthorizedAccess => 'У вас немає дозволу на доступ до цієї функції. Зверніться до служби підтримки, якщо вважаєте, що це помилка.';

  @override
  String get signalingResponseCode_unauthorizedRequest => 'Ваш запит не може бути авторизованим. Будь ласка, спробуйте увійти знову.';

  @override
  String get signalingResponseCode_unexpectedAnswer => 'Ми отримали несподівану відповідь. Будь ласка, спробуйте ще раз.';

  @override
  String get signalingResponseCode_unknownError => 'Сталася несподівана помилка. Будь ласка, спробуйте пізніше.';

  @override
  String get signalingResponseCode_unknownRequest => 'Ми не впізнали ваш запит. Будь ласка, спробуйте ще раз або зверніться до служби підтримки.';

  @override
  String get signalingResponseCode_unsupportedJsepType => 'Ця дія не підтримується вашими поточними налаштуваннями.';

  @override
  String get signalingResponseCode_wrongWebrtcState => 'Сталася помилка, пов’язана з викликом. Завершіть виклик і спробуйте ще раз.';

  @override
  String get themeMode_dark => 'Темний';

  @override
  String get themeMode_light => 'Світлий';

  @override
  String get themeMode_system => 'Системний';

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
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Retry';

  @override
  String get contacts_agreement_title => 'Збір даних';

  @override
  String get contacts_agreement_description => 'Цей додаток потребує доступу до вашого списку контактів, щоб відображати їх у вкладці «Контакти» додатку. \n\nДані контактів тимчасово зберігаються локально на вашому пристрої для забезпечення функцій, таких як здійснення дзвінків прямо з додатку. \n\nЦі дані не збираються, не передаються та не поширюються за межами додатку.';

  @override
  String get contacts_agreement_checkbox_text => 'Я погоджуюсь дозволити додатку доступ до моїх контактів для покращення користувацького досвіду.';

  @override
  String get contacts_agreement_button_text => 'Продовжити';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Skip';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Web resource error';

  @override
  String get socketError_serverUnreachable => 'Сервер недоступний через проблеми з мережею';

  @override
  String get socketError_networkUnreachable => 'Мережа недоступна';

  @override
  String get socketError_connectionTimedOut => 'Час з\'єднання вичерпано';

  @override
  String get socketError_connectionRefused => 'З\'єднання відхилено';

  @override
  String get socketError_connectionReset => 'З\'єднання було скинуто';

  @override
  String get socketError_default => 'Мережева помилка';

  @override
  String get socketError_serverUnreachableDescription => 'Сервер недоступний. Це може бути спричинено відсутністю інтернет-з\'єднання або технічним обслуговуванням сервера. Перевірте інтернет-з\'єднання та спробуйте знову.';

  @override
  String get socketError_networkUnreachableDescription => 'Мережа недоступна. Це може бути спричинено слабким інтернет-з\'єднанням, обмеженнями мережі, такими як фаєрволи, або неправильними налаштуваннями DNS. Якщо ви використовуєте робочу або обмежену мережу, зверніться до адміністратора мережі або спробуйте підключитися до іншої мережі.';

  @override
  String get socketError_connectionTimedOutDescription => 'Час з\'єднання вичерпано. Це може статися через повільне або нестабільне інтернет-з\'єднання. Перевірте своє з\'єднання та спробуйте знову.';

  @override
  String get socketError_connectionRefusedDescription => 'Сервер відхилив з\'єднання. Можливо, сервер недоступний або відхиляє запити. Спробуйте пізніше.';

  @override
  String get socketError_connectionResetDescription => 'З\'єднання було скинуто сервером. Спробуйте знову.';

  @override
  String socketError_defaultDescription(int? errorCode) {
    return 'Виникла неочікувана мережева помилка (Код помилки: $errorCode). Це може бути спричинено проблемами з мережею або сервером. Спробуйте пізніше.';
  }
}
