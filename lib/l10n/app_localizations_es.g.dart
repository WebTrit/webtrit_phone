import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get alertDialogActions_no => 'No';

  @override
  String get alertDialogActions_ok => 'Aceptar';

  @override
  String get alertDialogActions_yes => 'Sí';

  @override
  String get call_CallActionsTooltip_accept => 'Aceptar';

  @override
  String get call_CallActionsTooltip_disableCamera => 'Desactivar cámara';

  @override
  String get call_CallActionsTooltip_disableSpeaker => 'Desactivar altavoz';

  @override
  String get call_CallActionsTooltip_enableCamera => 'Activar cámara';

  @override
  String get call_CallActionsTooltip_enableSpeaker => 'Activar altavoz';

  @override
  String get call_CallActionsTooltip_hangup => 'Colgar';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'Esconder teclado';

  @override
  String get call_CallActionsTooltip_hold => 'Mantener llamada';

  @override
  String get call_CallActionsTooltip_mute => 'Silenciar micrófono';

  @override
  String get call_CallActionsTooltip_showKeypad => 'Mostrar teclado';

  @override
  String get call_CallActionsTooltip_transfer => 'Transferir';

  @override
  String get call_CallActionsTooltip_unhold => 'Reanudar llamada';

  @override
  String get call_CallActionsTooltip_unmute => 'Activar micrófono';

  @override
  String get call_description_incoming => 'Llamada entrante de';

  @override
  String get call_description_outgoing => 'Llamada saliente a';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Error';

  @override
  String get callStatus_appUnregistered => 'No registrado';

  @override
  String get callStatus_connectError => 'Error de conexión';

  @override
  String get callStatus_connectIssue => 'Problema de conexión';

  @override
  String get callStatus_connectivityNone => 'Sin conexión a internet';

  @override
  String get callStatus_inProgress => 'Conexión en curso';

  @override
  String get callStatus_ready => 'Conexión establecida';

  @override
  String get contacts_ExternalTabButton_refresh => 'Actualizar';

  @override
  String get contacts_ExternalTabText_empty => 'Sin contactos';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'No se encontraron contactos';

  @override
  String get contacts_ExternalTabText_failure => 'No se pudieron obtener los contactos de la PBX en la nube';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'Conceder acceso a tus contactos telefónicos';

  @override
  String get contacts_LocalTabButton_refresh => 'Actualizar';

  @override
  String get contacts_LocalTabText_empty => 'Sin contactos';

  @override
  String get contacts_LocalTabText_emptyOnSearching => 'No se encontraron contactos';

  @override
  String get contacts_LocalTabText_failure => 'No se pudieron obtener tus contactos telefónicos';

  @override
  String get contacts_LocalTabText_permissionFailure => 'No tiene permisos para obtener sus contactos telefónicos';

  @override
  String get contactsSourceExternal => 'PBX en la nube';

  @override
  String get contactsSourceLocal => 'Su teléfono';

  @override
  String get copyToClipboard_floatingSnackBar => 'Texto copiado';

  @override
  String get copyToClipboard_popupMenuItem => 'Copiar al portapapeles';

  @override
  String get default_ClientExceptionError => 'Se ha producido un problema con el cliente HTTP';

  @override
  String get default_FormatExceptionError => 'Se ha producido un problema de respuesta';

  @override
  String get default_RequestFailureError => 'Se produjo un fallo del servidor';

  @override
  String get default_SocketExceptionError => 'Se ha producido un problema de red';

  @override
  String get default_TlsExceptionError => 'Se ha producido un problema de red segura';

  @override
  String get default_TypeErrorError => 'Se ha producido un problema de respuesta';

  @override
  String get default_UnauthorizedRequestFailureError => 'Se produjo un fallo de solicitud no autorizada';

  @override
  String get favorites_BodyCenter_empty => 'No hay números favoritos';

  @override
  String get favorites_DeleteConfirmDialog_content => '¿Está seguro de que desea eliminar el favorito actual?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Confirmar eliminación';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name eliminado';
  }

  @override
  String get locale_default => 'Predeterminado';

  @override
  String get locale_en => 'Inglés';

  @override
  String get login_AppBarTitle_coreUrlAssign => '';

  @override
  String get login_AppBarTitle_otpRequest => '';

  @override
  String get login_AppBarTitle_otpVerify => '';

  @override
  String get login_Button_coreUrlAssignProceed => 'Continuar';

  @override
  String get login_Button_otpRequestProceed => 'Continuar';

  @override
  String get login_Button_otpVerifyProceed => 'Verificar';

  @override
  String get login_Button_otpVerifyRepeat => 'Reenviar el código';

  @override
  String login_Button_otpVerifyRepeatInterval(int seconds) {
    return 'Reenviar el código ($seconds s)';
  }

  @override
  String get login_Button_signIn => 'Iniciar sesión';

  @override
  String get login_Button_signUpToDemoInstance => 'Registrarse';

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Iniciar sesión en su instancia de PortaPhone';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Se proporcionó una versión de instancia incompatible, por favor contacta al administrador de tu sistema (actual: $actual, compatible: $supportedConstraint)';
  }

  @override
  String get login_FormatExceptionError => 'Ocurrió un problema en la respuesta';

  @override
  String get login_RequestFailureCodeIncorrectError => 'Código de verificación incorrecto';

  @override
  String get login_RequestFailureEmptyEmailError => 'No se puede enviar el código de verificación';

  @override
  String get login_RequestFailureError => 'Ocurrió un fallo del servidor';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Verificación ya verificada';

  @override
  String get login_RequestFailureOtpExpiredError => 'Verificación caducada';

  @override
  String get login_RequestFailureOtpIdVerifyAttemptsExceededError => 'Se superaron los intentos de verificación';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Verificación no encontrada';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Número de teléfono no encontrado';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'Error de configuración del backend de la aplicación; por favor, notifique a su proveedor de servicios';

  @override
  String get login_SocketExceptionError => 'Ocurrió un problema con la red';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Si aún no tienes tu propio WebTrit Cloud Backend, ponte en contacto con el equipo de ventas en $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'Para realizar llamadas a través de su propia instancia de PortaPhone y su propio PortaSwitch, ingrese la URL del servidor (como se la proporcionó su gerente de cuenta) a continuación.';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Ingrese la URL de su instancia de PortaPhone';

  @override
  String get login_TextFieldLabelText_otpRequestEmail => 'Ingrese su correo electrónico';

  @override
  String get login_TextFieldLabelText_otpRequestPhone => 'Ingrese su número de teléfono';

  @override
  String get login_TextFieldLabelText_otpVerifyCode => 'Ingrese el código de verificación';

  @override
  String get login_Text_otpRequestDemoDescription => 'Si aún no tiene una cuenta, se creará automáticamente para Usted.';

  @override
  String get login_Text_otpRequestDescription => '';

  @override
  String login_Text_otpVerifyCheckSpamFrom(String email) {
    return 'Si no ve un correo electrónico con el código de verificación de $email en su bandeja de entrada, por favor revise su carpeta de spam.';
  }

  @override
  String get login_Text_otpVerifyCheckSpamGeneral => 'Si no ve un correo electrónico con el código de verificación en su bandeja de entrada, por favor revise su carpeta de spam.';

  @override
  String login_Text_otpVerifySentToEmail(String email) {
    return 'Se ha enviado un código de verificación único a $email.';
  }

  @override
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return 'Se ha enviado un código de verificación único al correo electrónico asignado al número de teléfono tel:$phone.';
  }

  @override
  String get login_TlsExceptionError => 'Ocurrió un problema de seguridad en la red';

  @override
  String get login_TypeErrorError => 'Ocurrió un problema en la respuesta';

  @override
  String get login_validationCoreUrlError => 'Por favor, ingrese una URL válida';

  @override
  String get login_validationEmailError => 'Por favor, ingrese un correo electrónico válido';

  @override
  String get login_validationPhoneError => 'Por favor, ingrese un número de teléfono válido';

  @override
  String get logRecordsConsole_AppBarTitle => 'Consola de Registro';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Actualizar';

  @override
  String get logRecordsConsole_Text_failure => '¡Ups! Ocurrió un error ☹️';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => 'Contactos';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => 'Favoritos';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => 'Teclado';

  @override
  String get main_BottomNavigationBarItemLabel_recents => 'Recientes';

  @override
  String get main_CompatibilityIssueDialogActions_logout => 'Cerrar sesión';

  @override
  String get main_CompatibilityIssueDialogActions_update => 'Actualización';

  @override
  String get main_CompatibilityIssueDialogActions_verify => 'Verificar de nuevo';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Versión incompatible de la instancia de PortaPhone, por favor contacte al administrador de su sistema (actual: $actual, compatible: $supportedConstraint)';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Problema de compatibilidad';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Verificar';

  @override
  String get notifications_errorSnackBar_callConnect => 'Fallo al conectar con el núcleo, intentando reconectar';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'No se puede iniciar la llamada, por favor verifique el estado de la conexión';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'La sesión de conexión actual es inválida, por favor inicie la sesión de nuevo';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'No hay líneas disponibles para iniciar la llamada';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'Sin acceso a la entrada de medios, por favor verifique los permisos de la aplicación';

  @override
  String get notImplemented => 'Lo sentimos, aún no está implementado';

  @override
  String get permission_Button_request => 'Continuar';

  @override
  String get permission_Text_description => 'Para garantizar la mejor experiencia de usuario, la aplicación necesita los siguientes permisos: micrófono para llamadas de audio, cámara para llamadas de video y acceso a los contactos para facilitar la comunicación desde la aplicación.\n\nLos permisos pueden cambiarse en cualquier momento en el futuro.';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'Actualmente no tienes llamadas recientes con $filter.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => '¿Está seguro de que desea eliminar el registro de llamadas actual?';

  @override
  String get recents_DeleteConfirmDialog_title => 'Confirmar eliminación';

  @override
  String get recents_errorSnackBar_loadFailure => '¡Ups! Ocurrió un error ☹️';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name eliminado';
  }

  @override
  String get recentsVisibilityFilter_all => 'Todas';

  @override
  String get recentsVisibilityFilter_incoming => 'Entrantes';

  @override
  String get recentsVisibilityFilter_missed => 'Perdidas';

  @override
  String get recentsVisibilityFilter_outgoing => 'Salientes';

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
  String get settings_AccountDeleteConfirmDialog_content => 'Estás seguro de que quieres eliminar la cuenta?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Confirmar eliminación de cuenta';

  @override
  String get settings_AppBarTitle_myAccount => 'Mi cuenta';

  @override
  String get settings_ForceLogoutConfirmDialog_content => 'Estás seguro de que quieres forzar el cierre de sesión?';

  @override
  String get settings_ForceLogoutConfirmDialog_title => 'Confirmar cierre de sesión forzado';

  @override
  String get settings_FormatExceptionError => 'Ocurrió un problema en la respuesta';

  @override
  String get settings_ListViewTileTitle_about => 'Acerca de';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Eliminar cuenta';

  @override
  String get settings_ListViewTileTitle_help => 'Ayuda';

  @override
  String get settings_ListViewTileTitle_language => 'Idioma';

  @override
  String get settings_ListViewTileTitle_logout => 'Cerrar sesión';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => 'Consola de registros';

  @override
  String get settings_ListViewTileTitle_network => 'Configuración de red';

  @override
  String get settings_ListViewTileTitle_registered => 'Registrado';

  @override
  String get settings_ListViewTileTitle_settings => 'CONFIGURACIÓN';

  @override
  String get settings_ListViewTileTitle_termsConditions => 'Términos y condiciones';

  @override
  String get settings_ListViewTileTitle_themeMode => 'Modo de tema';

  @override
  String get settings_ListViewTileTitle_toolbox => 'CAJA DE HERRAMIENTAS';

  @override
  String get settings_LogoutConfirmDialog_content => '¿Está seguro de que desea cerrar sesión?';

  @override
  String get settings_LogoutConfirmDialog_title => 'Confirmar el cierre de sesión';

  @override
  String get settings_RequestFailureError => 'Ocurrió un fallo del servidor';

  @override
  String get settings_SocketExceptionError => 'Ocurrió un problema con la red';

  @override
  String get settings_TlsExceptionError => 'Ocurrió un problema de seguridad en la red';

  @override
  String get settings_TypeErrorError => 'Ocurrió un problema en la respuesta';

  @override
  String get themeMode_dark => 'Modo Oscuro';

  @override
  String get themeMode_light => 'Modo Claro';

  @override
  String get themeMode_system => 'Sistema';

  @override
  String get underDevelopment => 'Esta página está en desarrollo.';

  @override
  String get validationBlankError => 'Por favor, ingrese un valor';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_demo => 'Demo';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Reintentar';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Saltar';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Error en recurso de web';
}
