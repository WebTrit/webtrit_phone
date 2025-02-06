// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_widget_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeWidgetConfigImpl _$$ThemeWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ThemeWidgetConfigImpl(
      fonts: json['fonts'] == null
          ? const FontsConfig()
          : FontsConfig.fromJson(json['fonts'] as Map<String, dynamic>),
      button: json['button'] == null
          ? const ButtonWidgetConfig()
          : ButtonWidgetConfig.fromJson(json['button'] as Map<String, dynamic>),
      group: json['group'] == null
          ? const GroupWidgetConfig()
          : GroupWidgetConfig.fromJson(json['group'] as Map<String, dynamic>),
      bar: json['bar'] == null
          ? const BarWidgetConfig()
          : BarWidgetConfig.fromJson(json['bar'] as Map<String, dynamic>),
      imageAssets: json['imageAssets'] == null
          ? const ImageAssetsConfig()
          : ImageAssetsConfig.fromJson(
              json['imageAssets'] as Map<String, dynamic>),
      input: json['input'] == null
          ? const InputWidgetConfig()
          : InputWidgetConfig.fromJson(json['input'] as Map<String, dynamic>),
      text: json['text'] == null
          ? const TextWidgetConfig()
          : TextWidgetConfig.fromJson(json['text'] as Map<String, dynamic>),
      dialog: json['dialog'] == null
          ? const DialogWidgetConfig()
          : DialogWidgetConfig.fromJson(json['dialog'] as Map<String, dynamic>),
      actionPad: json['actionPad'] == null
          ? const ActionPadWidgetConfig()
          : ActionPadWidgetConfig.fromJson(
              json['actionPad'] as Map<String, dynamic>),
      statuses: json['statuses'] == null
          ? const StatusesWidgetConfig()
          : StatusesWidgetConfig.fromJson(
              json['statuses'] as Map<String, dynamic>),
      decorationConfig: json['decorationConfig'] == null
          ? const DecorationConfig()
          : DecorationConfig.fromJson(
              json['decorationConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ThemeWidgetConfigImplToJson(
        _$ThemeWidgetConfigImpl instance) =>
    <String, dynamic>{
      'fonts': instance.fonts.toJson(),
      'button': instance.button.toJson(),
      'group': instance.group?.toJson(),
      'bar': instance.bar.toJson(),
      'imageAssets': instance.imageAssets.toJson(),
      'input': instance.input.toJson(),
      'text': instance.text.toJson(),
      'dialog': instance.dialog.toJson(),
      'actionPad': instance.actionPad.toJson(),
      'statuses': instance.statuses.toJson(),
      'decorationConfig': instance.decorationConfig.toJson(),
    };

_$FontsConfigImpl _$$FontsConfigImplFromJson(Map<String, dynamic> json) =>
    _$FontsConfigImpl(
      fontFamily: json['fontFamily'] as String? ?? 'Montserrat',
    );

Map<String, dynamic> _$$FontsConfigImplToJson(_$FontsConfigImpl instance) =>
    <String, dynamic>{
      'fontFamily': instance.fontFamily,
    };

_$ButtonWidgetConfigImpl _$$ButtonWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ButtonWidgetConfigImpl(
      primaryElevatedButton: json['primaryElevatedButton'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['primaryElevatedButton'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ButtonWidgetConfigImplToJson(
        _$ButtonWidgetConfigImpl instance) =>
    <String, dynamic>{
      'primaryElevatedButton': instance.primaryElevatedButton.toJson(),
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
          ? const GroupTitleListTileWidgetConfig()
          : GroupTitleListTileWidgetConfig.fromJson(
              json['groupTitleListTile'] as Map<String, dynamic>),
      callActions: json['callActions'] == null
          ? const CallActionsWidgetConfig()
          : CallActionsWidgetConfig.fromJson(
              json['callActions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GroupWidgetConfigImplToJson(
        _$GroupWidgetConfigImpl instance) =>
    <String, dynamic>{
      'groupTitleListTile': instance.groupTitleListTile.toJson(),
      'callActions': instance.callActions.toJson(),
    };

_$BarWidgetConfigImpl _$$BarWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$BarWidgetConfigImpl(
      bottomNavigationBar: json['bottomNavigationBar'] == null
          ? const BottomNavigationBarWidgetConfig()
          : BottomNavigationBarWidgetConfig.fromJson(
              json['bottomNavigationBar'] as Map<String, dynamic>),
      extTabBar: json['extTabBar'] == null
          ? const ExtTabBarWidgetConfig()
          : ExtTabBarWidgetConfig.fromJson(
              json['extTabBar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BarWidgetConfigImplToJson(
        _$BarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'bottomNavigationBar': instance.bottomNavigationBar.toJson(),
      'extTabBar': instance.extTabBar.toJson(),
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

_$ImageAssetsConfigImpl _$$ImageAssetsConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageAssetsConfigImpl(
      primaryOnboardingLogo: json['primaryOnboardingLogo'] as String? ??
          'asset://assets/primary_onboardin_logo.svg',
      secondaryOnboardingLogo: json['secondaryOnboardingLogo'] as String? ??
          'asset://assets/secondary_onboardin_logo.svg',
      onboardingPictureLogo: json['onboardingPictureLogo'] == null
          ? const LogoWidgetConfig()
          : LogoWidgetConfig.fromJson(
              json['onboardingPictureLogo'] as Map<String, dynamic>),
      onboardingLogo: json['onboardingLogo'] == null
          ? const LogoWidgetConfig()
          : LogoWidgetConfig.fromJson(
              json['onboardingLogo'] as Map<String, dynamic>),
      appIcon: json['appIcon'] == null
          ? const AppIconWidgetConfig()
          : AppIconWidgetConfig.fromJson(
              json['appIcon'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImageAssetsConfigImplToJson(
        _$ImageAssetsConfigImpl instance) =>
    <String, dynamic>{
      'primaryOnboardingLogo': instance.primaryOnboardingLogo,
      'secondaryOnboardingLogo': instance.secondaryOnboardingLogo,
      'onboardingPictureLogo': instance.onboardingPictureLogo.toJson(),
      'onboardingLogo': instance.onboardingLogo.toJson(),
      'appIcon': instance.appIcon.toJson(),
      'metadata': instance.metadata.toJson(),
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
          ? const TextFormFieldWidgetConfig()
          : TextFormFieldWidgetConfig.fromJson(
              json['primary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InputWidgetConfigImplToJson(
        _$InputWidgetConfigImpl instance) =>
    <String, dynamic>{
      'primary': instance.primary.toJson(),
    };

_$TextFormFieldWidgetConfigImpl _$$TextFormFieldWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TextFormFieldWidgetConfigImpl(
      labelColor: json['labelColor'] as String?,
      border: json['border'] == null
          ? const InputBorderWidgetConfig()
          : InputBorderWidgetConfig.fromJson(
              json['border'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TextFormFieldWidgetConfigImplToJson(
        _$TextFormFieldWidgetConfigImpl instance) =>
    <String, dynamic>{
      'labelColor': instance.labelColor,
      'border': instance.border.toJson(),
    };

_$InputBorderWidgetConfigImpl _$$InputBorderWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$InputBorderWidgetConfigImpl(
      disabled: json['disabled'] == null
          ? const BorderWidgetConfig()
          : BorderWidgetConfig.fromJson(
              json['disabled'] as Map<String, dynamic>),
      focused: json['focused'] == null
          ? const BorderWidgetConfig()
          : BorderWidgetConfig.fromJson(
              json['focused'] as Map<String, dynamic>),
      any: json['any'] == null
          ? const BorderWidgetConfig()
          : BorderWidgetConfig.fromJson(json['any'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InputBorderWidgetConfigImplToJson(
        _$InputBorderWidgetConfigImpl instance) =>
    <String, dynamic>{
      'disabled': instance.disabled.toJson(),
      'focused': instance.focused.toJson(),
      'any': instance.any.toJson(),
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
          ? const TextSelectionWidgetConfig()
          : TextSelectionWidgetConfig.fromJson(
              json['selection'] as Map<String, dynamic>),
      linkify: json['linkify'] == null
          ? const LinkifyWidgetConfig()
          : LinkifyWidgetConfig.fromJson(
              json['linkify'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TextWidgetConfigImplToJson(
        _$TextWidgetConfigImpl instance) =>
    <String, dynamic>{
      'selection': instance.selection.toJson(),
      'linkify': instance.linkify.toJson(),
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
          ? const ConfirmDialogWidgetConfig()
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
      'confirmDialog': instance.confirmDialog.toJson(),
      'snackBar': instance.snackBar.toJson(),
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
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['callStart'] as Map<String, dynamic>),
      callTransfer: json['callTransfer'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['callTransfer'] as Map<String, dynamic>),
      backspacePressed: json['backspacePressed'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['backspacePressed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ActionPadWidgetConfigImplToJson(
        _$ActionPadWidgetConfigImpl instance) =>
    <String, dynamic>{
      'callStart': instance.callStart.toJson(),
      'callTransfer': instance.callTransfer.toJson(),
      'backspacePressed': instance.backspacePressed.toJson(),
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
      'registrationStatuses': instance.registrationStatuses.toJson(),
      'callStatuses': instance.callStatuses.toJson(),
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

_$DecorationConfigImpl _$$DecorationConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$DecorationConfigImpl(
      primaryGradientColorsConfig: json['primaryGradientColorsConfig'] == null
          ? const GradientColorsConfig()
          : GradientColorsConfig.fromJson(
              json['primaryGradientColorsConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DecorationConfigImplToJson(
        _$DecorationConfigImpl instance) =>
    <String, dynamic>{
      'primaryGradientColorsConfig':
          instance.primaryGradientColorsConfig.toJson(),
    };

_$PrimaryGradientColorsConfigImpl _$$PrimaryGradientColorsConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PrimaryGradientColorsConfigImpl(
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => CustomColor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PrimaryGradientColorsConfigImplToJson(
        _$PrimaryGradientColorsConfigImpl instance) =>
    <String, dynamic>{
      'colors': instance.colors.map((e) => e.toJson()).toList(),
    };
