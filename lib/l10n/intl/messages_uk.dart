// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(name) => "${name} видалено";

  static String m1(seconds) => "Повторно надіслати код (${seconds} с)";

  static String m2(actual, supportedConstraint) =>
      "Непідтримувана версія екземпляра, будь ласка, зверніться до адміністратора вашої системи (фактична: ${actual}, підтримувана: ${supportedConstraint})";

  static String m3(email) =>
      "Якщо у вас ще немає власного екземпляра WebTrit, зв\'яжіться з командою продажів за адресою ${email}";

  static String m4(email) =>
      "Якщо ви не бачите електронного листа з кодом підтвердження від ${email} у своїй скринці вхідних, будь ласка, перевірте папку спаму.";

  static String m5(email) =>
      "На ${email} надіслано одноразовий код підтвердження.";

  static String m6(phone) =>
      "На електронну пошту, прив\'язану до телефону tel:${phone}, надіслано одноразовий код підтвердження.";

  static String m7(actual, supportedConstraint) =>
      "Несумісна версія екземпляра PortaPhone, будь ласка, зверніться до адміністратора вашої системи (фактична: ${actual}, підтримувана: ${supportedConstraint})";

  static String m8(time) => "${time}";

  static String m9(time) => "${time}";

  static String m10(filter) =>
      "Зараз у вас немає жодних ${filter} останніх дзвінків.";

  static String m11(name) => "${name} видалено";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogActions_no": MessageLookupByLibrary.simpleMessage("Ні"),
        "alertDialogActions_ok": MessageLookupByLibrary.simpleMessage("Ок"),
        "alertDialogActions_yes": MessageLookupByLibrary.simpleMessage("Так"),
        "callStatus_appUnregistered":
            MessageLookupByLibrary.simpleMessage("Незареєстровано"),
        "callStatus_connectError":
            MessageLookupByLibrary.simpleMessage("Помилка підключення"),
        "callStatus_connectIssue":
            MessageLookupByLibrary.simpleMessage("Проблема з\'єднання"),
        "callStatus_connectivityNone":
            MessageLookupByLibrary.simpleMessage("Немає інтернет-з\'єднання"),
        "callStatus_inProgress":
            MessageLookupByLibrary.simpleMessage("Підключення в процесі"),
        "callStatus_ready":
            MessageLookupByLibrary.simpleMessage("Підключення встановлено"),
        "call_CallActionsTooltip_accept":
            MessageLookupByLibrary.simpleMessage("Прийняти"),
        "call_CallActionsTooltip_disableCamera":
            MessageLookupByLibrary.simpleMessage("Вимкнути камеру"),
        "call_CallActionsTooltip_disableSpeaker":
            MessageLookupByLibrary.simpleMessage("Вимкнути динамік"),
        "call_CallActionsTooltip_enableCamera":
            MessageLookupByLibrary.simpleMessage("Увімкнути камеру"),
        "call_CallActionsTooltip_enableSpeaker":
            MessageLookupByLibrary.simpleMessage("Увімкнути динамік"),
        "call_CallActionsTooltip_hangup":
            MessageLookupByLibrary.simpleMessage("Завершити"),
        "call_CallActionsTooltip_hideKeypad":
            MessageLookupByLibrary.simpleMessage("Приховати клавіатуру"),
        "call_CallActionsTooltip_hold":
            MessageLookupByLibrary.simpleMessage("Утримати дзвінок"),
        "call_CallActionsTooltip_mute":
            MessageLookupByLibrary.simpleMessage("Вимкнути мікрофон"),
        "call_CallActionsTooltip_showKeypad":
            MessageLookupByLibrary.simpleMessage("Показати клавіатуру"),
        "call_CallActionsTooltip_transfer":
            MessageLookupByLibrary.simpleMessage("Передати"),
        "call_CallActionsTooltip_unhold":
            MessageLookupByLibrary.simpleMessage("Поновити дзвінок"),
        "call_CallActionsTooltip_unmute":
            MessageLookupByLibrary.simpleMessage("Увімкнути мікрофон"),
        "call_FailureAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Помилка"),
        "call_description_incoming":
            MessageLookupByLibrary.simpleMessage("Вхідний дзвінок від"),
        "call_description_outgoing":
            MessageLookupByLibrary.simpleMessage("Вихідний дзвінок до"),
        "contactsSourceExternal":
            MessageLookupByLibrary.simpleMessage("Хмарний PBX"),
        "contactsSourceLocal":
            MessageLookupByLibrary.simpleMessage("Ваш телефон"),
        "contacts_ExternalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Оновити"),
        "contacts_ExternalTabText_empty":
            MessageLookupByLibrary.simpleMessage("Немає контактів"),
        "contacts_ExternalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("Контакти не знайдено"),
        "contacts_ExternalTabText_failure":
            MessageLookupByLibrary.simpleMessage(
                "Не вдалося отримати контакти хмарного PBX"),
        "contacts_LocalTabButton_openAppSettings":
            MessageLookupByLibrary.simpleMessage(
                "Надайте доступ до контактів вашого телефону"),
        "contacts_LocalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Оновити"),
        "contacts_LocalTabText_empty":
            MessageLookupByLibrary.simpleMessage("Немає контактів"),
        "contacts_LocalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("Контакти не знайдено"),
        "contacts_LocalTabText_failure": MessageLookupByLibrary.simpleMessage(
            "Не вдалося отримати контакти вашого телефону"),
        "contacts_LocalTabText_permissionFailure":
            MessageLookupByLibrary.simpleMessage(
                "Відсутні дозволи на отримання контактів вашого телефону"),
        "copyToClipboard_floatingSnackBar":
            MessageLookupByLibrary.simpleMessage("Текст скопійовано"),
        "copyToClipboard_popupMenuItem":
            MessageLookupByLibrary.simpleMessage("Скопіювати в буфер обміну"),
        "default_ClientExceptionError": MessageLookupByLibrary.simpleMessage(
            "Сталася проблема з клієнтом HTTP"),
        "default_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з відповіддю"),
        "default_RequestFailureError":
            MessageLookupByLibrary.simpleMessage("Сталася помилка сервера"),
        "default_SocketExceptionError":
            MessageLookupByLibrary.simpleMessage("Сталася проблема з мережею"),
        "default_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема із захищеною мережею"),
        "default_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з відповіддю"),
        "default_UnauthorizedRequestFailureError":
            MessageLookupByLibrary.simpleMessage(
                "Сталася помилка несанкціонованого запиту"),
        "favorites_BodyCenter_empty":
            MessageLookupByLibrary.simpleMessage("Немає обраних номерів"),
        "favorites_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Ви впевнені, що хочете видалити поточний обраний номер?"),
        "favorites_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Підтвердіть видалення"),
        "favorites_SnackBar_deleted": m0,
        "locale_default":
            MessageLookupByLibrary.simpleMessage("За замовчуванням"),
        "locale_en": MessageLookupByLibrary.simpleMessage("Англійська"),
        "logRecordsConsole_AppBarTitle":
            MessageLookupByLibrary.simpleMessage("Консоль журналу"),
        "logRecordsConsole_Button_failureRefresh":
            MessageLookupByLibrary.simpleMessage("Оновити"),
        "logRecordsConsole_Text_failure":
            MessageLookupByLibrary.simpleMessage("Сталася помилка ☹️"),
        "login_AppBarTitle_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpRequest":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpVerify": MessageLookupByLibrary.simpleMessage(""),
        "login_ButtonTooltip_signInToYourInstance":
            MessageLookupByLibrary.simpleMessage(
                "Увійдіть до свого екземпляра PortaPhone"),
        "login_Button_coreUrlAssignProceed":
            MessageLookupByLibrary.simpleMessage("Продовжити"),
        "login_Button_otpRequestProceed":
            MessageLookupByLibrary.simpleMessage("Продовжити"),
        "login_Button_otpVerifyProceed":
            MessageLookupByLibrary.simpleMessage("Перевірити"),
        "login_Button_otpVerifyRepeat":
            MessageLookupByLibrary.simpleMessage("Повторно надіслати код"),
        "login_Button_otpVerifyRepeatInterval": m1,
        "login_Button_signIn": MessageLookupByLibrary.simpleMessage("Увійти"),
        "login_Button_signUpToDemoInstance":
            MessageLookupByLibrary.simpleMessage("Зареєструватися"),
        "login_CoreVersionUnsupportedExceptionError": m2,
        "login_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з відповіддю"),
        "login_RequestFailureCodeIncorrectError":
            MessageLookupByLibrary.simpleMessage("Невірний код підтвердження"),
        "login_RequestFailureEmptyEmailError":
            MessageLookupByLibrary.simpleMessage(
                "Не вдалося відправити код підтвердження"),
        "login_RequestFailureError":
            MessageLookupByLibrary.simpleMessage("Виникла помилка на сервері"),
        "login_RequestFailureOtpAlreadyVerifiedError":
            MessageLookupByLibrary.simpleMessage("Перевірка вже пройдена"),
        "login_RequestFailureOtpExpiredError":
            MessageLookupByLibrary.simpleMessage("Перевірка вичерпана"),
        "login_RequestFailureOtpIdVerifyAttemptsExceededError":
            MessageLookupByLibrary.simpleMessage(
                "Перевищено кількість спроб підтвердження"),
        "login_RequestFailureOtpNotFoundError":
            MessageLookupByLibrary.simpleMessage("Код верифікації не знайдено"),
        "login_RequestFailurePhoneNotFoundError":
            MessageLookupByLibrary.simpleMessage("Номер телефону не знайдено"),
        "login_RequestFailureUnconfiguredBundleIdError":
            MessageLookupByLibrary.simpleMessage(
                " Помилка конфігурації сервера додатка - сповістіть свого постачальника послуг"),
        "login_SocketExceptionError":
            MessageLookupByLibrary.simpleMessage("Виникла проблема з мережею"),
        "login_TextFieldLabelText_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(
                "Введіть URL вашого екземпляра PortaPhone"),
        "login_TextFieldLabelText_otpRequestEmail":
            MessageLookupByLibrary.simpleMessage(
                "Введіть свою електронну пошту"),
        "login_TextFieldLabelText_otpRequestPhone":
            MessageLookupByLibrary.simpleMessage("Введіть свій номер телефону"),
        "login_TextFieldLabelText_otpVerifyCode":
            MessageLookupByLibrary.simpleMessage("Введіть код підтвердження"),
        "login_Text_coreUrlAssignPostDescription": m3,
        "login_Text_coreUrlAssignPreDescription":
            MessageLookupByLibrary.simpleMessage(
                "Для здійснення дзвінків через власний екземпляр PortaPhone і власний PortaSwitch введіть URL сервера (як це було надано вашим менеджером з облікового запису) нижче."),
        "login_Text_otpRequestDemoDescription":
            MessageLookupByLibrary.simpleMessage(
                "Якщо у вас ще немає облікового запису, він буде автоматично створений для вас."),
        "login_Text_otpRequestDescription":
            MessageLookupByLibrary.simpleMessage(""),
        "login_Text_otpVerifyCheckSpamFrom": m4,
        "login_Text_otpVerifyCheckSpamGeneral":
            MessageLookupByLibrary.simpleMessage(
                "Якщо ви не бачите електронного листа з кодом підтвердження у своїй скринці вхідних, будь ласка, перевірте папку спаму."),
        "login_Text_otpVerifySentToEmail": m5,
        "login_Text_otpVerifySentToEmailAssignedWithPhone": m6,
        "login_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема із безпекою мережі"),
        "login_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з відповіддю"),
        "login_validationCoreUrlError": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, введіть правильний URL"),
        "login_validationEmailError": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, введіть правильну електронну пошту"),
        "login_validationPhoneError": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, введіть правильний номер телефону"),
        "main_BottomNavigationBarItemLabel_contacts":
            MessageLookupByLibrary.simpleMessage("Контакти"),
        "main_BottomNavigationBarItemLabel_favorites":
            MessageLookupByLibrary.simpleMessage("Обрані"),
        "main_BottomNavigationBarItemLabel_keypad":
            MessageLookupByLibrary.simpleMessage("Клавіатура"),
        "main_BottomNavigationBarItemLabel_recents":
            MessageLookupByLibrary.simpleMessage("Останні"),
        "main_CompatibilityIssueDialogActions_logout":
            MessageLookupByLibrary.simpleMessage("Вийти"),
        "main_CompatibilityIssueDialogActions_update":
            MessageLookupByLibrary.simpleMessage("Оновити"),
        "main_CompatibilityIssueDialogActions_verify":
            MessageLookupByLibrary.simpleMessage("Перевірити знову"),
        "main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError":
            m7,
        "main_CompatibilityIssueDialog_title":
            MessageLookupByLibrary.simpleMessage("Проблема сумісності"),
        "notImplemented": MessageLookupByLibrary.simpleMessage(
            "Вибачте, ця функція ще не реалізована"),
        "notifications_errorSnackBarAction_callUserMedia":
            MessageLookupByLibrary.simpleMessage("Перевірити"),
        "notifications_errorSnackBar_callConnect":
            MessageLookupByLibrary.simpleMessage(
                "Підключення до ядра не вдалося, спроба з\'єднання"),
        "notifications_errorSnackBar_callSignalingClientNotConnect":
            MessageLookupByLibrary.simpleMessage(
                "Не вдається ініціювати дзвінок, перевірте статус з\'єднання"),
        "notifications_errorSnackBar_callSignalingClientSessionMissed":
            MessageLookupByLibrary.simpleMessage(
                "Поточна сесія з\'єднання недійсна, будь ласка, увійдіть знову"),
        "notifications_errorSnackBar_callUndefinedLine":
            MessageLookupByLibrary.simpleMessage(
                "Немає вільних ліній для ініціювання дзвінка"),
        "notifications_errorSnackBar_callUserMedia":
            MessageLookupByLibrary.simpleMessage(
                "Немає доступу до медіа-входу, будь ласка, перевірте дозволи програми"),
        "permission_Button_request":
            MessageLookupByLibrary.simpleMessage("Продовжити"),
        "permission_Text_description": MessageLookupByLibrary.simpleMessage(
            "Для забезпечення найкращого досвіду користувача програма потребує наступні дозволи: мікрофон для аудіодзвінків, камера для відеодзвінків та доступ до контактів для спрощення їх використання в програмі.\n\nДозволи можуть бути змінені у майбутньому."),
        "recentTimeAfterMidnight": m8,
        "recentTimeBeforeMidnight": m9,
        "recentsVisibilityFilter_all":
            MessageLookupByLibrary.simpleMessage("Всі"),
        "recentsVisibilityFilter_incoming":
            MessageLookupByLibrary.simpleMessage("Вхідні"),
        "recentsVisibilityFilter_missed":
            MessageLookupByLibrary.simpleMessage("Пропущені"),
        "recentsVisibilityFilter_outgoing":
            MessageLookupByLibrary.simpleMessage("Вихідні"),
        "recents_BodyCenter_empty": m10,
        "recents_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Ви впевнені, що хочете видалити поточний журнал дзвінків?"),
        "recents_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Підтвердження видалення"),
        "recents_errorSnackBar_loadFailure":
            MessageLookupByLibrary.simpleMessage("Упс... сталася помилка ☹️"),
        "recents_snackBar_deleted": m11,
        "settings_AboutText_CoreVersionUndefined":
            MessageLookupByLibrary.simpleMessage("?.?.?"),
        "settings_AccountDeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Ви впевнені, що хочете видалити обліковий запис?"),
        "settings_AccountDeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Підтвердіть видалення облікового запису"),
        "settings_AppBarTitle_myAccount":
            MessageLookupByLibrary.simpleMessage("Мій обліковий запис"),
        "settings_ForceLogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Ви впевнені, що хочете примусово вийти?"),
        "settings_ForceLogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Підтвердіть примусовий вихід"),
        "settings_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з відповіддю"),
        "settings_ListViewTileTitle_about":
            MessageLookupByLibrary.simpleMessage("Про програму"),
        "settings_ListViewTileTitle_accountDelete":
            MessageLookupByLibrary.simpleMessage("Видалити обліковий запис"),
        "settings_ListViewTileTitle_help":
            MessageLookupByLibrary.simpleMessage("Допомога"),
        "settings_ListViewTileTitle_language":
            MessageLookupByLibrary.simpleMessage("Мова"),
        "settings_ListViewTileTitle_logRecordsConsole":
            MessageLookupByLibrary.simpleMessage("Консоль записів журналу"),
        "settings_ListViewTileTitle_logout":
            MessageLookupByLibrary.simpleMessage("Вийти"),
        "settings_ListViewTileTitle_network":
            MessageLookupByLibrary.simpleMessage("Налаштування мережі"),
        "settings_ListViewTileTitle_registered":
            MessageLookupByLibrary.simpleMessage("Зареєстровані"),
        "settings_ListViewTileTitle_settings":
            MessageLookupByLibrary.simpleMessage("НАЛАШТУВАННЯ"),
        "settings_ListViewTileTitle_termsConditions":
            MessageLookupByLibrary.simpleMessage("Умови та положення"),
        "settings_ListViewTileTitle_themeMode":
            MessageLookupByLibrary.simpleMessage("Режим теми"),
        "settings_ListViewTileTitle_toolbox":
            MessageLookupByLibrary.simpleMessage("ІНСТРУМЕНТИ"),
        "settings_LogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Ви впевнені, що хочете вийти?"),
        "settings_LogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Підтвердження виходу"),
        "settings_RequestFailureError":
            MessageLookupByLibrary.simpleMessage("Виникла помилка на сервері"),
        "settings_SocketExceptionError":
            MessageLookupByLibrary.simpleMessage("Виникла проблема з мережею"),
        "settings_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з безпекою мережі"),
        "settings_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Виникла проблема з відповіддю"),
        "themeMode_dark": MessageLookupByLibrary.simpleMessage("Темний"),
        "themeMode_light": MessageLookupByLibrary.simpleMessage("Світлий"),
        "themeMode_system": MessageLookupByLibrary.simpleMessage("Системний"),
        "underDevelopment": MessageLookupByLibrary.simpleMessage(
            "Ця сторінка знаходиться в розробці."),
        "validationBlankError": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, введіть значення"),
        "webRegistration_ErrorAcknowledgeDialogActions_demo":
            MessageLookupByLibrary.simpleMessage("Демо"),
        "webRegistration_ErrorAcknowledgeDialogActions_retry":
            MessageLookupByLibrary.simpleMessage("Повторити"),
        "webRegistration_ErrorAcknowledgeDialogActions_skip":
            MessageLookupByLibrary.simpleMessage("Пропустити"),
        "webRegistration_ErrorAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Помилка веб-ресурсу")
      };
}
