import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get account_selfCarePasswordExpired_message => 'La tua password di self-care è scaduta. Ti preghiamo di aggiornarla utilizzando il self-care.\nFino a quando la password non sarà cambiata, l\'accesso al servizio sarà limitato.';

  @override
  String get alertDialogActions_no => 'No';

  @override
  String get alertDialogActions_ok => 'Ok';

  @override
  String get alertDialogActions_yes => 'Si';

  @override
  String get autoprovision_errorSnackBar_invalidToken => 'Le credenziali di configurazione automatica sono state rifiutate dal server. Richiedi nuovamente le credenziali';

  @override
  String get autoprovision_ReloginDialog_confirm => 'Confermare';

  @override
  String get autoprovision_ReloginDialog_decline => 'Rifiuto';

  @override
  String get autoprovision_ReloginDialog_text => 'Vuoi usare le nuove credenziali di accesso?,  Utilizza il seguente link, verrai automaticamente disconnesso  da questa sessione';

  @override
  String get autoprovision_ReloginDialog_title => 'Conferma di nuovo accesso';

  @override
  String get autoprovision_successSnackBar_used => 'Le vostre impostazioni sono state recuperate con successo, l\'App è pronta per l\'uso';

  @override
  String get call_CallActionsTooltip_accept => 'Accetta chiamata';

  @override
  String get call_CallActionsTooltip_accept_inviteToAttendedTransfer => 'Accetta trasferimento';

  @override
  String get call_CallActionsTooltip_attended_transfer => 'Trasferimento assistito';

  @override
  String get call_CallActionsTooltip_decline_inviteToAttendedTransfer => 'Rifiuta trasferimento';

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
  String get call_CallActionsTooltip_hangupAndAccept => 'Riagganciare e accettare';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'Nascondi tastiera';

  @override
  String get call_CallActionsTooltip_hold => 'Attesa';

  @override
  String get call_CallActionsTooltip_holdAndAccept => 'Tenere in attesa e accettare';

  @override
  String get call_CallActionsTooltip_mute => 'Disattiva il microfono';

  @override
  String get call_CallActionsTooltip_showKeypad => 'Mostra tastiera';

  @override
  String get call_CallActionsTooltip_swap => 'Scambio chiamate';

  @override
  String get call_CallActionsTooltip_transfer => 'Trasferimento';

  @override
  String get call_CallActionsTooltip_transfer_choose => 'Scegliere il numero';

  @override
  String get call_CallActionsTooltip_unattended_transfer => 'Trasferimento non assistito';

  @override
  String get call_CallActionsTooltip_unhold => 'Ripresa chiamata';

  @override
  String get call_CallActionsTooltip_unmute => 'Attiva il microfono';

  @override
  String get call_description_held => 'In attesa';

  @override
  String get call_description_incoming => 'Chiamata in arrivo';

  @override
  String get call_description_inviteToAttendedTransfer => 'Sei stato invitato a unirti a una chiamata di trasferimento assistito';

  @override
  String get call_description_outgoing => 'Chiamata in corso';

  @override
  String get call_description_requestToAttendedTransfer => 'Richiesta di trasferimento';

  @override
  String get call_description_transferProcessing => 'Elaborazione del trasferimento';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Guasto';

  @override
  String get callProcessingStatus_answering => 'Rispondendo alla chiamata, attendi prego…';

  @override
  String get callProcessingStatus_disconnecting => 'Desconectando la llamada, por favor espere…';

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
  String get call_ThumbnailAvatar_currentlyNoActiveCall => 'Actualmente, no hay ninguna llamada activa';

  @override
  String get common_noInternetConnection_message => 'Sembra che tu non sia connesso a Internet. Controlla la tua connessione e riprova.';

  @override
  String get common_noInternetConnection_retryButton => 'Riprova';

  @override
  String get common_noInternetConnection_title => 'Nessuna connessione Internet';

  @override
  String get common_problemWithLoadingPage => 'Si è verificato un problema durante il caricamento della pagina.';

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
  String get contacts_Text_blingTransferInitiated => 'Trasferimento senza vedere';

  @override
  String get copyToClipboard_floatingSnackBar => 'Testo copiato';

  @override
  String get copyToClipboard_popupMenuItem => 'Copia negli appunti';

  @override
  String get default_CannotRemoveOwnerMessagingSocketException => 'Impossibile rimuovere il proprietario';

  @override
  String get default_ChatMemberNotFoundMessagingSocketException => 'Membro della chat non trovato';

  @override
  String get default_ChatNotFoundMessagingSocketException => 'Chat non trovata';

  @override
  String get default_ClientExceptionError => 'Si è verificato un problema con il client HTTP';

  @override
  String get default_ErrorDetails => 'Dettagli dell\'errore';

  @override
  String get default_ErrorMessage => 'Messaggio di errore';

  @override
  String get default_ErrorPath => 'Error path';

  @override
  String get default_ErrorTransactionId => 'ID transazione';

  @override
  String get default_ForbiddenMessagingSocketException => 'Vietato';

  @override
  String get default_FormatExceptionError => 'Si è verificato un problema di formato della risposta';

  @override
  String get default_InternalErrorMessagingSocketException => 'Errore interno del server';

  @override
  String get default_InvalidChatTypeMessagingSocketException => 'Tipo di chat non valido';

  @override
  String get default_MessagingSocketException => 'Si è verificato un errore durante la comunicazione con il server';

  @override
  String get default_JoinCrashedMessagingSocketException => 'Si è verificato un errore durante l\'adesione alla conversazione';

  @override
  String get default_RequestFailureError => 'Si è verificato un errore del server';

  @override
  String get default_SelfAuthorityAssignmentForbiddenMessagingSocketException => 'Assegnazione di autorità a se stessi vietata';

  @override
  String get default_SelfRemovalForbiddenMessagingSocketException => 'Rimozione di se stessi vietata';

  @override
  String get default_SmsConversationNotFoundMessagingSocketException => 'Conversazione SMS non trovata';

  @override
  String get default_SocketExceptionError => 'Si è verificato un problema di rete';

  @override
  String get default_TimeoutExceptionError => 'Si è verificato un problema di timeout del server';

  @override
  String get default_TimeoutMessagingSocketException => 'Tempo di attesa scaduto';

  @override
  String get default_TlsExceptionError => 'Si è verificato un problema con il protocollo di rete sicuro (TLS/SSL)';

  @override
  String get default_TypeErrorError => 'Si è verificato un problema di risposta';

  @override
  String get default_UnauthorizedMessagingSocketException => 'Non autorizzato';

  @override
  String get default_UnauthorizedRequestFailureError => 'Si è verificato un errore di richiesta non autorizzata';

  @override
  String get default_UserAlreadyInChatMessagingSocketException => 'Utente già nella chat';

  @override
  String get diagnostic_AppBar_title => 'Diagnostica';

  @override
  String get diagnostic_battery_groupTitle => 'Batteria';

  @override
  String get diagnostic_batteryMode_optimized_description => 'L\'attività in background dell\'app è gestita dal sistema per risparmiare batteria. Potrebbe non funzionare correttamente con chiamate in arrivo attivate da notifiche push.';

  @override
  String get diagnostic_batteryMode_optimized_title => 'Ottimizzato';

  @override
  String get diagnostic_batteryMode_restricted_description => 'L\'attività in background dell\'app è fortemente limitata per conservare la batteria. Potrebbero essere perse chiamate in arrivo.';

  @override
  String get diagnostic_batteryMode_restricted_title => 'Limitato';

  @override
  String get diagnostic_batteryMode_unknown_description => 'Lo stato della modalità batteria è sconosciuto. L\'app potrebbe avere un comportamento imprevedibile.';

  @override
  String get diagnostic_batteryMode_unknown_title => 'Sconosciuto';

  @override
  String get diagnostic_batteryMode_unrestricted_description => 'L\'app ha pieno accesso per funzionare in background senza restrizioni.';

  @override
  String get diagnostic_batteryMode_unrestricted_title => 'Senza restrizioni';

  @override
  String get diagnostic_battery_navigate_section => 'Vai alla sezione Batteria';

  @override
  String get diagnostic_battery_tile_title => 'Modalità batteria';

  @override
  String get diagnostic_permission_camera_description => 'Questa app richiede il permesso di accedere alla fotocamera per effettuare videochiamate.';

  @override
  String get diagnostic_permission_camera_title => 'Fotocamera';

  @override
  String get diagnostic_permission_contacts_description => 'Questa app richiede il permesso di accedere ai contatti per effettuare chiamate dalla tua rubrica.';

  @override
  String get diagnostic_permission_contacts_title => 'Contatti';

  @override
  String get diagnosticPermissionDetails_button_managePermission => 'Gestisci permessi';

  @override
  String get diagnosticPermissionDetails_button_requestPermission => 'Richiedi permesso';

  @override
  String get diagnosticPermissionDetails_title_statusPermission => 'Stato del permesso';

  @override
  String get diagnostic_permission_microphone_description => 'Questa app richiede il permesso di accedere al microfono per effettuare chiamate audio.';

  @override
  String get diagnostic_permission_microphone_title => 'Microfono';

  @override
  String get diagnostic_permission_notification_description => 'Permette all\'app di attivare le chiamate in arrivo.';

  @override
  String get diagnostic_permission_notification_title => 'Notifiche';

  @override
  String get diagnostic_permissionStatus_denied => 'Accesso negato';

  @override
  String get diagnostic_permissionStatus_granted => 'Accesso consentito';

  @override
  String get diagnostic_permissionStatus_limited => 'Accesso limitato';

  @override
  String get diagnostic_permissionStatus_permanentlyDenied => 'Accesso permanentemente negato';

  @override
  String get diagnostic_permissionStatus_provisional => 'Accesso provvisorio';

  @override
  String get diagnostic_permissionStatus_restricted => 'Accesso limitato';

  @override
  String get diagnosticPushDetails_configuration_title => 'Configurazione del servizio di notifiche push';

  @override
  String get diagnosticPushDetails_errorMessage_intro => 'Alcuni passi da provare:\n';

  @override
  String get diagnosticPushDetails_errorMessage_step1 => '1. Assicurati che il telefono sia connesso a Internet.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step2 => '2. Se connesso, verifica che il telefono possa accedere ai servizi Google visitando un sito web.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step3 => '3. Aspetta qualche minuto e riprova – i server di messaggistica Firebase potrebbero essere temporaneamente inattivi.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step4 => '4. Riavvia i servizi di Google Play per assicurarne il corretto funzionamento.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step5 => '5. Verifica che i servizi di Google Play siano installati sul tuo dispositivo.\n';

  @override
  String get diagnosticPushDetails_successMessage => 'Il servizio di notifica è stato configurato con successo ed è pronto per l’uso per ricevere messaggi e gestire le chiamate in arrivo.';

  @override
  String get diagnostic_pushTokenStatusType_progress => 'In corso';

  @override
  String get diagnostic_pushTokenStatusType_success => 'Servizio configurato con successo';

  @override
  String get diagnosticScreen_permissionsGroup_title => 'Permessi';

  @override
  String get diagnosticScreen_pushNotificationService_title => 'Servizio di notifiche push';

  @override
  String get favorites_BodyCenter_empty => 'Al momento non hai numeri preferiti.\nAggiungi ai preferiti dai Contatti usando l\'icona a stella';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Sei sicuro di voler eliminare il contatto preferito?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Confermare l\'eliminazione';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name cancellato';
  }

  @override
  String get favorites_Text_blingTransferInitiated => 'Trasferimento senza vedere';

  @override
  String get locale_default => 'Predefinito';

  @override
  String get locale_en => 'Inglese';

  @override
  String get locale_it => 'Italiano';

  @override
  String get locale_uk => 'Ucraino';

  @override
  String get login_Button_coreUrlAssignProceed => 'Procedi';

  @override
  String get login_Button_otpSigninRequestProceed => 'Procedi';

  @override
  String get login_Button_otpSigninVerifyProceed => 'Verifica';

  @override
  String get login_Button_otpSigninVerifyRepeat => 'Invia di nuovo il codice';

  @override
  String login_Button_otpSigninVerifyRepeatInterval(int seconds) {
    return 'Invia di nuovo il codice ($seconds s)';
  }

  @override
  String get login_Button_passwordSigninProceed => 'Procedi';

  @override
  String get login_Button_signIn => 'Registrazione';

  @override
  String get login_Button_signupRequestProceed => 'Procedi';

  @override
  String get login_Button_signUpToDemoInstance => 'Iscrizione';

  @override
  String get login_Button_signupVerifyProceed => 'Verifica';

  @override
  String get login_Button_signupVerifyRepeat => 'Invia di nuovo il codice';

  @override
  String login_Button_signupVerifyRepeatInterval(int seconds) {
    return 'Invia di nuovo il codice ($seconds s)';
  }

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Accedi al tuo WebTrit Cloud Backend';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'È stata fornita una versione di richiesta incompatibile, contattare l\'amministratore del sistema (actual:$actual, supported:$supportedConstraint)';
  }

  @override
  String get login_RequestFailureEmptyEmailError => 'Impossibile inviare il codice di verifica';

  @override
  String get login_RequestFailureIdentifierIsNotValid => 'Il tuo ID risulta non valido perché inesistente';

  @override
  String get login_RequestFailureIncorrectOtpCodeError => 'Codice di verifica errato';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Verifica già verificata';

  @override
  String get login_RequestFailureOtpExpiredError => 'Verifica scaduta';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Verifica non trovata';

  @override
  String get login_RequestFailureOtpVerificationAttemptsExceededError => 'Tentativi di verifica superati';

  @override
  String get login_RequestFailureParametersApplyIssueError => 'I dati forniti non possono essere elaborati';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Numero di telefono non trovato';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'Errore di configurazione del backend dell\'app - avvisare il proprio fornitore di servizi';

  @override
  String get login_SupportedLoginTypeMissedExceptionError => 'L\'attuale Backend Cloud di WebTrit non supporta nessun tipo di accesso compatibile con questa app';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Se non hai ancora il tuo proprio WebTrit Cloud Backend, contatta il team vendite all\'indirizzo $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'Per effettuare chiamate tramite il tuo sistema VoIP, inserisci l\'URL di WebTrit Cloud Backend (come fornito dal tuo account manager) di seguito.';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Inserisci l\'URL del tuo WebTrit Cloud Backend';

  @override
  String get login_TextFieldLabelText_otpSigninCode => 'Inserisci il codice di verifica';

  @override
  String get login_TextFieldLabelText_otpSigninUserRef => 'Inserisci il tuo numero di telefono o la tua email';

  @override
  String get login_TextFieldLabelText_passwordSigninPassword => 'Inserisci la tua password';

  @override
  String get login_TextFieldLabelText_passwordSigninUserRef => 'Inserisci il tuo numero di telefono o la tua email';

  @override
  String get login_TextFieldLabelText_signupCode => 'Inserisci il codice di verifica';

  @override
  String get login_TextFieldLabelText_signupEmail => 'Inserisci la tua mail';

  @override
  String get login_Text_otpSigninRequestPostDescription => '';

  @override
  String get login_Text_otpSigninRequestPreDescription => '';

  @override
  String login_Text_otpSigninVerifyPostDescriptionFromEmail(String email) {
    return 'Se non vedi un’email con il codice di verifica da $email nella tua casella di posta, controlla la cartella dello spam.';
  }

  @override
  String get login_Text_otpSigninVerifyPostDescriptionGeneral => 'Se non vedi un\'e-mail con il codice di verifica nella tua casella di posta, controlla la cartella della posta indesiderata.';

  @override
  String login_Text_otpSigninVerifyPreDescriptionUserRef(String userRef) {
    return 'Un codice di verifica monouso è stato inviato all\'email associata al numero di telefono o all\'email fornita.';
  }

  @override
  String get login_Text_passwordSigninPostDescription => '';

  @override
  String get login_Text_passwordSigninPreDescription => '';

  @override
  String get login_Text_signupRequestPostDescription => '';

  @override
  String get login_Text_signupRequestPostDescriptionDemo => 'Se non hai ancora un account, questo verrà automaticamente creato';

  @override
  String get login_Text_signupRequestPreDescription => '';

  @override
  String get login_Text_signupRequestPreDescriptionDemo => '';

  @override
  String login_Text_signupVerifyPostDescriptionFromEmail(String email) {
    return 'Se non vedi un\'email con il codice di verifica da $email nella tua casella di posta in arrivo, controlla nella cartella dello spam.';
  }

  @override
  String get login_Text_signupVerifyPostDescriptionGeneral => 'Se non vedi un\'e-mail con il codice di verifica nella tua casella di posta, controlla la cartella della posta indesiderata.';

  @override
  String login_Text_signupVerifyPreDescriptionEmail(String email) {
    return 'Il codice di verifica temporaneo ti è stato inviato via $email';
  }

  @override
  String get loginType_otpSignin => 'Accesso con OTP';

  @override
  String get loginType_passwordSignin => 'Accesso con password';

  @override
  String get loginType_signup => 'Iscrizione';

  @override
  String get login_validationCoreUrlError => 'Prego inserisci un URL valido';

  @override
  String get login_validationEmailError => 'Inserire un indirizzo di email valido';

  @override
  String get login_validationPhoneError => 'Inserire un numero di telefono valido';

  @override
  String get login_validationUserRefError => 'Per favore, inserisci un numero di telefono o un\'email valida';

  @override
  String get logRecordsConsole_AppBarTitle => 'Console dei log';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Refresh';

  @override
  String get logRecordsConsole_Text_failure => 'Si è verificato un errore imprevisto';

  @override
  String get main_BottomNavigationBarItemLabel_chats => 'Le chat';

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
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Versione di WebTrit Cloud Backend incompatibile, si prega di contattare l\'amministratore del sistema.\n\nVersione dell\'istanza:\n$actual\n\nVersione supportata:\n$supportedConstraint\n';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Problema di compatibilità';

  @override
  String get messaging_ActionBtn_retry => 'Riprova';

  @override
  String get messaging_ChooseContact_cancel => 'Cancellare';

  @override
  String get messaging_ChooseContact_empty => 'Nessun contatto trovato';

  @override
  String get messaging_ChooseContact_title => 'Scegli il contatto:';

  @override
  String get messaging_ConfirmDialog_ask => 'SÌ?';

  @override
  String get messaging_ConfirmDialog_cancel => 'No';

  @override
  String get messaging_ConfirmDialog_confirm => 'SÌ';

  @override
  String get messaging_ConversationBuilders_addUserBtnText => 'Aggiungi utente';

  @override
  String get messaging_ConversationBuilders_back => 'Dopo';

  @override
  String get messaging_ConversationBuilders_back_action => 'Dopo';

  @override
  String get messaging_ConversationBuilders_cancel => 'Cancellare';

  @override
  String get messaging_ConversationBuilders_connectionError => 'Errore di connessione, riprova più tardi';

  @override
  String get messaging_ConversationBuilders_contactOrNumberSearch_hint => 'Inserisci nome o numero di telefono';

  @override
  String get messaging_ConversationBuilders_contactSearch_hint => 'Cerca contatti';

  @override
  String get messaging_ConversationBuilders_create => 'Creare';

  @override
  String get messaging_ConversationBuilders_createGroup => 'Crea gruppo';

  @override
  String get messaging_ConversationBuilders_externalContacts_heading => 'Contatti Cloud PBX';

  @override
  String get messaging_ConversationBuilders_groupNameHeadline => 'Nome del gruppo';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message1 => 'Il tsontact ha un numero di telefono non valido. Dovrebbe essere nel formato ';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message2 => '. Per favore, lo trovi nella nostra rubrica.';

  @override
  String get messaging_ConversationBuilders_invalidNumber_ok => 'Tslose';

  @override
  String get messaging_ConversationBuilders_invalidNumber_title => 'Numero di telefono disabilitato';

  @override
  String get messaging_ConversationBuilders_invite_heading => 'Invita utenti:';

  @override
  String get messaging_ConversationBuilders_localContacts_heading => 'Contatti locali';

  @override
  String get messaging_ConversationBuilders_membersHeadline => 'Membri';

  @override
  String get messaging_ConversationBuilders_nameFieldEmpty => 'Inserisci un nome di gruppo';

  @override
  String get messaging_ConversationBuilders_nameFieldLabel => 'Nome del gruppo';

  @override
  String get messaging_ConversationBuilders_nameFieldShort => 'Il nome del gruppo deve essere composto da almeno 3 caratteri';

  @override
  String get messaging_ConversationBuilders_next_action => 'Prossima';

  @override
  String get messaging_ConversationBuilders_noContacts => 'Non ci sono contatti che corrispondono al risultato della ricerca';

  @override
  String get messaging_ConversationBuilders_numberFormatExample => '+ [prefisso nazionale] [prefisso operatore] [numero abbonato]';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorError => 'Il numero di telefono inserito non è valido. Deve essere inserito nel formato: ';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorHint => 'Formato del numero di telefono: ';

  @override
  String get messaging_ConversationBuilders_submitBtnText => 'Invia';

  @override
  String get messaging_ConversationBuilders_submitError => 'Si è verificato un errore durante la creazione del gruppo, riprovare.';

  @override
  String get messaging_ConversationBuilders_title_group => 'Crea gruppo';

  @override
  String get messaging_ConversationBuilders_title_new => 'Nuova chat';

  @override
  String get messaging_Conversation_failure => 'Errore di caricamento della conversazione';

  @override
  String get messaging_ConversationScreen_titlePrefix => 'Dialogo:';

  @override
  String get messaging_ConversationsScreen_chatsSearch_hint => 'Inserisci il nome della chat o dell\'utente';

  @override
  String get messaging_ConversationsScreen_empty => 'Nessuna conversazione è ancora iniziata';

  @override
  String get messaging_ConversationsScreen_messages_title => 'Messaggi';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_text => 'Per inviare messaggi SMS è necessario avere un numero di telefono collegato al tuo account';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_title => 'Nessun numero di telefono';

  @override
  String get messaging_ConversationsScreen_selectNumberSheet_title => 'Seleziona un numero';

  @override
  String get messaging_ConversationsScreen_smses_title => 'SMS';

  @override
  String get messaging_ConversationsScreen_smssSearch_hint => 'Inserisci il numero di telefono';

  @override
  String get messaging_ConversationsScreen_startDialog => 'Avvia dialogo';

  @override
  String get messaging_ConversationsScreen_unsupported => 'La messaggistica non è supportata dal sistema remoto, contattare l\'amministratore per abilitarla';

  @override
  String get messaging_Conversations_tile_empty => 'Nessun messaggio ancora';

  @override
  String get messaging_Conversations_tile_you => 'Voi';

  @override
  String get messaging_DialogInfo_deleteAsk => 'Sei sicuro di voler eliminare questa finestra di dialogo?';

  @override
  String get messaging_DialogInfo_deleteBtn => 'Elimina dialogo';

  @override
  String get messaging_DialogInfo_title => 'Informazioni contatto';

  @override
  String get messaging_GroupAuthorities_moderator => 'moderatore';

  @override
  String get messaging_GroupAuthorities_noauthorities => 'membro';

  @override
  String get messaging_GroupAuthorities_owner => 'proprietario';

  @override
  String get messaging_GroupInfo_addUserBtnText => 'Aggiungi utente';

  @override
  String get messaging_GroupInfo_deleteLeaveBtnText => 'Elimina e lascia';

  @override
  String get messaging_GroupInfo_groupMembersHeadline => 'Membri del gruppo';

  @override
  String get messaging_GroupInfo_leaveAndDeleteAsk => 'Vuoi davvero uscire ed eliminare questo gruppo?';

  @override
  String get messaging_GroupInfo_leaveAsk => 'Sei sicuro di voler abbandonare questo gruppo?';

  @override
  String get messaging_GroupInfo_leaveBtnText => 'Lascia il gruppo';

  @override
  String get messaging_GroupInfo_makeModeratorAsk => 'Sei sicuro di voler rendere questo utente un moderatore?';

  @override
  String get messaging_GroupInfo_makeModeratorBtnText => 'Rendi moderatore';

  @override
  String get messaging_GroupInfo_removeModeratorAsk => 'Sei sicuro di voler rimuovere questo utente dai moderatori?';

  @override
  String get messaging_GroupInfo_removeUserAsk => 'Vuoi davvero rimuovere questo utente dal gruppo?';

  @override
  String get messaging_GroupInfo_removeUserBtnText => 'Rimuovere';

  @override
  String get messaging_GroupInfo_title => 'Informazioni sul gruppo';

  @override
  String get messaging_GroupInfo_titlePrefix => 'Gruppo:';

  @override
  String get messaging_GroupInfo_unmakeModeratorBtnText => 'Annulla moderatore';

  @override
  String get messaging_GroupNameDialog_cancelBtnText => 'Cancellare';

  @override
  String get messaging_GroupNameDialog_fieldHint => 'Inserisci il nome del gruppo';

  @override
  String get messaging_GroupNameDialog_fieldLabel => 'Nome del gruppo';

  @override
  String get messaging_GroupNameDialog_fieldValidation_empty => 'Per favore, inserisci il nome del gruppo';

  @override
  String get messaging_GroupNameDialog_fieldValidation_short => 'Il nome del gruppo è troppo corto';

  @override
  String get messaging_GroupNameDialog_saveBtnText => 'Salva';

  @override
  String get messaging_GroupNameDialog_title => 'Nome del gruppo';

  @override
  String get messaging_GroupScreen_titlePrefix => 'Gruppo:';

  @override
  String get messaging_MessageField_hint => 'Scrivi un messaggio';

  @override
  String get messaging_MessageListView_typingTrail => 'stampe...';

  @override
  String get messaging_MessageView_delete => 'Eliminare';

  @override
  String get messaging_MessageView_deleted => '[cancellato]';

  @override
  String get messaging_MessageView_edit => 'Modificare';

  @override
  String get messaging_MessageView_edited => '[modificato]';

  @override
  String get messaging_MessageView_forward => 'Inoltrare';

  @override
  String get messaging_MessageView_forwarded => '[inoltrato]';

  @override
  String get messaging_MessageView_reply => 'Rispondere';

  @override
  String get messaging_MessageView_textcopy => 'Copia negli appunti';

  @override
  String get messaging_NewConversation_createGroup => '';

  @override
  String get messaging_NewConversation_title => '';

  @override
  String get messaging_ParticipantName_you => 'Voi';

  @override
  String get messaging_ParticipantName_unknown => 'Utente sconosciuto';

  @override
  String get messaging_SmsSendingStatus_delivered => 'consegnato';

  @override
  String get messaging_SmsSendingStatus_failed => 'fallito';

  @override
  String get messaging_SmsSendingStatus_sent => 'inviato';

  @override
  String get messaging_SmsSendingStatus_waiting => 'inatteso';

  @override
  String get messaging_StateBar_connecting => 'CONNESSIONE';

  @override
  String get messaging_StateBar_error => 'DISCONNESSO';

  @override
  String get messaging_StateBar_initializing => 'INIZIALIZZAZIONE';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Verifica';

  @override
  String get notifications_errorSnackBar_activeLineBlindTransferWarning => 'Sei già in linea con il destinatario a cui stai cercando di trasferire alla cieca';

  @override
  String get notifications_errorSnackBar_appOffline => 'La tua apllicazione è offline';

  @override
  String get notifications_errorSnackBar_appOnline => 'La tua apllicazione è online';

  @override
  String get notifications_errorSnackBar_appUnregistered => 'Siamo spiacenti, la tua applicazione è attualmente disconnessa dai server principali WebTrit e quindi non è possibile chiamare in questo momento. Vai alla pagina delle impostazioni e fai scorrere l\'interruttore dello stato online ( a OFF e poi ancora ad ON) per ristabilire la connessione';

  @override
  String get notifications_errorSnackBar_callConnect => 'Connessione al server non riuscita, tentativo di riconnessione in corso';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'Impossibile eseguire la chiamata, verificare lo stato della connessione';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'Errore di autenticazione, effettuare nuovamente l\'accesso';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'Nessuna linea disponibile per avviare una chiamata';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'Nessun accesso al server multimediale, controlla le autorizzazioni dell\'app';

  @override
  String get notifications_errorSnackBar_sipServiceUnavailable => 'Errore di autenticazione con il sistema VoIP remoto';

  @override
  String get permission_Button_request => 'Continua';

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
  String get permission_manufacturer_Button_gotIt => 'Capito';

  @override
  String get permission_manufacturer_Button_toSettings => 'Apri Impostazioni';

  @override
  String get permission_manufacturer_Text_heading => 'Per garantire la migliore esperienza utente, l\'applicazione deve essere autorizzata manualmente ai seguenti permessi:';

  @override
  String get permission_manufacturer_Text_trailing => 'I permessi potrebbero essere modificati in qualsiasi momento in futuro.';

  @override
  String get permission_manufacturer_Text_xiaomi_tip1 => 'Vai su \"Impostazioni dell\'app\" → \"Notifiche\".';

  @override
  String get permission_manufacturer_Text_xiaomi_tip2 => 'Trova e attiva \"Notifiche sulla schermata di blocco\".';

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
  String get recents_HistoryTile_missedCallText => 'Chiamata persa';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name cancellato';
  }

  @override
  String get recents_Text_blingTransferInitiated => 'Trasferimento senza vedere';

  @override
  String get recentsVisibilityFilter_all => 'Tutto';

  @override
  String get recentsVisibilityFilter_all_preposit => 'tutto';

  @override
  String get recentsVisibilityFilter_incoming => 'Entrante';

  @override
  String get recentsVisibilityFilter_incoming_preposit => 'in arrivo';

  @override
  String get recentsVisibilityFilter_missed => 'Perse';

  @override
  String get recentsVisibilityFilter_missed_preposit => 'perso';

  @override
  String get recentsVisibilityFilter_outgoing => 'Uscente';

  @override
  String get recentsVisibilityFilter_outgoing_preposit => 'in uscita';

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
  String get request_Id => 'ID richiesta';

  @override
  String get request_StatusCode => 'Codice di stato';

  @override
  String get sessionStatus_pushNotificationServiceProblem => 'Problema con la configurazione del servizio di notifiche push';

  @override
  String get settings_AboutText_AppSessionIdentifier => 'Identificatore della sessione dell\'applicazione';

  @override
  String get settings_AboutText_AppVersion => 'Versione dell\'app';

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AboutText_FCMPushNotificationToken => 'Token di Notifica Push FCM';

  @override
  String get settings_AboutText_StoreVersion => 'La nuova versione è disponibile nello Store';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'Sei sicuro di voler eliminare l\'account?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Conferma eliminazione account';

  @override
  String get settings_AppBarTitle_myAccount => 'Il mio account';

  @override
  String get settings_call_codecs_preferred_audio_default => 'Predefinito';

  @override
  String get settings_call_codecs_preferred_audio_tip => 'Il codec audio preferito viene utilizzato per le chiamate audio. Se il codec non è supportato dal dispositivo, la chiamata verrà stabilita utilizzando il codec successivo disponibile.';

  @override
  String get settings_call_codecs_preferred_audio_title => 'Codec audio preferito';

  @override
  String get settings_call_codecs_preferred_video_default => 'Predefinito';

  @override
  String get settings_call_codecs_preferred_video_tip => 'Il codec video preferito viene utilizzato per le chiamate video. Se il codec non è supportato dal dispositivo, la chiamata verrà stabilita utilizzando il codec successivo disponibile.';

  @override
  String get settings_call_codecs_preferred_video_title => 'Codec video preferito';

  @override
  String get settings_ListViewTileTitle_about => 'Riguardo a';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Elimina account';

  @override
  String get settings_ListViewTileTitle_call_codecs => 'Codec di chiamata';

  @override
  String get settings_ListViewTileTitle_self_config => 'Self-config pagina';

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
  String get settings_network_incomingCallType_pushNotification_description => 'Quando l\'app non è in uso, smette di funzionare e consuma risorse minime, il che aiuta a conservare la durata della batteria. Durante una chiamata in arrivo, il server invia una notifica push al telefono, spingendo il sistema operativo mobile a lanciare l\'app per gestire la chiamata. Tuttavia, questo metodo non garantisce che tutte le chiamate verranno ricevute. Se il telefono è stato inattivo per un periodo prolungato, alcune versioni di Android potrebbero limitare le notifiche push, con il rischio di perdere una chiamata in arrivo.';

  @override
  String get settings_network_incomingCallType_pushNotification_title => 'Notifica Push';

  @override
  String get settings_network_incomingCallType_socket_description => 'L\'app continua a funzionare in background e mantiene sempre una connessione attiva al server. Questo aumenta le probabilità di ricevere una chiamata in arrivo, ma potrebbe scaricare la batteria più rapidamente.';

  @override
  String get settings_network_incomingCallType_socket_title => 'Connessione Persistente al Server';

  @override
  String get settings_network_incomingCallType_title => 'Tipo di chiamata in entrata';

  @override
  String get signalingResponseCode_errorAttachingPlugin => 'Abbiamo avuto problemi a connettere una funzione. Riprova più tardi.';

  @override
  String get signalingResponseCode_errorDetachingPlugin => 'Abbiamo avuto problemi a disconnettere una funzione. Riprova più tardi.';

  @override
  String get signalingResponseCode_errorSendingMessage => 'Non siamo riusciti a inviare il tuo messaggio. Controlla la rete e riprova.';

  @override
  String get signalingResponseCode_handleNotFound => 'Non abbiamo trovato ciò che stavi cercando. Riprova.';

  @override
  String get signalingResponseCode_invalidElementType => 'Qualcosa non va. Riprova.';

  @override
  String get signalingResponseCode_invalidJson => 'Si è verificato un errore nell\'elaborazione dei tuoi dati. Riprova.';

  @override
  String get signalingResponseCode_invalidJsonObject => 'Alcune delle informazioni fornite non sono valide. Verifica e riprova.';

  @override
  String get signalingResponseCode_invalidPath => 'L\'azione richiesta non è disponibile. Prova un\'opzione diversa.';

  @override
  String get signalingResponseCode_invalidSdp => 'Si è verificato un errore tecnico. Riprova più tardi.';

  @override
  String get signalingResponseCode_invalidStream => 'Lo stream richiesto non è disponibile. Riprova.';

  @override
  String get signalingResponseCode_missingMandatoryElement => 'Mancano informazioni obbligatorie. Compila tutti i campi richiesti.';

  @override
  String get signalingResponseCode_missingRequest => 'C\'è stato un problema con la tua richiesta. Riprova.';

  @override
  String get signalingResponseCode_notAcceptingNewSessions => 'Non siamo in grado di avviare nuove sessioni al momento. Riprova più tardi.';

  @override
  String get signalingResponseCode_notFoundRoutesInReplyFromBE => 'Non abbiamo trovato un percorso per completare la tua richiesta. Riprova più tardi.';

  @override
  String get signalingResponseCode_pluginNotFound => 'Manca un componente necessario. Prova a riavviare l\'app.';

  @override
  String get signalingResponseCode_sessionIdInUse => 'Questa sessione è già attiva. Prova a usarne un\'altra.';

  @override
  String get signalingResponseCode_sessionNotFound => 'Non è stata trovata la tua sessione. Effettua l\'accesso e riprova.';

  @override
  String get signalingResponseCode_tokenNotFound => 'Il tuo token di accesso è mancante o non valido. Effettua nuovamente l\'accesso.';

  @override
  String get signalingResponseCode_transportSpecificError => 'Si è verificato un problema di connessione. Controlla la tua rete e riprova.';

  @override
  String get signalingResponseCode_normalUnspecified => 'Si è verificato un errore imprevisto. Riprova più tardi.';

  @override
  String get signalingResponseCode_callNotExist => 'La chiamata non esiste. Riprova.';

  @override
  String get signalingResponseCode_loopDetected => 'C\'è un problema con la tua richiesta. Riprova.';

  @override
  String get signalingResponseCode_exchangeRoutingError => 'Si è verificato un errore di routing. Riprova.';

  @override
  String get signalingResponseCode_invalidNumberFormat => 'Il numero di telefono inserito non è valido. Deve essere inserito nel formato: ';

  @override
  String get signalingResponseCode_ambiguousRequest => 'La tua richiesta non è chiara. Riprova.';

  @override
  String get signalingResponseCode_userBusy => 'Il destinatario è occupato. Riprova più tardi.';

  @override
  String get signalingResponseCode_requestTerminated => 'La tua richiesta è stata terminata. Riprova.';

  @override
  String get signalingResponseCode_incompatibleDestination => 'Il destinatario non è compatibile con la tua richiesta. Riprova.';

  @override
  String get signalingResponseCode_busyEverywhere => 'Tutti i destinatari sono occupati. Riprova più tardi.';

  @override
  String get signalingResponseCode_declineCall => 'La chiamata è stata rifiutata.';

  @override
  String get signalingResponseCode_userNotExist => 'Il destinatario non esiste. Controlla il numero di telefono e riprova.';

  @override
  String get signalingResponseCode_notAcceptable => 'La tua richiesta non è accettabile. Riprova.';

  @override
  String get signalingResponseCode_unwanted => 'La tua richiesta non è gradita. Riprova.';

  @override
  String get signalingResponseCode_rejected => 'La tua richiesta è stata rifiutata. Riprova.';

  @override
  String get signalingResponseCodeType_plugin => 'Una funzionalità necessaria non sta funzionando correttamente. Prova a riavviare l\'app.';

  @override
  String get signalingResponseCodeType_request => 'C\'è un problema con la tua richiesta. Riprova.';

  @override
  String get signalingResponseCodeType_session => 'C\'è un problema con la tua sessione. Effettua nuovamente l\'accesso o riavvia l\'app.';

  @override
  String get signalingResponseCodeType_token => 'Il tuo token di accesso non è valido. Effettua nuovamente l\'accesso.';

  @override
  String get signalingResponseCodeType_transport => 'Stiamo riscontrando difficoltà di comunicazione con il server. Controlla la tua connessione e riprova.';

  @override
  String get signalingResponseCodeType_unauthorized => 'Non hai l\'autorizzazione necessaria. Effettua l\'accesso o contatta il supporto.';

  @override
  String get signalingResponseCodeType_unknown => 'Si è verificato un problema imprevisto. Riprova più tardi.';

  @override
  String get signalingResponseCodeType_webrtc => 'C\'è un problema con la connessione della chiamata. Riaggancia e riprova.';

  @override
  String get signalingResponseCodeType_callHangup => 'La chiamata è stata terminata.';

  @override
  String get signalingResponseCode_unauthorizedAccess => 'Non hai l\'autorizzazione per accedere a questa funzione. Contatta il supporto se pensi che ci sia un errore.';

  @override
  String get signalingResponseCode_unauthorizedRequest => 'La tua richiesta non può essere autorizzata. Prova ad accedere di nuovo.';

  @override
  String get signalingResponseCode_unexpectedAnswer => 'Abbiamo ricevuto una risposta inaspettata. Riprova.';

  @override
  String get signalingResponseCode_unknownError => 'Si è verificato un errore imprevisto. Riprova più tardi.';

  @override
  String get signalingResponseCode_unknownRequest => 'Non abbiamo riconosciuto la tua richiesta. Riprova o contatta il supporto.';

  @override
  String get signalingResponseCode_unsupportedJsepType => 'Questa azione non è supportata dalla tua configurazione attuale.';

  @override
  String get signalingResponseCode_wrongWebrtcState => 'Si è verificato un errore relativo alla chiamata. Riaggancia e riprova.';

  @override
  String get themeMode_dark => 'Scuro';

  @override
  String get themeMode_light => 'Luce';

  @override
  String get themeMode_system => 'Sistema';

  @override
  String get user_agreement_agrement_link => 'Termini e condizion';

  @override
  String get user_agreement_button_text => 'Continua';

  @override
  String user_agreement_checkbox_text(Object url) {
    return 'Presa visione dell\'$url,  accetto termini e condizioni.';
  }

  @override
  String user_agreement_description(Object appName) {
    return 'Benvenuto in $appName';
  }

  @override
  String get validationBlankError => 'Prego inserire un valore';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Retry';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Skip';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Web resource error';

  @override
  String get socketError_serverUnreachable => 'Il server non è raggiungibile a causa di problemi di rete';

  @override
  String get socketError_networkUnreachable => 'Rete non raggiungibile';

  @override
  String get socketError_connectionTimedOut => 'Connessione scaduta';

  @override
  String get socketError_connectionRefused => 'Connessione rifiutata';

  @override
  String get socketError_connectionReset => 'Connessione reimpostata';

  @override
  String get socketError_default => 'Errore di rete';

  @override
  String get socketError_serverUnreachableDescription => 'Il server non è raggiungibile. Questo potrebbe essere dovuto a un\'assenza di connessione a Internet o alla manutenzione del server. Si prega di controllare la connessione a Internet e riprovare.';

  @override
  String get socketError_networkUnreachableDescription => 'La rete non è raggiungibile. Questo potrebbe essere dovuto a una connessione Internet debole, restrizioni di rete come firewall o impostazioni DNS errate. Se sei su una rete aziendale o con restrizioni, contatta l\'amministratore di rete o prova a utilizzare un\'altra rete.';

  @override
  String get socketError_connectionTimedOutDescription => 'La connessione è scaduta. Questo potrebbe accadere a causa di una connessione Internet lenta o instabile. Si prega di controllare la connessione e riprovare.';

  @override
  String get socketError_connectionRefusedDescription => 'Il server ha rifiutato la connessione. Il server potrebbe essere inattivo o rifiutare le richieste. Si prega di riprovare più tardi.';

  @override
  String get socketError_connectionResetDescription => 'La connessione è stata reimpostata dal server. Si prega di riprovare.';

  @override
  String socketError_defaultDescription(int? errorCode) {
    return 'Si è verificato un errore di rete imprevisto (Codice errore: $errorCode). Questo potrebbe essere causato da problemi di rete o del server. Si prega di riprovare più tardi.';
  }
}
