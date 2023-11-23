// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(name) => "${name} cancellato";

  static String m1(seconds) => "Invia di nuovo il codice (${seconds} s)";

  static String m2(actual, supportedConstraint) =>
      "È stata fornita una versione di richiesta incompatibile, contattare l\'amministratore del sistema (actual:${actual}, supported:${supportedConstraint})";

  static String m3(email) =>
      "Se non hai ancora il tuo proprio WebTrit Cloud Backend, contatta il team vendite all\'indirizzo ${email}";

  static String m4(email) =>
      "Se non vedi un\'e-mail con il codice di verifica da ${email} nella tua casella di posta, controlla la cartella dello spam.";

  static String m5(email) =>
      "Il codice di verifica temporaneo ti è stato inviato via ${email}";

  static String m6(phone) =>
      "Il codice di verifica temporaneo ti è stato inviato alla mail associata al telefono:${phone} numero di telefono.";

  static String m7(actual, supportedConstraint) =>
      "Versione di PortaPhone incompatibile, contattare l\'amministratore del sistema (actual:actual}, supported:supportedConstraint})";

  static String m8(time) => "${time}";

  static String m9(time) => "${time}";

  static String m10(filter) =>
      "Attualmente non hai chiamate recenti con ${filter}.";

  static String m11(name) => "${name} cancellato";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogActions_no": MessageLookupByLibrary.simpleMessage("No"),
        "alertDialogActions_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "alertDialogActions_yes": MessageLookupByLibrary.simpleMessage("Si"),
        "callStatus_appUnregistered":
            MessageLookupByLibrary.simpleMessage("Non registrato"),
        "callStatus_connectError":
            MessageLookupByLibrary.simpleMessage("Errore di connessione"),
        "callStatus_connectIssue":
            MessageLookupByLibrary.simpleMessage("Problemi di connessione"),
        "callStatus_connectivityNone": MessageLookupByLibrary.simpleMessage(
            "Nessuna connessione internet"),
        "callStatus_inProgress":
            MessageLookupByLibrary.simpleMessage("Connessione in corso"),
        "callStatus_ready":
            MessageLookupByLibrary.simpleMessage("Connessione stabilita"),
        "call_CallActionsTooltip_accept":
            MessageLookupByLibrary.simpleMessage("Accetta chiamata"),
        "call_CallActionsTooltip_disableCamera":
            MessageLookupByLibrary.simpleMessage("Disattiva video"),
        "call_CallActionsTooltip_disableSpeaker":
            MessageLookupByLibrary.simpleMessage("Disattiva vivavoce"),
        "call_CallActionsTooltip_enableCamera":
            MessageLookupByLibrary.simpleMessage("Attiva video"),
        "call_CallActionsTooltip_enableSpeaker":
            MessageLookupByLibrary.simpleMessage("Attiva vivavoce"),
        "call_CallActionsTooltip_hangup":
            MessageLookupByLibrary.simpleMessage("Termina chiamata"),
        "call_CallActionsTooltip_hideKeypad":
            MessageLookupByLibrary.simpleMessage("Nascondi tastiera"),
        "call_CallActionsTooltip_hold":
            MessageLookupByLibrary.simpleMessage("Attesa"),
        "call_CallActionsTooltip_mute":
            MessageLookupByLibrary.simpleMessage("Disattiva il microfono"),
        "call_CallActionsTooltip_showKeypad":
            MessageLookupByLibrary.simpleMessage("Mostra tastiera"),
        "call_CallActionsTooltip_transfer":
            MessageLookupByLibrary.simpleMessage("Trasferimento"),
        "call_CallActionsTooltip_unhold":
            MessageLookupByLibrary.simpleMessage("Ripresa chiamata"),
        "call_CallActionsTooltip_unmute":
            MessageLookupByLibrary.simpleMessage("Attiva il microfono"),
        "call_FailureAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Guasto"),
        "call_description_incoming":
            MessageLookupByLibrary.simpleMessage("Chiamata in arrivo"),
        "call_description_outgoing":
            MessageLookupByLibrary.simpleMessage("Chiamata in corso"),
        "contactsSourceExternal":
            MessageLookupByLibrary.simpleMessage("Centralino cloud"),
        "contactsSourceLocal":
            MessageLookupByLibrary.simpleMessage("Il tuo telefono"),
        "contacts_ExternalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "contacts_ExternalTabText_empty":
            MessageLookupByLibrary.simpleMessage("Nessun contatto"),
        "contacts_ExternalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("Nessun contatto trovato"),
        "contacts_ExternalTabText_failure":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile ottenere i contatti del centralino cloud"),
        "contacts_LocalTabButton_openAppSettings":
            MessageLookupByLibrary.simpleMessage(
                "Grant access to your phone contacts"),
        "contacts_LocalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "contacts_LocalTabText_empty":
            MessageLookupByLibrary.simpleMessage("Nessun contatto"),
        "contacts_LocalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("Nessun contatto trovato"),
        "contacts_LocalTabText_failure": MessageLookupByLibrary.simpleMessage(
            "Impossibile ottenere i tuoi contatti telefonici"),
        "contacts_LocalTabText_permissionFailure":
            MessageLookupByLibrary.simpleMessage(
                "Non ci sono i permessi per ottenere i tuoi contatti telefonici"),
        "copyToClipboard_floatingSnackBar":
            MessageLookupByLibrary.simpleMessage("Testo copiato"),
        "copyToClipboard_popupMenuItem":
            MessageLookupByLibrary.simpleMessage("Copia negli appunti"),
        "default_ClientExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema con il client HTTP"),
        "default_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di risposta"),
        "default_RequestFailureError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un errore del server"),
        "default_SocketExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di rete"),
        "default_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di rete sicuro"),
        "default_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di risposta"),
        "default_UnauthorizedRequestFailureError":
            MessageLookupByLibrary.simpleMessage(
                "Si è verificato un errore di richiesta non autorizzata"),
        "favorites_BodyCenter_empty":
            MessageLookupByLibrary.simpleMessage("Nessun numero preferito"),
        "favorites_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Sei sicuro di voler eliminare il contatto preferito?"),
        "favorites_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confermare l\'eliminazione"),
        "favorites_SnackBar_deleted": m0,
        "locale_default": MessageLookupByLibrary.simpleMessage("Predefinito"),
        "locale_en": MessageLookupByLibrary.simpleMessage("Inglese"),
        "logRecordsConsole_AppBarTitle":
            MessageLookupByLibrary.simpleMessage("Console dei log"),
        "logRecordsConsole_Button_failureRefresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "logRecordsConsole_Text_failure":
            MessageLookupByLibrary.simpleMessage("Si è verificato un errore ☹"),
        "login_AppBarTitle_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpRequest":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpVerify": MessageLookupByLibrary.simpleMessage(""),
        "login_ButtonTooltip_signInToYourInstance":
            MessageLookupByLibrary.simpleMessage("Accedi a PortaPhone"),
        "login_Button_coreUrlAssignProceed":
            MessageLookupByLibrary.simpleMessage("Procedi"),
        "login_Button_otpRequestProceed":
            MessageLookupByLibrary.simpleMessage("Procedi"),
        "login_Button_otpVerifyProceed":
            MessageLookupByLibrary.simpleMessage("Verifica"),
        "login_Button_otpVerifyRepeat":
            MessageLookupByLibrary.simpleMessage("Invia di nuovo il codice"),
        "login_Button_otpVerifyRepeatInterval": m1,
        "login_Button_signIn":
            MessageLookupByLibrary.simpleMessage("Registrazione"),
        "login_Button_signUpToDemoInstance":
            MessageLookupByLibrary.simpleMessage("Iscrizione"),
        "login_CoreVersionUnsupportedExceptionError": m2,
        "login_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di richiesta"),
        "login_RequestFailureCodeIncorrectError":
            MessageLookupByLibrary.simpleMessage("Codice di verifica errato"),
        "login_RequestFailureEmptyEmailError":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile inviare il codice di verifica"),
        "login_RequestFailureError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un guasto del server"),
        "login_RequestFailureOtpAlreadyVerifiedError":
            MessageLookupByLibrary.simpleMessage("Verifica già verificata"),
        "login_RequestFailureOtpExpiredError":
            MessageLookupByLibrary.simpleMessage("Verifica scaduta"),
        "login_RequestFailureOtpIdVerifyAttemptsExceededError":
            MessageLookupByLibrary.simpleMessage(
                "Tentativi di verifica superati"),
        "login_RequestFailureOtpNotFoundError":
            MessageLookupByLibrary.simpleMessage("Verifica non trovata"),
        "login_RequestFailurePhoneNotFoundError":
            MessageLookupByLibrary.simpleMessage(
                "Numero di telefono non trovato"),
        "login_RequestFailureUnconfiguredBundleIdError":
            MessageLookupByLibrary.simpleMessage(
                "Errore di configurazione del backend dell\'app - avvisare il proprio fornitore di servizi"),
        "login_SocketExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di rete"),
        "login_TextFieldLabelText_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(
                "Inserisci l\'URL del tuo PortaPhone"),
        "login_TextFieldLabelText_otpRequestEmail":
            MessageLookupByLibrary.simpleMessage("Inserisci la tua mail"),
        "login_TextFieldLabelText_otpRequestPhone":
            MessageLookupByLibrary.simpleMessage(
                "Inserisci il tuo numero di telefono"),
        "login_TextFieldLabelText_otpVerifyCode":
            MessageLookupByLibrary.simpleMessage(
                "Inserisci il codice di verifica"),
        "login_Text_coreUrlAssignPostDescription": m3,
        "login_Text_coreUrlAssignPreDescription":
            MessageLookupByLibrary.simpleMessage(
                "Per poter eseguire chiamate attraverso PortaPhone e PortaSwitch prego inserire l\'URL del server (come fornito dal tuo account manager) qui di seguito"),
        "login_Text_otpRequestDemoDescription":
            MessageLookupByLibrary.simpleMessage(
                "Se non hai ancora un account, questo verrà automaticamente creato"),
        "login_Text_otpRequestDescription":
            MessageLookupByLibrary.simpleMessage(""),
        "login_Text_otpVerifyCheckSpamFrom": m4,
        "login_Text_otpVerifyCheckSpamGeneral":
            MessageLookupByLibrary.simpleMessage(
                "Se non vedi un\'e-mail con il codice di verifica nella tua casella di posta, controlla la cartella della posta indesiderata."),
        "login_Text_otpVerifySentToEmail": m5,
        "login_Text_otpVerifySentToEmailAssignedWithPhone": m6,
        "login_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di rete sicura"),
        "login_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di richiesta"),
        "login_validationCoreUrlError": MessageLookupByLibrary.simpleMessage(
            "Prego inserisci un URL valido"),
        "login_validationEmailError": MessageLookupByLibrary.simpleMessage(
            "Inserire un indirizzo di email valido"),
        "login_validationPhoneError": MessageLookupByLibrary.simpleMessage(
            "Inserire un numero di telefono valido"),
        "main_BottomNavigationBarItemLabel_contacts":
            MessageLookupByLibrary.simpleMessage("Contatti"),
        "main_BottomNavigationBarItemLabel_favorites":
            MessageLookupByLibrary.simpleMessage("Favoriti"),
        "main_BottomNavigationBarItemLabel_keypad":
            MessageLookupByLibrary.simpleMessage("Tastiera"),
        "main_BottomNavigationBarItemLabel_recents":
            MessageLookupByLibrary.simpleMessage("Recenti"),
        "main_CompatibilityIssueDialogActions_logout":
            MessageLookupByLibrary.simpleMessage("Esci"),
        "main_CompatibilityIssueDialogActions_update":
            MessageLookupByLibrary.simpleMessage("Aggiornamento"),
        "main_CompatibilityIssueDialogActions_verify":
            MessageLookupByLibrary.simpleMessage("Controlla nuovamente"),
        "main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError":
            m7,
        "main_CompatibilityIssueDialog_title":
            MessageLookupByLibrary.simpleMessage("Problema di compatibilità"),
        "notImplemented": MessageLookupByLibrary.simpleMessage(
            "Spiacente, non ancora implementato"),
        "notifications_errorSnackBarAction_callUserMedia":
            MessageLookupByLibrary.simpleMessage("Verifica"),
        "notifications_errorSnackBar_callConnect":
            MessageLookupByLibrary.simpleMessage(
                "Connessione al server non riuscita, tentativo di riconnessione in corso"),
        "notifications_errorSnackBar_callSignalingClientNotConnect":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile eseguire la chiamata, verificare lo stato della connessione"),
        "notifications_errorSnackBar_callSignalingClientSessionMissed":
            MessageLookupByLibrary.simpleMessage(
                "L\'attuale sessione non risulta più attiva, si prega di accedere nuovamente"),
        "notifications_errorSnackBar_callUndefinedLine":
            MessageLookupByLibrary.simpleMessage(
                "Nessuna linea disponibile per avviare una chiamata"),
        "notifications_errorSnackBar_callUserMedia":
            MessageLookupByLibrary.simpleMessage(
                "Nessun accesso al server multimediale, controlla le autorizzazioni dell\'app"),
        "permission_Button_request":
            MessageLookupByLibrary.simpleMessage("Continua"),
        "permission_Text_description": MessageLookupByLibrary.simpleMessage(
            "Per garantire la migliore esperienza utente, all\'app devono essere concesse le seguenti autorizzazioni: microfono per le chiamate audio, fotocamera per le videochiamate e contatti per semplificare il raggiungimento degli utenti dall\'app.\n\nLe autorizzazioni possono essere modificate in qualsiasi momento anche successivamente."),
        "recentTimeAfterMidnight": m8,
        "recentTimeBeforeMidnight": m9,
        "recentsVisibilityFilter_all":
            MessageLookupByLibrary.simpleMessage("Tutto"),
        "recentsVisibilityFilter_incoming":
            MessageLookupByLibrary.simpleMessage("Entrante"),
        "recentsVisibilityFilter_missed":
            MessageLookupByLibrary.simpleMessage("Perse"),
        "recentsVisibilityFilter_outgoing":
            MessageLookupByLibrary.simpleMessage("Uscente"),
        "recents_BodyCenter_empty": m10,
        "recents_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Sei sicuro di voler eliminare il registro chiamate attuale?"),
        "recents_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confermare l\'eliminazione"),
        "recents_errorSnackBar_loadFailure":
            MessageLookupByLibrary.simpleMessage(
                "Spiacenti... si è verificato un errore ☹️"),
        "recents_snackBar_deleted": m11,
        "settings_AboutText_CoreVersionUndefined":
            MessageLookupByLibrary.simpleMessage("?.?.?"),
        "settings_AccountDeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Sei sicuro di voler eliminare l\'account?"),
        "settings_AccountDeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Conferma eliminazione account"),
        "settings_AppBarTitle_myAccount":
            MessageLookupByLibrary.simpleMessage("Il mio account"),
        "settings_ForceLogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Sei sicuro di voler forzare il logout?"),
        "settings_ForceLogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Conferma il logout forzato"),
        "settings_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di richiesta"),
        "settings_ListViewTileTitle_about":
            MessageLookupByLibrary.simpleMessage("Riguardo a"),
        "settings_ListViewTileTitle_accountDelete":
            MessageLookupByLibrary.simpleMessage("Elimina account"),
        "settings_ListViewTileTitle_help":
            MessageLookupByLibrary.simpleMessage("Aiuto"),
        "settings_ListViewTileTitle_language":
            MessageLookupByLibrary.simpleMessage("Linguaggio"),
        "settings_ListViewTileTitle_logRecordsConsole":
            MessageLookupByLibrary.simpleMessage("Console dei registri di log"),
        "settings_ListViewTileTitle_logout":
            MessageLookupByLibrary.simpleMessage("Esci"),
        "settings_ListViewTileTitle_network":
            MessageLookupByLibrary.simpleMessage("Impostazioni di rete"),
        "settings_ListViewTileTitle_registered":
            MessageLookupByLibrary.simpleMessage("Registrato"),
        "settings_ListViewTileTitle_settings":
            MessageLookupByLibrary.simpleMessage("IMPOSTAZIONI"),
        "settings_ListViewTileTitle_termsConditions":
            MessageLookupByLibrary.simpleMessage("Termini e condizioni"),
        "settings_ListViewTileTitle_themeMode":
            MessageLookupByLibrary.simpleMessage("Modalità tema"),
        "settings_ListViewTileTitle_toolbox":
            MessageLookupByLibrary.simpleMessage("TOOLBOX"),
        "settings_LogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage("Sei sicuro di voler uscire?"),
        "settings_LogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Confermare la disconnessione"),
        "settings_RequestFailureError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un guasto del server"),
        "settings_SocketExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di rete"),
        "settings_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di rete sicura"),
        "settings_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Si è verificato un problema di richiesta"),
        "themeMode_dark": MessageLookupByLibrary.simpleMessage("Scuro"),
        "themeMode_light": MessageLookupByLibrary.simpleMessage("Luce"),
        "themeMode_system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "underDevelopment": MessageLookupByLibrary.simpleMessage(
            "Questa pagina è in fase di sviluppo."),
        "validationBlankError":
            MessageLookupByLibrary.simpleMessage("Prego inserire un valore"),
        "webRegistration_ErrorAcknowledgeDialogActions_demo":
            MessageLookupByLibrary.simpleMessage("Demo"),
        "webRegistration_ErrorAcknowledgeDialogActions_retry":
            MessageLookupByLibrary.simpleMessage("Riprovare"),
        "webRegistration_ErrorAcknowledgeDialogActions_skip":
            MessageLookupByLibrary.simpleMessage("Skip"),
        "webRegistration_ErrorAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Errore risorsa web")
      };
}
