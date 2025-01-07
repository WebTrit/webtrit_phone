// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_widget_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeWidgetConfigImpl _$$ThemeWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ThemeWidgetConfigImpl(
      button: json['button'] == null
          ? null
          : ButtonWidgetConfig.fromJson(json['button'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : GroupWidgetConfig.fromJson(json['group'] as Map<String, dynamic>),
      bar: json['bar'] == null
          ? null
          : BarWidgetConfig.fromJson(json['bar'] as Map<String, dynamic>),
      picture: json['picture'] == null
          ? null
          : PictureWidgetConfig.fromJson(
              json['picture'] as Map<String, dynamic>),
      input: json['input'] == null
          ? null
          : InputWidgetConfig.fromJson(json['input'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : TextWidgetConfig.fromJson(json['text'] as Map<String, dynamic>),
      dialog: json['dialog'] == null
          ? null
          : DialogWidgetConfig.fromJson(json['dialog'] as Map<String, dynamic>),
      actionPad: json['actionPad'] == null
          ? null
          : ActionPadWidgetConfig.fromJson(
              json['actionPad'] as Map<String, dynamic>),
      statuses: json['statuses'] == null
          ? const StatusesWidgetConfig()
          : StatusesWidgetConfig.fromJson(
              json['statuses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ThemeWidgetConfigImplToJson(
        _$ThemeWidgetConfigImpl instance) =>
    <String, dynamic>{
      'button': instance.button,
      'group': instance.group,
      'bar': instance.bar,
      'picture': instance.picture,
      'input': instance.input,
      'text': instance.text,
      'dialog': instance.dialog,
      'actionPad': instance.actionPad,
      'statuses': instance.statuses,
    };

_$ButtonWidgetConfigImpl _$$ButtonWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ButtonWidgetConfigImpl(
      primaryElevatedButton: json['primaryElevatedButton'] == null
          ? null
          : ElevatedButtonWidgetConfig.fromJson(
              json['primaryElevatedButton'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ButtonWidgetConfigImplToJson(
        _$ButtonWidgetConfigImpl instance) =>
    <String, dynamic>{
      'primaryElevatedButton': instance.primaryElevatedButton,
    };

_$ElevatedButtonWidgetConfigImpl _$$ElevatedButtonWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ElevatedButtonWidgetConfigImpl(
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
      textColor: json['textColor'] as String?,
      iconColor: json['iconColor'] as String?,
      disabledIconColor: json['disabledIconColor'] as String?,
    );

Map<String, dynamic> _$$ElevatedButtonWidgetConfigImplToJson(
        _$ElevatedButtonWidgetConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'textColor': instance.textColor,
      'iconColor': instance.iconColor,
      'disabledIconColor': instance.disabledIconColor,
    };

_$GroupWidgetConfigImpl _$$GroupWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupWidgetConfigImpl(
      groupTitleListTile: json['groupTitleListTile'] == null
          ? null
          : GroupTitleListTileWidgetConfig.fromJson(
              json['groupTitleListTile'] as Map<String, dynamic>),
      callActions: json['callActions'] == null
          ? null
          : CallActionsWidgetConfig.fromJson(
              json['callActions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GroupWidgetConfigImplToJson(
        _$GroupWidgetConfigImpl instance) =>
    <String, dynamic>{
      'groupTitleListTile': instance.groupTitleListTile,
      'callActions': instance.callActions,
    };

_$BarWidgetConfigImpl _$$BarWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$BarWidgetConfigImpl(
      bottomNavigationBar: json['bottomNavigationBar'] == null
          ? null
          : BottomNavigationBarWidgetConfig.fromJson(
              json['bottomNavigationBar'] as Map<String, dynamic>),
      extTabBar: json['extTabBar'] == null
          ? null
          : ExtTabBarWidgetConfig.fromJson(
              json['extTabBar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BarWidgetConfigImplToJson(
        _$BarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'bottomNavigationBar': instance.bottomNavigationBar,
      'extTabBar': instance.extTabBar,
    };

_$BottomNavigationBarWidgetConfigImpl
    _$$BottomNavigationBarWidgetConfigImplFromJson(Map<String, dynamic> json) =>
        _$BottomNavigationBarWidgetConfigImpl(
          backgroundColor: json['backgroundColor'] as String?,
          selectedItemColor: json['selectedItemColor'] as String?,
          unSelectedItemColor: json['unSelectedItemColor'] as String?,
        );

Map<String, dynamic> _$$BottomNavigationBarWidgetConfigImplToJson(
        _$BottomNavigationBarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'selectedItemColor': instance.selectedItemColor,
      'unSelectedItemColor': instance.unSelectedItemColor,
    };

_$ExtTabBarWidgetConfigImpl _$$ExtTabBarWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ExtTabBarWidgetConfigImpl(
      foregroundColor: json['foregroundColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      selectedItemColor: json['selectedItemColor'] as String?,
      unSelectedItemColor: json['unSelectedItemColor'] as String?,
    );

Map<String, dynamic> _$$ExtTabBarWidgetConfigImplToJson(
        _$ExtTabBarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'foregroundColor': instance.foregroundColor,
      'backgroundColor': instance.backgroundColor,
      'selectedItemColor': instance.selectedItemColor,
      'unSelectedItemColor': instance.unSelectedItemColor,
    };

_$GroupTitleListTileWidgetConfigImpl
    _$$GroupTitleListTileWidgetConfigImplFromJson(Map<String, dynamic> json) =>
        _$GroupTitleListTileWidgetConfigImpl(
          backgroundColor: json['backgroundColor'] as String?,
          textColor: json['textColor'] as String?,
        );

Map<String, dynamic> _$$GroupTitleListTileWidgetConfigImplToJson(
        _$GroupTitleListTileWidgetConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'textColor': instance.textColor,
    };

_$CallActionsWidgetConfigImpl _$$CallActionsWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CallActionsWidgetConfigImpl(
      callStartBackgroundColor: json['callStartBackgroundColor'] as String?,
      hangupBackgroundColor: json['hangupBackgroundColor'] as String?,
      transferBackgroundColor: json['transferBackgroundColor'] as String?,
      cameraBackgroundColor: json['cameraBackgroundColor'] as String?,
      cameraActiveBackgroundColor:
          json['cameraActiveBackgroundColor'] as String?,
      mutedBackgroundColor: json['mutedBackgroundColor'] as String?,
      mutedActiveBackgroundColor: json['mutedActiveBackgroundColor'] as String?,
      speakerBackgroundColor: json['speakerBackgroundColor'] as String?,
      speakerActiveBackgroundColor:
          json['speakerActiveBackgroundColor'] as String?,
      heldBackgroundColor: json['heldBackgroundColor'] as String?,
      heldActiveBackgroundColor: json['heldActiveBackgroundColor'] as String?,
      swapBackgroundColor: json['swapBackgroundColor'] as String?,
      keyBackgroundColor: json['keyBackgroundColor'] as String?,
      keypadBackgroundColor: json['keypadBackgroundColor'] as String?,
      keypadActiveBackgroundColor:
          json['keypadActiveBackgroundColor'] as String?,
    );

Map<String, dynamic> _$$CallActionsWidgetConfigImplToJson(
        _$CallActionsWidgetConfigImpl instance) =>
    <String, dynamic>{
      'callStartBackgroundColor': instance.callStartBackgroundColor,
      'hangupBackgroundColor': instance.hangupBackgroundColor,
      'transferBackgroundColor': instance.transferBackgroundColor,
      'cameraBackgroundColor': instance.cameraBackgroundColor,
      'cameraActiveBackgroundColor': instance.cameraActiveBackgroundColor,
      'mutedBackgroundColor': instance.mutedBackgroundColor,
      'mutedActiveBackgroundColor': instance.mutedActiveBackgroundColor,
      'speakerBackgroundColor': instance.speakerBackgroundColor,
      'speakerActiveBackgroundColor': instance.speakerActiveBackgroundColor,
      'heldBackgroundColor': instance.heldBackgroundColor,
      'heldActiveBackgroundColor': instance.heldActiveBackgroundColor,
      'swapBackgroundColor': instance.swapBackgroundColor,
      'keyBackgroundColor': instance.keyBackgroundColor,
      'keypadBackgroundColor': instance.keypadBackgroundColor,
      'keypadActiveBackgroundColor': instance.keypadActiveBackgroundColor,
    };

_$PictureWidgetConfigImpl _$$PictureWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PictureWidgetConfigImpl(
      onboardingPictureLogo: json['onboardingPictureLogo'] == null
          ? null
          : LogoWidgetConfig.fromJson(
              json['onboardingPictureLogo'] as Map<String, dynamic>),
      onboardingLogo: json['onboardingLogo'] == null
          ? null
          : LogoWidgetConfig.fromJson(
              json['onboardingLogo'] as Map<String, dynamic>),
      appIcon: json['appIcon'] == null
          ? null
          : AppIconWidgetConfig.fromJson(
              json['appIcon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PictureWidgetConfigImplToJson(
        _$PictureWidgetConfigImpl instance) =>
    <String, dynamic>{
      'onboardingPictureLogo': instance.onboardingPictureLogo,
      'onboardingLogo': instance.onboardingLogo,
      'appIcon': instance.appIcon,
    };

_$LogoWidgetConfigImpl _$$LogoWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LogoWidgetConfigImpl(
      scale: (json['scale'] as num?)?.toDouble(),
      labelColor: json['labelColor'] as String?,
    );

Map<String, dynamic> _$$LogoWidgetConfigImplToJson(
        _$LogoWidgetConfigImpl instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'labelColor': instance.labelColor,
    };

_$AppIconWidgetConfigImpl _$$AppIconWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$AppIconWidgetConfigImpl(
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$AppIconWidgetConfigImplToJson(
        _$AppIconWidgetConfigImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
    };

_$InputWidgetConfigImpl _$$InputWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$InputWidgetConfigImpl(
      primary: json['primary'] == null
          ? null
          : TextFormFieldWidgetConfig.fromJson(
              json['primary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InputWidgetConfigImplToJson(
        _$InputWidgetConfigImpl instance) =>
    <String, dynamic>{
      'primary': instance.primary,
    };

_$TextFormFieldWidgetConfigImpl _$$TextFormFieldWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TextFormFieldWidgetConfigImpl(
      labelColor: json['labelColor'] as String?,
      border: json['border'] == null
          ? null
          : InputBorderWidgetConfig.fromJson(
              json['border'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TextFormFieldWidgetConfigImplToJson(
        _$TextFormFieldWidgetConfigImpl instance) =>
    <String, dynamic>{
      'labelColor': instance.labelColor,
      'border': instance.border,
    };

_$InputBorderWidgetConfigImpl _$$InputBorderWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$InputBorderWidgetConfigImpl(
      disabled: json['disabled'] == null
          ? null
          : BorderWidgetConfig.fromJson(
              json['disabled'] as Map<String, dynamic>),
      focused: json['focused'] == null
          ? null
          : BorderWidgetConfig.fromJson(
              json['focused'] as Map<String, dynamic>),
      any: json['any'] == null
          ? null
          : BorderWidgetConfig.fromJson(json['any'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InputBorderWidgetConfigImplToJson(
        _$InputBorderWidgetConfigImpl instance) =>
    <String, dynamic>{
      'disabled': instance.disabled,
      'focused': instance.focused,
      'any': instance.any,
    };

_$BorderWidgetConfigImpl _$$BorderWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$BorderWidgetConfigImpl(
      typicalColor: json['typicalColor'] as String?,
      errorColor: json['errorColor'] as String?,
    );

Map<String, dynamic> _$$BorderWidgetConfigImplToJson(
        _$BorderWidgetConfigImpl instance) =>
    <String, dynamic>{
      'typicalColor': instance.typicalColor,
      'errorColor': instance.errorColor,
    };

_$TextWidgetConfigImpl _$$TextWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TextWidgetConfigImpl(
      selection: json['selection'] == null
          ? null
          : TextSelectionWidgetConfig.fromJson(
              json['selection'] as Map<String, dynamic>),
      linkify: json['linkify'] == null
          ? null
          : LinkifyWidgetConfig.fromJson(
              json['linkify'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TextWidgetConfigImplToJson(
        _$TextWidgetConfigImpl instance) =>
    <String, dynamic>{
      'selection': instance.selection,
      'linkify': instance.linkify,
    };

_$TextSelectionWidgetConfigImpl _$$TextSelectionWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TextSelectionWidgetConfigImpl(
      cursorColor: json['cursorColor'] as String?,
      selectionColor: json['selectionColor'] as String?,
      selectionHandleColor: json['selectionHandleColor'] as String?,
    );

Map<String, dynamic> _$$TextSelectionWidgetConfigImplToJson(
        _$TextSelectionWidgetConfigImpl instance) =>
    <String, dynamic>{
      'cursorColor': instance.cursorColor,
      'selectionColor': instance.selectionColor,
      'selectionHandleColor': instance.selectionHandleColor,
    };

_$LinkifyWidgetConfigImpl _$$LinkifyWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LinkifyWidgetConfigImpl(
      styleColor: json['styleColor'] as String?,
      linkifyStyleColor: json['linkifyStyleColor'] as String?,
    );

Map<String, dynamic> _$$LinkifyWidgetConfigImplToJson(
        _$LinkifyWidgetConfigImpl instance) =>
    <String, dynamic>{
      'styleColor': instance.styleColor,
      'linkifyStyleColor': instance.linkifyStyleColor,
    };

_$DialogWidgetConfigImpl _$$DialogWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$DialogWidgetConfigImpl(
      confirmDialog: json['confirmDialog'] == null
          ? null
          : ConfirmDialogWidgetConfig.fromJson(
              json['confirmDialog'] as Map<String, dynamic>),
      snackBar: json['snackBar'] == null
          ? const SnackBarWidgetConfig()
          : SnackBarWidgetConfig.fromJson(
              json['snackBar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DialogWidgetConfigImplToJson(
        _$DialogWidgetConfigImpl instance) =>
    <String, dynamic>{
      'confirmDialog': instance.confirmDialog,
      'snackBar': instance.snackBar,
    };

_$ConfirmDialogWidgetConfigImpl _$$ConfirmDialogWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfirmDialogWidgetConfigImpl(
      activeButtonColor1: json['activeButtonColor1'] as String?,
      activeButtonColor2: json['activeButtonColor2'] as String?,
      defaultButtonColor: json['defaultButtonColor'] as String?,
    );

Map<String, dynamic> _$$ConfirmDialogWidgetConfigImplToJson(
        _$ConfirmDialogWidgetConfigImpl instance) =>
    <String, dynamic>{
      'activeButtonColor1': instance.activeButtonColor1,
      'activeButtonColor2': instance.activeButtonColor2,
      'defaultButtonColor': instance.defaultButtonColor,
    };

_$SnackBarWidgetConfigImpl _$$SnackBarWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$SnackBarWidgetConfigImpl(
      successBackgroundColor:
          json['successBackgroundColor'] as String? ?? '#75B943',
      errorBackgroundColor:
          json['errorBackgroundColor'] as String? ?? '#E74C3C',
      infoBackgroundColor: json['infoBackgroundColor'] as String? ?? '#494949',
      warningBackgroundColor:
          json['warningBackgroundColor'] as String? ?? '#F95A14',
    );

Map<String, dynamic> _$$SnackBarWidgetConfigImplToJson(
        _$SnackBarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'successBackgroundColor': instance.successBackgroundColor,
      'errorBackgroundColor': instance.errorBackgroundColor,
      'infoBackgroundColor': instance.infoBackgroundColor,
      'warningBackgroundColor': instance.warningBackgroundColor,
    };

_$ActionPadWidgetConfigImpl _$$ActionPadWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ActionPadWidgetConfigImpl(
      callStart: json['callStart'] == null
          ? null
          : ElevatedButtonWidgetConfig.fromJson(
              json['callStart'] as Map<String, dynamic>),
      callTransfer: json['callTransfer'] == null
          ? null
          : ElevatedButtonWidgetConfig.fromJson(
              json['callTransfer'] as Map<String, dynamic>),
      backspacePressed: json['backspacePressed'] == null
          ? null
          : ElevatedButtonWidgetConfig.fromJson(
              json['backspacePressed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ActionPadWidgetConfigImplToJson(
        _$ActionPadWidgetConfigImpl instance) =>
    <String, dynamic>{
      'callStart': instance.callStart,
      'callTransfer': instance.callTransfer,
      'backspacePressed': instance.backspacePressed,
    };

_$StatusesWidgetConfigImpl _$$StatusesWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusesWidgetConfigImpl(
      registrationStatuses: json['registrationStatuses'] == null
          ? const RegistrationStatusesWidgetConfig()
          : RegistrationStatusesWidgetConfig.fromJson(
              json['registrationStatuses'] as Map<String, dynamic>),
      callStatuses: json['callStatuses'] == null
          ? const CallStatusesWidgetConfig()
          : CallStatusesWidgetConfig.fromJson(
              json['callStatuses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatusesWidgetConfigImplToJson(
        _$StatusesWidgetConfigImpl instance) =>
    <String, dynamic>{
      'registrationStatuses': instance.registrationStatuses,
      'callStatuses': instance.callStatuses,
    };

_$RegistrationStatusesWidgetConfigImpl
    _$$RegistrationStatusesWidgetConfigImplFromJson(
            Map<String, dynamic> json) =>
        _$RegistrationStatusesWidgetConfigImpl(
          online: json['online'] as String? ?? '#75B943',
          offline: json['offline'] as String? ?? '#EEF3F6',
        );

Map<String, dynamic> _$$RegistrationStatusesWidgetConfigImplToJson(
        _$RegistrationStatusesWidgetConfigImpl instance) =>
    <String, dynamic>{
      'online': instance.online,
      'offline': instance.offline,
    };

_$CallStatusesWidgetConfigImpl _$$CallStatusesWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CallStatusesWidgetConfigImpl(
      connectivityNone: json['connectivityNone'] as String? ?? '#E74C3C',
      connectError: json['connectError'] as String? ?? '#E74C3C',
      appUnregistered: json['appUnregistered'] as String? ?? '#494949',
      connectIssue: json['connectIssue'] as String? ?? '#E74C3C',
      inProgress: json['inProgress'] as String? ?? '#123752',
      ready: json['ready'] as String? ?? '#75B943',
    );

Map<String, dynamic> _$$CallStatusesWidgetConfigImplToJson(
        _$CallStatusesWidgetConfigImpl instance) =>
    <String, dynamic>{
      'connectivityNone': instance.connectivityNone,
      'connectError': instance.connectError,
      'appUnregistered': instance.appUnregistered,
      'connectIssue': instance.connectIssue,
      'inProgress': instance.inProgress,
      'ready': instance.ready,
    };
