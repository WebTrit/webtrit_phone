import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get alertDialogActions_no => 'No';

  @override
  String get alertDialogActions_ok => 'Ok';

  @override
  String get alertDialogActions_yes => 'Si';

  @override
  String get call_CallActionsTooltip_accept => 'Accetta chiamata';

  @override
  String get call_CallActionsTooltip_disableCamera => 'Disattiva video';

  @override
  String get call_CallActionsTooltip_disableSpeaker => 'Disattiva vivavoce';

  @override
  String get call_CallActionsTooltip_enableCamera => 'Attiva video';

  @override
  String get call_CallActionsTooltip_enableSpeaker => 'Attiva vivavoce';

  @override
  String get call_CallActionsTooltip_hangup => 'Termina chiamata';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'Nascondi tastiera';

  @override
  String get call_CallActionsTooltip_hold => 'Attesa';

  @override
  String get call_CallActionsTooltip_mute => 'Disattiva il microfono';

  @override
  String get call_CallActionsTooltip_showKeypad => 'Mostra tastiera';

  @override
  String get call_CallActionsTooltip_transfer => 'Trasferimento';

  @override
  String get call_CallActionsTooltip_unhold => 'Ripresa chiamata';

  @override
  String get call_CallActionsTooltip_unmute => 'Attiva il microfono';

  @override
  String get call_description_incoming => 'Chiamata in arrivo';

  @override
  String get call_description_outgoing => 'Chiamata in corso';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Guasto';

  @override
  String get callStatus_appUnregistered => 'Non registrato';

  @override
  String get callStatus_connectError => 'Errore di connessione';

  @override
  String get callStatus_connectIssue => 'Problemi di connessione';

  @override
  String get callStatus_connectivityNone => 'Nessuna connessione internet';

  @override
  String get callStatus_inProgress => 'Connessione in corso';

  @override
  String get callStatus_ready => 'Connessione stabilita';

  @override
  String get contacts_ExternalTabButton_refresh => 'Refresh';

  @override
  String get contacts_ExternalTabText_empty => 'Nessun contatto';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'Nessun contatto trovato';

  @override
  String get contacts_ExternalTabText_failure => 'Impossibile ottenere i contatti del centralino cloud';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'Grant access to your phone contacts';

  @override
  String get contacts_LocalTabButton_refresh => 'Refresh';

  @override
  String get contacts_LocalTabText_empty => 'Nessun contatto';

  @override
  String get contacts_LocalTabText_emptyOnSearching => 'Nessun contatto trovato';

  @override
  String get contacts_LocalTabText_failure => 'Impossibile ottenere i tuoi contatti telefonici';

  @override
  String get contacts_LocalTabText_permissionFailure => 'Non ci sono i permessi per ottenere i tuoi contatti telefonici';

  @override
  String get contactsSourceExternal => 'Centralino cloud';

  @override
  String get contactsSourceLocal => 'Il tuo telefono';

  @override
  String get copyToClipboard_floatingSnackBar => 'Testo copiato';

  @override
  String get copyToClipboard_popupMenuItem => 'Copia negli appunti';

  @override
  String get default_ClientExceptionError => 'Si è verificato un problema con il client HTTP';

  @override
  String get default_FormatExceptionError => 'Si è verificato un problema di risposta';

  @override
  String get default_RequestFailureError => 'Si è verificato un errore del server';

  @override
  String get default_SocketExceptionError => 'Si è verificato un problema di rete';

  @override
  String get default_TlsExceptionError => 'Si è verificato un problema di rete sicuro';

  @override
  String get default_TypeErrorError => 'Si è verificato un problema di risposta';

  @override
  String get default_UnauthorizedRequestFailureError => 'Si è verificato un errore di richiesta non autorizzata';

  @override
  String get favorites_BodyCenter_empty => 'Nessun numero preferito';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Sei sicuro di voler eliminare il contatto preferito?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Confermare l\'eliminazione';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name cancellato';
  }

  @override
  String get locale_default => 'Predefinito';

  @override
  String get locale_en => 'Inglese';

  @override
  String get login_AppBarTitle_coreUrlAssign => '';

  @override
  String get login_AppBarTitle_otpRequest => '';

  @override
  String get login_AppBarTitle_otpVerify => '';

  @override
  String get login_Button_coreUrlAssignProceed => 'Procedi';

  @override
  String get login_Button_otpRequestProceed => 'Procedi';

  @override
  String get login_Button_otpVerifyProceed => 'Verifica';

  @override
  String get login_Button_otpVerifyRepeat => 'Invia di nuovo il codice';

  @override
  String login_Button_otpVerifyRepeatInterval(int seconds) {
    return 'Invia di nuovo il codice ($seconds s)';
  }

  @override
  String get login_Button_signIn => 'Registrazione';

  @override
  String get login_Button_signUpToDemoInstance => 'Iscrizione';

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Accedi a PortaPhone';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'È stata fornita una versione di richiesta incompatibile, contattare l\'amministratore del sistema (actual:$actual, supported:$supportedConstraint)';
  }

  @override
  String get login_FormatExceptionError => 'Si è verificato un problema di richiesta';

  @override
  String get login_RequestFailureCodeIncorrectError => 'Codice di verifica errato';

  @override
  String get login_RequestFailureEmptyEmailError => 'Impossibile inviare il codice di verifica';

  @override
  String get login_RequestFailureError => 'Si è verificato un guasto del server';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Verifica già verificata';

  @override
  String get login_RequestFailureOtpExpiredError => 'Verifica scaduta';

  @override
  String get login_RequestFailureOtpIdVerifyAttemptsExceededError => 'Tentativi di verifica superati';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Verifica non trovata';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Numero di telefono non trovato';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'Errore di configurazione del backend dell\'app - avvisare il proprio fornitore di servizi';

  @override
  String get login_SocketExceptionError => 'Si è verificato un problema di rete';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Se non hai ancora il tuo proprio WebTrit Cloud Backend, contatta il team vendite all\'indirizzo $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'Per poter eseguire chiamate attraverso PortaPhone e PortaSwitch prego inserire l\'URL del server (come fornito dal tuo account manager) qui di seguito';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Inserisci l\'URL del tuo PortaPhone';

  @override
  String get login_TextFieldLabelText_otpRequestEmail => 'Inserisci la tua mail';

  @override
  String get login_TextFieldLabelText_otpRequestPhone => 'Inserisci il tuo numero di telefono';

  @override
  String get login_TextFieldLabelText_otpVerifyCode => 'Inserisci il codice di verifica';

  @override
  String get login_Text_otpRequestDemoDescription => 'Se non hai ancora un account, questo verrà automaticamente creato';

  @override
  String get login_Text_otpRequestDescription => '';

  @override
  String login_Text_otpVerifyCheckSpamFrom(String email) {
    return 'Se non vedi un\'e-mail con il codice di verifica da $email nella tua casella di posta, controlla la cartella dello spam.';
  }

  @override
  String get login_Text_otpVerifyCheckSpamGeneral => 'Se non vedi un\'e-mail con il codice di verifica nella tua casella di posta, controlla la cartella della posta indesiderata.';

  @override
  String login_Text_otpVerifySentToEmail(String email) {
    return 'Il codice di verifica temporaneo ti è stato inviato via $email';
  }

  @override
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return 'Il codice di verifica temporaneo ti è stato inviato alla mail associata al telefono:$phone numero di telefono.';
  }

  @override
  String get login_TlsExceptionError => 'Si è verificato un problema di rete sicura';

  @override
  String get login_TypeErrorError => 'Si è verificato un problema di richiesta';

  @override
  String get login_validationCoreUrlError => 'Prego inserisci un URL valido';

  @override
  String get login_validationEmailError => 'Inserire un indirizzo di email valido';

  @override
  String get login_validationPhoneError => 'Inserire un numero di telefono valido';

  @override
  String get logRecordsConsole_AppBarTitle => 'Console dei log';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Refresh';

  @override
  String get logRecordsConsole_Text_failure => 'Si è verificato un errore ☹';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => 'Contatti';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => 'Favoriti';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => 'Tastiera';

  @override
  String get main_BottomNavigationBarItemLabel_recents => 'Recenti';

  @override
  String get main_CompatibilityIssueDialogActions_logout => 'Esci';

  @override
  String get main_CompatibilityIssueDialogActions_update => 'Aggiornamento';

  @override
  String get main_CompatibilityIssueDialogActions_verify => 'Controlla nuovamente';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Versione di PortaPhone incompatibile, contattare l\'amministratore del sistema (actual:actual';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Problema di compatibilità';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Verifica';

  @override
  String get notifications_errorSnackBar_callConnect => 'Connessione al server non riuscita, tentativo di riconnessione in corso';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'Impossibile eseguire la chiamata, verificare lo stato della connessione';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'L\'attuale sessione non risulta più attiva, si prega di accedere nuovamente';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'Nessuna linea disponibile per avviare una chiamata';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'Nessun accesso al server multimediale, controlla le autorizzazioni dell\'app';

  @override
  String get notImplemented => 'Spiacente, non ancora implementato';

  @override
  String get permission_Button_request => 'Continua';

  @override
  String get permission_Text_description => 'Per garantire la migliore esperienza utente, all\'app devono essere concesse le seguenti autorizzazioni: microfono per le chiamate audio, fotocamera per le videochiamate e contatti per semplificare il raggiungimento degli utenti dall\'app.\n\nLe autorizzazioni possono essere modificate in qualsiasi momento anche successivamente.';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'Attualmente non hai chiamate recenti con $filter.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => 'Sei sicuro di voler eliminare il registro chiamate attuale?';

  @override
  String get recents_DeleteConfirmDialog_title => 'Confermare l\'eliminazione';

  @override
  String get recents_errorSnackBar_loadFailure => 'Spiacenti... si è verificato un errore ☹️';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name cancellato';
  }

  @override
  String get recentsVisibilityFilter_all => 'Tutto';

  @override
  String get recentsVisibilityFilter_incoming => 'Entrante';

  @override
  String get recentsVisibilityFilter_missed => 'Perse';

  @override
  String get recentsVisibilityFilter_outgoing => 'Uscente';

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
  String get settings_AccountDeleteConfirmDialog_content => 'Sei sicuro di voler eliminare l\'account?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Conferma eliminazione account';

  @override
  String get settings_AppBarTitle_myAccount => 'Il mio account';

  @override
  String get settings_ForceLogoutConfirmDialog_content => 'Sei sicuro di voler forzare il logout?';

  @override
  String get settings_ForceLogoutConfirmDialog_title => 'Conferma il logout forzato';

  @override
  String get settings_FormatExceptionError => 'Si è verificato un problema di richiesta';

  @override
  String get settings_ListViewTileTitle_about => 'Riguardo a';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Elimina account';

  @override
  String get settings_ListViewTileTitle_help => 'Aiuto';

  @override
  String get settings_ListViewTileTitle_language => 'Linguaggio';

  @override
  String get settings_ListViewTileTitle_logout => 'Esci';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => 'Console dei registri di log';

  @override
  String get settings_ListViewTileTitle_network => 'Impostazioni di rete';

  @override
  String get settings_ListViewTileTitle_registered => 'Registrato';

  @override
  String get settings_ListViewTileTitle_settings => 'IMPOSTAZIONI';

  @override
  String get settings_ListViewTileTitle_termsConditions => 'Termini e condizioni';

  @override
  String get settings_ListViewTileTitle_themeMode => 'Modalità tema';

  @override
  String get settings_ListViewTileTitle_toolbox => 'TOOLBOX';

  @override
  String get settings_LogoutConfirmDialog_content => 'Sei sicuro di voler uscire?';

  @override
  String get settings_LogoutConfirmDialog_title => 'Confermare la disconnessione';

  @override
  String get settings_RequestFailureError => 'Si è verificato un guasto del server';

  @override
  String get settings_SocketExceptionError => 'Si è verificato un problema di rete';

  @override
  String get settings_TlsExceptionError => 'Si è verificato un problema di rete sicura';

  @override
  String get settings_TypeErrorError => 'Si è verificato un problema di richiesta';

  @override
  String get themeMode_dark => 'Scuro';

  @override
  String get themeMode_light => 'Luce';

  @override
  String get themeMode_system => 'Sistema';

  @override
  String get underDevelopment => 'Questa pagina è in fase di sviluppo.';

  @override
  String get validationBlankError => 'Prego inserire un valore';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_demo => 'Demo';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Riprovare';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Skip';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Errore risorsa web';
}
