// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(name) => "${name} eliminado";

  static String m1(seconds) => "Reenviar el código (${seconds} s)";

  static String m2(actual, supportedConstraint) =>
      "Se proporcionó una versión de instancia incompatible, por favor contacta al administrador de tu sistema (actual: ${actual}, compatible: ${supportedConstraint})";

  static String m3(email) =>
      "Si aún no tienes tu propio WebTrit Cloud Backend, ponte en contacto con el equipo de ventas en ${email}";

  static String m4(email) =>
      "Si no ve un correo electrónico con el código de verificación de ${email} en su bandeja de entrada, por favor revise su carpeta de spam.";

  static String m5(email) =>
      "Se ha enviado un código de verificación único a ${email}.";

  static String m6(phone) =>
      "Se ha enviado un código de verificación único al correo electrónico asignado al número de teléfono tel:${phone}.";

  static String m7(actual, supportedConstraint) =>
      "Versión incompatible de la instancia de PortaPhone, por favor contacte al administrador de su sistema (actual: ${actual}, compatible: ${supportedConstraint})";

  static String m8(time) => "${time}";

  static String m9(time) => "${time}";

  static String m10(filter) =>
      "Actualmente no tienes llamadas recientes con ${filter}.";

  static String m11(name) => "${name} eliminado";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogActions_no": MessageLookupByLibrary.simpleMessage("No"),
        "alertDialogActions_ok":
            MessageLookupByLibrary.simpleMessage("Aceptar"),
        "alertDialogActions_yes": MessageLookupByLibrary.simpleMessage("Sí"),
        "callStatus_appUnregistered":
            MessageLookupByLibrary.simpleMessage("No registrado"),
        "callStatus_connectError":
            MessageLookupByLibrary.simpleMessage("Error de conexión"),
        "callStatus_connectIssue":
            MessageLookupByLibrary.simpleMessage("Problema de conexión"),
        "callStatus_connectivityNone":
            MessageLookupByLibrary.simpleMessage("Sin conexión a internet"),
        "callStatus_inProgress":
            MessageLookupByLibrary.simpleMessage("Conexión en curso"),
        "callStatus_ready":
            MessageLookupByLibrary.simpleMessage("Conexión establecida"),
        "call_CallActionsTooltip_accept":
            MessageLookupByLibrary.simpleMessage("Aceptar"),
        "call_CallActionsTooltip_disableCamera":
            MessageLookupByLibrary.simpleMessage("Desactivar cámara"),
        "call_CallActionsTooltip_disableSpeaker":
            MessageLookupByLibrary.simpleMessage("Desactivar altavoz"),
        "call_CallActionsTooltip_enableCamera":
            MessageLookupByLibrary.simpleMessage("Activar cámara"),
        "call_CallActionsTooltip_enableSpeaker":
            MessageLookupByLibrary.simpleMessage("Activar altavoz"),
        "call_CallActionsTooltip_hangup":
            MessageLookupByLibrary.simpleMessage("Colgar"),
        "call_CallActionsTooltip_hideKeypad":
            MessageLookupByLibrary.simpleMessage("Esconder teclado"),
        "call_CallActionsTooltip_hold":
            MessageLookupByLibrary.simpleMessage("Mantener llamada"),
        "call_CallActionsTooltip_mute":
            MessageLookupByLibrary.simpleMessage("Silenciar micrófono"),
        "call_CallActionsTooltip_showKeypad":
            MessageLookupByLibrary.simpleMessage("Mostrar teclado"),
        "call_CallActionsTooltip_transfer":
            MessageLookupByLibrary.simpleMessage("Transferir"),
        "call_CallActionsTooltip_unhold":
            MessageLookupByLibrary.simpleMessage("Reanudar llamada"),
        "call_CallActionsTooltip_unmute":
            MessageLookupByLibrary.simpleMessage("Activar micrófono"),
        "call_FailureAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Error"),
        "call_description_incoming":
            MessageLookupByLibrary.simpleMessage("Llamada entrante de"),
        "call_description_outgoing":
            MessageLookupByLibrary.simpleMessage("Llamada saliente a"),
        "contactsSourceExternal":
            MessageLookupByLibrary.simpleMessage("PBX en la nube"),
        "contactsSourceLocal":
            MessageLookupByLibrary.simpleMessage("Su teléfono"),
        "contacts_ExternalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Actualizar"),
        "contacts_ExternalTabText_empty":
            MessageLookupByLibrary.simpleMessage("Sin contactos"),
        "contacts_ExternalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("No se encontraron contactos"),
        "contacts_ExternalTabText_failure":
            MessageLookupByLibrary.simpleMessage(
                "No se pudieron obtener los contactos de la PBX en la nube"),
        "contacts_LocalTabButton_openAppSettings":
            MessageLookupByLibrary.simpleMessage(
                "Conceder acceso a tus contactos telefónicos"),
        "contacts_LocalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Actualizar"),
        "contacts_LocalTabText_empty":
            MessageLookupByLibrary.simpleMessage("Sin contactos"),
        "contacts_LocalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("No se encontraron contactos"),
        "contacts_LocalTabText_failure": MessageLookupByLibrary.simpleMessage(
            "No se pudieron obtener tus contactos telefónicos"),
        "contacts_LocalTabText_permissionFailure":
            MessageLookupByLibrary.simpleMessage(
                "No tiene permisos para obtener sus contactos telefónicos"),
        "copyToClipboard_floatingSnackBar":
            MessageLookupByLibrary.simpleMessage("Texto copiado"),
        "copyToClipboard_popupMenuItem":
            MessageLookupByLibrary.simpleMessage("Copiar al portapapeles"),
        "default_ClientExceptionError": MessageLookupByLibrary.simpleMessage(
            "Se ha producido un problema con el cliente HTTP"),
        "default_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Se ha producido un problema de respuesta"),
        "default_RequestFailureError": MessageLookupByLibrary.simpleMessage(
            "Se produjo un fallo del servidor"),
        "default_SocketExceptionError": MessageLookupByLibrary.simpleMessage(
            "Se ha producido un problema de red"),
        "default_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Se ha producido un problema de red segura"),
        "default_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Se ha producido un problema de respuesta"),
        "default_UnauthorizedRequestFailureError":
            MessageLookupByLibrary.simpleMessage(
                "Se produjo un fallo de solicitud no autorizada"),
        "favorites_BodyCenter_empty":
            MessageLookupByLibrary.simpleMessage("No hay números favoritos"),
        "favorites_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "¿Está seguro de que desea eliminar el favorito actual?"),
        "favorites_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirmar eliminación"),
        "favorites_SnackBar_deleted": m0,
        "locale_default":
            MessageLookupByLibrary.simpleMessage("Predeterminado"),
        "locale_en": MessageLookupByLibrary.simpleMessage("Inglés"),
        "logRecordsConsole_AppBarTitle":
            MessageLookupByLibrary.simpleMessage("Consola de Registro"),
        "logRecordsConsole_Button_failureRefresh":
            MessageLookupByLibrary.simpleMessage("Actualizar"),
        "logRecordsConsole_Text_failure":
            MessageLookupByLibrary.simpleMessage("¡Ups! Ocurrió un error ☹️"),
        "login_AppBarTitle_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpRequest":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpVerify": MessageLookupByLibrary.simpleMessage(""),
        "login_ButtonTooltip_signInToYourInstance":
            MessageLookupByLibrary.simpleMessage(
                "Iniciar sesión en su instancia de PortaPhone"),
        "login_Button_coreUrlAssignProceed":
            MessageLookupByLibrary.simpleMessage("Continuar"),
        "login_Button_otpRequestProceed":
            MessageLookupByLibrary.simpleMessage("Continuar"),
        "login_Button_otpVerifyProceed":
            MessageLookupByLibrary.simpleMessage("Verificar"),
        "login_Button_otpVerifyRepeat":
            MessageLookupByLibrary.simpleMessage("Reenviar el código"),
        "login_Button_otpVerifyRepeatInterval": m1,
        "login_Button_signIn":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "login_Button_signUpToDemoInstance":
            MessageLookupByLibrary.simpleMessage("Registrarse"),
        "login_CoreVersionUnsupportedExceptionError": m2,
        "login_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema en la respuesta"),
        "login_RequestFailureCodeIncorrectError":
            MessageLookupByLibrary.simpleMessage(
                "Código de verificación incorrecto"),
        "login_RequestFailureEmptyEmailError":
            MessageLookupByLibrary.simpleMessage(
                "No se puede enviar el código de verificación"),
        "login_RequestFailureError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un fallo del servidor"),
        "login_RequestFailureOtpAlreadyVerifiedError":
            MessageLookupByLibrary.simpleMessage("Verificación ya verificada"),
        "login_RequestFailureOtpExpiredError":
            MessageLookupByLibrary.simpleMessage("Verificación caducada"),
        "login_RequestFailureOtpIdVerifyAttemptsExceededError":
            MessageLookupByLibrary.simpleMessage(
                "Se superaron los intentos de verificación"),
        "login_RequestFailureOtpNotFoundError":
            MessageLookupByLibrary.simpleMessage("Verificación no encontrada"),
        "login_RequestFailurePhoneNotFoundError":
            MessageLookupByLibrary.simpleMessage(
                "Número de teléfono no encontrado"),
        "login_RequestFailureUnconfiguredBundleIdError":
            MessageLookupByLibrary.simpleMessage(
                "Error de configuración del backend de la aplicación; por favor, notifique a su proveedor de servicios"),
        "login_SocketExceptionError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema con la red"),
        "login_TextFieldLabelText_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(
                "Ingrese la URL de su instancia de PortaPhone"),
        "login_TextFieldLabelText_otpRequestEmail":
            MessageLookupByLibrary.simpleMessage(
                "Ingrese su correo electrónico"),
        "login_TextFieldLabelText_otpRequestPhone":
            MessageLookupByLibrary.simpleMessage(
                "Ingrese su número de teléfono"),
        "login_TextFieldLabelText_otpVerifyCode":
            MessageLookupByLibrary.simpleMessage(
                "Ingrese el código de verificación"),
        "login_Text_coreUrlAssignPostDescription": m3,
        "login_Text_coreUrlAssignPreDescription":
            MessageLookupByLibrary.simpleMessage(
                "Para realizar llamadas a través de su propia instancia de PortaPhone y su propio PortaSwitch, ingrese la URL del servidor (como se la proporcionó su gerente de cuenta) a continuación."),
        "login_Text_otpRequestDemoDescription":
            MessageLookupByLibrary.simpleMessage(
                "Si aún no tiene una cuenta, se creará automáticamente para Usted."),
        "login_Text_otpRequestDescription":
            MessageLookupByLibrary.simpleMessage(""),
        "login_Text_otpVerifyCheckSpamFrom": m4,
        "login_Text_otpVerifyCheckSpamGeneral":
            MessageLookupByLibrary.simpleMessage(
                "Si no ve un correo electrónico con el código de verificación en su bandeja de entrada, por favor revise su carpeta de spam."),
        "login_Text_otpVerifySentToEmail": m5,
        "login_Text_otpVerifySentToEmailAssignedWithPhone": m6,
        "login_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema de seguridad en la red"),
        "login_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema en la respuesta"),
        "login_validationCoreUrlError": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingrese una URL válida"),
        "login_validationEmailError": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingrese un correo electrónico válido"),
        "login_validationPhoneError": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingrese un número de teléfono válido"),
        "main_BottomNavigationBarItemLabel_contacts":
            MessageLookupByLibrary.simpleMessage("Contactos"),
        "main_BottomNavigationBarItemLabel_favorites":
            MessageLookupByLibrary.simpleMessage("Favoritos"),
        "main_BottomNavigationBarItemLabel_keypad":
            MessageLookupByLibrary.simpleMessage("Teclado"),
        "main_BottomNavigationBarItemLabel_recents":
            MessageLookupByLibrary.simpleMessage("Recientes"),
        "main_CompatibilityIssueDialogActions_logout":
            MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "main_CompatibilityIssueDialogActions_update":
            MessageLookupByLibrary.simpleMessage("Actualización"),
        "main_CompatibilityIssueDialogActions_verify":
            MessageLookupByLibrary.simpleMessage("Verificar de nuevo"),
        "main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError":
            m7,
        "main_CompatibilityIssueDialog_title":
            MessageLookupByLibrary.simpleMessage("Problema de compatibilidad"),
        "notImplemented": MessageLookupByLibrary.simpleMessage(
            "Lo sentimos, aún no está implementado"),
        "notifications_errorSnackBarAction_callUserMedia":
            MessageLookupByLibrary.simpleMessage("Verificar"),
        "notifications_errorSnackBar_callConnect":
            MessageLookupByLibrary.simpleMessage(
                "Fallo al conectar con el núcleo, intentando reconectar"),
        "notifications_errorSnackBar_callSignalingClientNotConnect":
            MessageLookupByLibrary.simpleMessage(
                "No se puede iniciar la llamada, por favor verifique el estado de la conexión"),
        "notifications_errorSnackBar_callSignalingClientSessionMissed":
            MessageLookupByLibrary.simpleMessage(
                "La sesión de conexión actual es inválida, por favor inicie la sesión de nuevo"),
        "notifications_errorSnackBar_callUndefinedLine":
            MessageLookupByLibrary.simpleMessage(
                "No hay líneas disponibles para iniciar la llamada"),
        "notifications_errorSnackBar_callUserMedia":
            MessageLookupByLibrary.simpleMessage(
                "Sin acceso a la entrada de medios, por favor verifique los permisos de la aplicación"),
        "permission_Button_request":
            MessageLookupByLibrary.simpleMessage("Continuar"),
        "permission_Text_description": MessageLookupByLibrary.simpleMessage(
            "Para garantizar la mejor experiencia de usuario, la aplicación necesita los siguientes permisos: micrófono para llamadas de audio, cámara para llamadas de video y acceso a los contactos para facilitar la comunicación desde la aplicación.\n\nLos permisos pueden cambiarse en cualquier momento en el futuro."),
        "recentTimeAfterMidnight": m8,
        "recentTimeBeforeMidnight": m9,
        "recentsVisibilityFilter_all":
            MessageLookupByLibrary.simpleMessage("Todas"),
        "recentsVisibilityFilter_incoming":
            MessageLookupByLibrary.simpleMessage("Entrantes"),
        "recentsVisibilityFilter_missed":
            MessageLookupByLibrary.simpleMessage("Perdidas"),
        "recentsVisibilityFilter_outgoing":
            MessageLookupByLibrary.simpleMessage("Salientes"),
        "recents_BodyCenter_empty": m10,
        "recents_DeleteConfirmDialog_content": MessageLookupByLibrary.simpleMessage(
            "¿Está seguro de que desea eliminar el registro de llamadas actual?"),
        "recents_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirmar eliminación"),
        "recents_errorSnackBar_loadFailure":
            MessageLookupByLibrary.simpleMessage("¡Ups! Ocurrió un error ☹️"),
        "recents_snackBar_deleted": m11,
        "settings_AboutText_CoreVersionUndefined":
            MessageLookupByLibrary.simpleMessage("?.?.?"),
        "settings_AccountDeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Estás seguro de que quieres eliminar la cuenta?"),
        "settings_AccountDeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Confirmar eliminación de cuenta"),
        "settings_AppBarTitle_myAccount":
            MessageLookupByLibrary.simpleMessage("Mi cuenta"),
        "settings_ForceLogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Estás seguro de que quieres forzar el cierre de sesión?"),
        "settings_ForceLogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Confirmar cierre de sesión forzado"),
        "settings_FormatExceptionError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema en la respuesta"),
        "settings_ListViewTileTitle_about":
            MessageLookupByLibrary.simpleMessage("Acerca de"),
        "settings_ListViewTileTitle_accountDelete":
            MessageLookupByLibrary.simpleMessage("Eliminar cuenta"),
        "settings_ListViewTileTitle_help":
            MessageLookupByLibrary.simpleMessage("Ayuda"),
        "settings_ListViewTileTitle_language":
            MessageLookupByLibrary.simpleMessage("Idioma"),
        "settings_ListViewTileTitle_logRecordsConsole":
            MessageLookupByLibrary.simpleMessage("Consola de registros"),
        "settings_ListViewTileTitle_logout":
            MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "settings_ListViewTileTitle_network":
            MessageLookupByLibrary.simpleMessage("Configuración de red"),
        "settings_ListViewTileTitle_registered":
            MessageLookupByLibrary.simpleMessage("Registrado"),
        "settings_ListViewTileTitle_settings":
            MessageLookupByLibrary.simpleMessage("CONFIGURACIÓN"),
        "settings_ListViewTileTitle_termsConditions":
            MessageLookupByLibrary.simpleMessage("Términos y condiciones"),
        "settings_ListViewTileTitle_themeMode":
            MessageLookupByLibrary.simpleMessage("Modo de tema"),
        "settings_ListViewTileTitle_toolbox":
            MessageLookupByLibrary.simpleMessage("CAJA DE HERRAMIENTAS"),
        "settings_LogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "¿Está seguro de que desea cerrar sesión?"),
        "settings_LogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Confirmar el cierre de sesión"),
        "settings_RequestFailureError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un fallo del servidor"),
        "settings_SocketExceptionError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema con la red"),
        "settings_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema de seguridad en la red"),
        "settings_TypeErrorError": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un problema en la respuesta"),
        "themeMode_dark": MessageLookupByLibrary.simpleMessage("Modo Oscuro"),
        "themeMode_light": MessageLookupByLibrary.simpleMessage("Modo Claro"),
        "themeMode_system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "underDevelopment": MessageLookupByLibrary.simpleMessage(
            "Esta página está en desarrollo."),
        "validationBlankError":
            MessageLookupByLibrary.simpleMessage("Por favor, ingrese un valor"),
        "webRegistration_ErrorAcknowledgeDialogActions_demo":
            MessageLookupByLibrary.simpleMessage("Demo"),
        "webRegistration_ErrorAcknowledgeDialogActions_retry":
            MessageLookupByLibrary.simpleMessage("Reintentar"),
        "webRegistration_ErrorAcknowledgeDialogActions_skip":
            MessageLookupByLibrary.simpleMessage("Saltar"),
        "webRegistration_ErrorAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Error en recurso de web")
      };
}
