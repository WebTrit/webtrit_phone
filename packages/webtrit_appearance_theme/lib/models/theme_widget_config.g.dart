// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_widget_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeWidgetConfig _$ThemeWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ThemeWidgetConfig(
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
      : ImageAssetsConfig.fromJson(json['imageAssets'] as Map<String, dynamic>),
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
          json['actionPad'] as Map<String, dynamic>,
        ),
  statuses: json['statuses'] == null
      ? const StatusesWidgetConfig()
      : StatusesWidgetConfig.fromJson(json['statuses'] as Map<String, dynamic>),
  decorationConfig: json['decorationConfig'] == null
      ? const DecorationConfig()
      : DecorationConfig.fromJson(
          json['decorationConfig'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ThemeWidgetConfigToJson(ThemeWidgetConfig instance) =>
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

FontsConfig _$FontsConfigFromJson(Map<String, dynamic> json) =>
    FontsConfig(fontFamily: json['fontFamily'] as String?);

Map<String, dynamic> _$FontsConfigToJson(FontsConfig instance) =>
    <String, dynamic>{'fontFamily': instance.fontFamily};

ButtonWidgetConfig _$ButtonWidgetConfigFromJson(Map<String, dynamic> json) =>
    ButtonWidgetConfig(
      primaryElevatedButton: json['primaryElevatedButton'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['primaryElevatedButton'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ButtonWidgetConfigToJson(ButtonWidgetConfig instance) =>
    <String, dynamic>{
      'primaryElevatedButton': instance.primaryElevatedButton.toJson(),
    };

ElevatedButtonWidgetConfig _$ElevatedButtonWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ElevatedButtonWidgetConfig(
  backgroundColor: json['backgroundColor'] as String?,
  foregroundColor: json['foregroundColor'] as String?,
  textColor: json['textColor'] as String?,
  iconColor: json['iconColor'] as String?,
  disabledIconColor: json['disabledIconColor'] as String?,
  disabledBackgroundColor: json['disabledBackgroundColor'] as String?,
  disabledForegroundColor: json['disabledForegroundColor'] as String?,
);

Map<String, dynamic> _$ElevatedButtonWidgetConfigToJson(
  ElevatedButtonWidgetConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'foregroundColor': instance.foregroundColor,
  'textColor': instance.textColor,
  'iconColor': instance.iconColor,
  'disabledIconColor': instance.disabledIconColor,
  'disabledBackgroundColor': instance.disabledBackgroundColor,
  'disabledForegroundColor': instance.disabledForegroundColor,
};

GroupWidgetConfig _$GroupWidgetConfigFromJson(Map<String, dynamic> json) =>
    GroupWidgetConfig(
      groupTitleListTile: json['groupTitleListTile'] == null
          ? const GroupTitleListTileWidgetConfig()
          : GroupTitleListTileWidgetConfig.fromJson(
              json['groupTitleListTile'] as Map<String, dynamic>,
            ),
      callActions: json['callActions'] == null
          ? const CallActionsWidgetConfig()
          : CallActionsWidgetConfig.fromJson(
              json['callActions'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GroupWidgetConfigToJson(GroupWidgetConfig instance) =>
    <String, dynamic>{
      'groupTitleListTile': instance.groupTitleListTile.toJson(),
      'callActions': instance.callActions.toJson(),
    };

BarWidgetConfig _$BarWidgetConfigFromJson(Map<String, dynamic> json) =>
    BarWidgetConfig(
      bottomNavigationBar: json['bottomNavigationBar'] == null
          ? const BottomNavigationBarWidgetConfig()
          : BottomNavigationBarWidgetConfig.fromJson(
              json['bottomNavigationBar'] as Map<String, dynamic>,
            ),
      extTabBar: json['extTabBar'] == null
          ? const ExtTabBarWidgetConfig()
          : ExtTabBarWidgetConfig.fromJson(
              json['extTabBar'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$BarWidgetConfigToJson(BarWidgetConfig instance) =>
    <String, dynamic>{
      'bottomNavigationBar': instance.bottomNavigationBar.toJson(),
      'extTabBar': instance.extTabBar.toJson(),
    };

BottomNavigationBarWidgetConfig _$BottomNavigationBarWidgetConfigFromJson(
  Map<String, dynamic> json,
) => BottomNavigationBarWidgetConfig(
  backgroundColor: json['backgroundColor'] as String?,
  selectedItemColor: json['selectedItemColor'] as String?,
  unSelectedItemColor: json['unSelectedItemColor'] as String?,
);

Map<String, dynamic> _$BottomNavigationBarWidgetConfigToJson(
  BottomNavigationBarWidgetConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'selectedItemColor': instance.selectedItemColor,
  'unSelectedItemColor': instance.unSelectedItemColor,
};

ExtTabBarWidgetConfig _$ExtTabBarWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ExtTabBarWidgetConfig(
  foregroundColor: json['foregroundColor'] as String?,
  backgroundColor: json['backgroundColor'] as String?,
  selectedItemColor: json['selectedItemColor'] as String?,
  unSelectedItemColor: json['unSelectedItemColor'] as String?,
);

Map<String, dynamic> _$ExtTabBarWidgetConfigToJson(
  ExtTabBarWidgetConfig instance,
) => <String, dynamic>{
  'foregroundColor': instance.foregroundColor,
  'backgroundColor': instance.backgroundColor,
  'selectedItemColor': instance.selectedItemColor,
  'unSelectedItemColor': instance.unSelectedItemColor,
};

GroupTitleListTileWidgetConfig _$GroupTitleListTileWidgetConfigFromJson(
  Map<String, dynamic> json,
) => GroupTitleListTileWidgetConfig(
  backgroundColor: json['backgroundColor'] as String?,
  textColor: json['textColor'] as String?,
);

Map<String, dynamic> _$GroupTitleListTileWidgetConfigToJson(
  GroupTitleListTileWidgetConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'textColor': instance.textColor,
};

CallActionsWidgetConfig _$CallActionsWidgetConfigFromJson(
  Map<String, dynamic> json,
) => CallActionsWidgetConfig(
  callStartBackgroundColor: json['callStartBackgroundColor'] as String?,
  hangupBackgroundColor: json['hangupBackgroundColor'] as String?,
  transferBackgroundColor: json['transferBackgroundColor'] as String?,
  cameraBackgroundColor: json['cameraBackgroundColor'] as String?,
  cameraActiveBackgroundColor: json['cameraActiveBackgroundColor'] as String?,
  mutedBackgroundColor: json['mutedBackgroundColor'] as String?,
  mutedActiveBackgroundColor: json['mutedActiveBackgroundColor'] as String?,
  speakerBackgroundColor: json['speakerBackgroundColor'] as String?,
  speakerActiveBackgroundColor: json['speakerActiveBackgroundColor'] as String?,
  heldBackgroundColor: json['heldBackgroundColor'] as String?,
  heldActiveBackgroundColor: json['heldActiveBackgroundColor'] as String?,
  swapBackgroundColor: json['swapBackgroundColor'] as String?,
  keyBackgroundColor: json['keyBackgroundColor'] as String?,
  keypadBackgroundColor: json['keypadBackgroundColor'] as String?,
  keypadActiveBackgroundColor: json['keypadActiveBackgroundColor'] as String?,
);

Map<String, dynamic> _$CallActionsWidgetConfigToJson(
  CallActionsWidgetConfig instance,
) => <String, dynamic>{
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

ImageAssetsConfig _$ImageAssetsConfigFromJson(Map<String, dynamic> json) =>
    ImageAssetsConfig(
      defaultPlaceholderImage: json['defaultPlaceholderImage'] == null
          ? null
          : ImageSource.fromJson(
              json['defaultPlaceholderImage'] as Map<String, dynamic>,
            ),
      appIcon: json['appIcon'] == null
          ? const AppIconWidgetConfig()
          : AppIconWidgetConfig.fromJson(
              json['appIcon'] as Map<String, dynamic>,
            ),
      leadingAvatarStyle: json['leadingAvatarStyle'] == null
          ? const LeadingAvatarStyleConfig()
          : LeadingAvatarStyleConfig.fromJson(
              json['leadingAvatarStyle'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ImageAssetsConfigToJson(ImageAssetsConfig instance) =>
    <String, dynamic>{
      'defaultPlaceholderImage': instance.defaultPlaceholderImage?.toJson(),
      'appIcon': instance.appIcon.toJson(),
      'leadingAvatarStyle': instance.leadingAvatarStyle.toJson(),
    };

ImageAssetConfig _$ImageAssetConfigFromJson(Map<String, dynamic> json) =>
    ImageAssetConfig(
      imageSource: json['imageSource'] == null
          ? null
          : ImageSource.fromJson(json['imageSource'] as Map<String, dynamic>),
      widthFactor: (json['widthFactor'] as num?)?.toDouble() ?? 1.0,
      labelColor: json['labelColor'] as String? ?? '#FFFFFF',
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$ImageAssetConfigToJson(ImageAssetConfig instance) =>
    <String, dynamic>{
      'imageSource': instance.imageSource?.toJson(),
      'widthFactor': instance.widthFactor,
      'labelColor': instance.labelColor,
      'metadata': instance.metadata.toJson(),
      'uri': instance.uri,
    };

AppIconWidgetConfig _$AppIconWidgetConfigFromJson(Map<String, dynamic> json) =>
    AppIconWidgetConfig(color: json['color'] as String?);

Map<String, dynamic> _$AppIconWidgetConfigToJson(
  AppIconWidgetConfig instance,
) => <String, dynamic>{'color': instance.color};

InputWidgetConfig _$InputWidgetConfigFromJson(Map<String, dynamic> json) =>
    InputWidgetConfig(
      primary: json['primary'] == null
          ? const TextFormFieldWidgetConfig()
          : TextFormFieldWidgetConfig.fromJson(
              json['primary'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$InputWidgetConfigToJson(InputWidgetConfig instance) =>
    <String, dynamic>{'primary': instance.primary.toJson()};

TextFormFieldWidgetConfig _$TextFormFieldWidgetConfigFromJson(
  Map<String, dynamic> json,
) => TextFormFieldWidgetConfig(
  labelColor: json['labelColor'] as String?,
  border: json['border'] == null
      ? const InputBorderWidgetConfig()
      : InputBorderWidgetConfig.fromJson(
          json['border'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$TextFormFieldWidgetConfigToJson(
  TextFormFieldWidgetConfig instance,
) => <String, dynamic>{
  'labelColor': instance.labelColor,
  'border': instance.border.toJson(),
};

InputBorderWidgetConfig _$InputBorderWidgetConfigFromJson(
  Map<String, dynamic> json,
) => InputBorderWidgetConfig(
  disabled: json['disabled'] == null
      ? const BorderWidgetConfig()
      : BorderWidgetConfig.fromJson(json['disabled'] as Map<String, dynamic>),
  focused: json['focused'] == null
      ? const BorderWidgetConfig()
      : BorderWidgetConfig.fromJson(json['focused'] as Map<String, dynamic>),
  any: json['any'] == null
      ? const BorderWidgetConfig()
      : BorderWidgetConfig.fromJson(json['any'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InputBorderWidgetConfigToJson(
  InputBorderWidgetConfig instance,
) => <String, dynamic>{
  'disabled': instance.disabled.toJson(),
  'focused': instance.focused.toJson(),
  'any': instance.any.toJson(),
};

BorderWidgetConfig _$BorderWidgetConfigFromJson(Map<String, dynamic> json) =>
    BorderWidgetConfig(
      typicalColor: json['typicalColor'] as String?,
      errorColor: json['errorColor'] as String?,
    );

Map<String, dynamic> _$BorderWidgetConfigToJson(BorderWidgetConfig instance) =>
    <String, dynamic>{
      'typicalColor': instance.typicalColor,
      'errorColor': instance.errorColor,
    };

TextWidgetConfig _$TextWidgetConfigFromJson(Map<String, dynamic> json) =>
    TextWidgetConfig(
      selection: json['selection'] == null
          ? const TextSelectionWidgetConfig()
          : TextSelectionWidgetConfig.fromJson(
              json['selection'] as Map<String, dynamic>,
            ),
      linkify: json['linkify'] == null
          ? const LinkifyWidgetConfig()
          : LinkifyWidgetConfig.fromJson(
              json['linkify'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TextWidgetConfigToJson(TextWidgetConfig instance) =>
    <String, dynamic>{
      'selection': instance.selection.toJson(),
      'linkify': instance.linkify.toJson(),
    };

TextSelectionWidgetConfig _$TextSelectionWidgetConfigFromJson(
  Map<String, dynamic> json,
) => TextSelectionWidgetConfig(
  cursorColor: json['cursorColor'] as String?,
  selectionColor: json['selectionColor'] as String?,
  selectionHandleColor: json['selectionHandleColor'] as String?,
);

Map<String, dynamic> _$TextSelectionWidgetConfigToJson(
  TextSelectionWidgetConfig instance,
) => <String, dynamic>{
  'cursorColor': instance.cursorColor,
  'selectionColor': instance.selectionColor,
  'selectionHandleColor': instance.selectionHandleColor,
};

LinkifyWidgetConfig _$LinkifyWidgetConfigFromJson(Map<String, dynamic> json) =>
    LinkifyWidgetConfig(
      styleColor: json['styleColor'] as String?,
      linkifyStyleColor: json['linkifyStyleColor'] as String?,
    );

Map<String, dynamic> _$LinkifyWidgetConfigToJson(
  LinkifyWidgetConfig instance,
) => <String, dynamic>{
  'styleColor': instance.styleColor,
  'linkifyStyleColor': instance.linkifyStyleColor,
};

DialogWidgetConfig _$DialogWidgetConfigFromJson(Map<String, dynamic> json) =>
    DialogWidgetConfig(
      confirmDialog: json['confirmDialog'] == null
          ? const ConfirmDialogWidgetConfig()
          : ConfirmDialogWidgetConfig.fromJson(
              json['confirmDialog'] as Map<String, dynamic>,
            ),
      snackBar: json['snackBar'] == null
          ? const SnackBarWidgetConfig()
          : SnackBarWidgetConfig.fromJson(
              json['snackBar'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DialogWidgetConfigToJson(DialogWidgetConfig instance) =>
    <String, dynamic>{
      'confirmDialog': instance.confirmDialog.toJson(),
      'snackBar': instance.snackBar.toJson(),
    };

ConfirmDialogWidgetConfig _$ConfirmDialogWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ConfirmDialogWidgetConfig(
  activeButtonColor1: json['activeButtonColor1'] as String?,
  activeButtonColor2: json['activeButtonColor2'] as String?,
  defaultButtonColor: json['defaultButtonColor'] as String?,
);

Map<String, dynamic> _$ConfirmDialogWidgetConfigToJson(
  ConfirmDialogWidgetConfig instance,
) => <String, dynamic>{
  'activeButtonColor1': instance.activeButtonColor1,
  'activeButtonColor2': instance.activeButtonColor2,
  'defaultButtonColor': instance.defaultButtonColor,
};

SnackBarWidgetConfig _$SnackBarWidgetConfigFromJson(
  Map<String, dynamic> json,
) => SnackBarWidgetConfig(
  successBackgroundColor:
      json['successBackgroundColor'] as String? ?? '#75B943',
  errorBackgroundColor: json['errorBackgroundColor'] as String? ?? '#E74C3C',
  infoBackgroundColor: json['infoBackgroundColor'] as String? ?? '#494949',
  warningBackgroundColor:
      json['warningBackgroundColor'] as String? ?? '#F95A14',
);

Map<String, dynamic> _$SnackBarWidgetConfigToJson(
  SnackBarWidgetConfig instance,
) => <String, dynamic>{
  'successBackgroundColor': instance.successBackgroundColor,
  'errorBackgroundColor': instance.errorBackgroundColor,
  'infoBackgroundColor': instance.infoBackgroundColor,
  'warningBackgroundColor': instance.warningBackgroundColor,
};

ActionPadWidgetConfig _$ActionPadWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ActionPadWidgetConfig(
  callStart: json['callStart'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['callStart'] as Map<String, dynamic>,
        ),
  callTransfer: json['callTransfer'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['callTransfer'] as Map<String, dynamic>,
        ),
  backspacePressed: json['backspacePressed'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['backspacePressed'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ActionPadWidgetConfigToJson(
  ActionPadWidgetConfig instance,
) => <String, dynamic>{
  'callStart': instance.callStart.toJson(),
  'callTransfer': instance.callTransfer.toJson(),
  'backspacePressed': instance.backspacePressed.toJson(),
};

StatusesWidgetConfig _$StatusesWidgetConfigFromJson(
  Map<String, dynamic> json,
) => StatusesWidgetConfig(
  registrationStatuses: json['registrationStatuses'] == null
      ? const RegistrationStatusesWidgetConfig()
      : RegistrationStatusesWidgetConfig.fromJson(
          json['registrationStatuses'] as Map<String, dynamic>,
        ),
  callStatuses: json['callStatuses'] == null
      ? const CallStatusesWidgetConfig()
      : CallStatusesWidgetConfig.fromJson(
          json['callStatuses'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$StatusesWidgetConfigToJson(
  StatusesWidgetConfig instance,
) => <String, dynamic>{
  'registrationStatuses': instance.registrationStatuses.toJson(),
  'callStatuses': instance.callStatuses.toJson(),
};

RegistrationStatusesWidgetConfig _$RegistrationStatusesWidgetConfigFromJson(
  Map<String, dynamic> json,
) => RegistrationStatusesWidgetConfig(
  online: json['online'] as String? ?? '#75B943',
  offline: json['offline'] as String? ?? '#EEF3F6',
);

Map<String, dynamic> _$RegistrationStatusesWidgetConfigToJson(
  RegistrationStatusesWidgetConfig instance,
) => <String, dynamic>{'online': instance.online, 'offline': instance.offline};

CallStatusesWidgetConfig _$CallStatusesWidgetConfigFromJson(
  Map<String, dynamic> json,
) => CallStatusesWidgetConfig(
  connectivityNone: json['connectivityNone'] as String? ?? '#E74C3C',
  connectError: json['connectError'] as String? ?? '#E74C3C',
  appUnregistered: json['appUnregistered'] as String? ?? '#494949',
  connectIssue: json['connectIssue'] as String? ?? '#E74C3C',
  inProgress: json['inProgress'] as String? ?? '#123752',
  ready: json['ready'] as String? ?? '#75B943',
);

Map<String, dynamic> _$CallStatusesWidgetConfigToJson(
  CallStatusesWidgetConfig instance,
) => <String, dynamic>{
  'connectivityNone': instance.connectivityNone,
  'connectError': instance.connectError,
  'appUnregistered': instance.appUnregistered,
  'connectIssue': instance.connectIssue,
  'inProgress': instance.inProgress,
  'ready': instance.ready,
};

DecorationConfig _$DecorationConfigFromJson(Map<String, dynamic> json) =>
    DecorationConfig(
      primaryGradientColorsConfig: json['primaryGradientColorsConfig'] == null
          ? const GradientColorsConfig()
          : GradientColorsConfig.fromJson(
              json['primaryGradientColorsConfig'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DecorationConfigToJson(
  DecorationConfig instance,
) => <String, dynamic>{
  'primaryGradientColorsConfig': instance.primaryGradientColorsConfig.toJson(),
};

GradientColorsConfig _$GradientColorsConfigFromJson(
  Map<String, dynamic> json,
) => GradientColorsConfig(
  colors:
      (json['colors'] as List<dynamic>?)
          ?.map((e) => CustomColor.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GradientColorsConfigToJson(
  GradientColorsConfig instance,
) => <String, dynamic>{
  'colors': instance.colors.map((e) => e.toJson()).toList(),
};
