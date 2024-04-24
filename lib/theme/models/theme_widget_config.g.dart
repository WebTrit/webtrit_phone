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
      backgroundColor: _$JsonConverterFromJson<String, Color>(
          json['backgroundColor'], const CSSColorConverter().fromJson),
      foregroundColor: _$JsonConverterFromJson<String, Color>(
          json['foregroundColor'], const CSSColorConverter().fromJson),
      textColor: _$JsonConverterFromJson<String, Color>(
          json['textColor'], const CSSColorConverter().fromJson),
    );

Map<String, dynamic> _$$ElevatedButtonWidgetConfigImplToJson(
        _$ElevatedButtonWidgetConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const CSSColorConverter().toJson),
      'foregroundColor': _$JsonConverterToJson<String, Color>(
          instance.foregroundColor, const CSSColorConverter().toJson),
      'textColor': _$JsonConverterToJson<String, Color>(
          instance.textColor, const CSSColorConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$GroupWidgetConfigImpl _$$GroupWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupWidgetConfigImpl(
      groupTitleListTile: json['groupTitleListTile'] == null
          ? null
          : GroupTitleListTileWidgetConfig.fromJson(
              json['groupTitleListTile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GroupWidgetConfigImplToJson(
        _$GroupWidgetConfigImpl instance) =>
    <String, dynamic>{
      'groupTitleListTile': instance.groupTitleListTile,
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
          backgroundColor: _$JsonConverterFromJson<String, Color>(
              json['backgroundColor'], const CSSColorConverter().fromJson),
          selectedItemColor: _$JsonConverterFromJson<String, Color>(
              json['selectedItemColor'], const CSSColorConverter().fromJson),
          unSelectedItemColor: _$JsonConverterFromJson<String, Color>(
              json['unSelectedItemColor'], const CSSColorConverter().fromJson),
        );

Map<String, dynamic> _$$BottomNavigationBarWidgetConfigImplToJson(
        _$BottomNavigationBarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const CSSColorConverter().toJson),
      'selectedItemColor': _$JsonConverterToJson<String, Color>(
          instance.selectedItemColor, const CSSColorConverter().toJson),
      'unSelectedItemColor': _$JsonConverterToJson<String, Color>(
          instance.unSelectedItemColor, const CSSColorConverter().toJson),
    };

_$ExtTabBarWidgetConfigImpl _$$ExtTabBarWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ExtTabBarWidgetConfigImpl(
      foregroundColor: _$JsonConverterFromJson<String, Color>(
          json['foregroundColor'], const CSSColorConverter().fromJson),
      backgroundColor: _$JsonConverterFromJson<String, Color>(
          json['backgroundColor'], const CSSColorConverter().fromJson),
      selectedItemColor: _$JsonConverterFromJson<String, Color>(
          json['selectedItemColor'], const CSSColorConverter().fromJson),
      unSelectedItemColor: _$JsonConverterFromJson<String, Color>(
          json['unSelectedItemColor'], const CSSColorConverter().fromJson),
    );

Map<String, dynamic> _$$ExtTabBarWidgetConfigImplToJson(
        _$ExtTabBarWidgetConfigImpl instance) =>
    <String, dynamic>{
      'foregroundColor': _$JsonConverterToJson<String, Color>(
          instance.foregroundColor, const CSSColorConverter().toJson),
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const CSSColorConverter().toJson),
      'selectedItemColor': _$JsonConverterToJson<String, Color>(
          instance.selectedItemColor, const CSSColorConverter().toJson),
      'unSelectedItemColor': _$JsonConverterToJson<String, Color>(
          instance.unSelectedItemColor, const CSSColorConverter().toJson),
    };

_$GroupTitleListTileWidgetConfigImpl
    _$$GroupTitleListTileWidgetConfigImplFromJson(Map<String, dynamic> json) =>
        _$GroupTitleListTileWidgetConfigImpl(
          backgroundColor: _$JsonConverterFromJson<String, Color>(
              json['backgroundColor'], const CSSColorConverter().fromJson),
        );

Map<String, dynamic> _$$GroupTitleListTileWidgetConfigImplToJson(
        _$GroupTitleListTileWidgetConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const CSSColorConverter().toJson),
    };

_$PictureWidgetConfigImpl _$$PictureWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PictureWidgetConfigImpl(
      onboardingPictureLogo: json['onboardingPictureLogo'] == null
          ? null
          : OnboardingPictureLogoWidgetConfig.fromJson(
              json['onboardingPictureLogo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PictureWidgetConfigImplToJson(
        _$PictureWidgetConfigImpl instance) =>
    <String, dynamic>{
      'onboardingPictureLogo': instance.onboardingPictureLogo,
    };

_$OnboardingPictureLogoWidgetConfigImpl
    _$$OnboardingPictureLogoWidgetConfigImplFromJson(
            Map<String, dynamic> json) =>
        _$OnboardingPictureLogoWidgetConfigImpl(
          scale: (json['scale'] as num?)?.toDouble(),
          labelColor: _$JsonConverterFromJson<String, Color>(
              json['labelColor'], const CSSColorConverter().fromJson),
        );

Map<String, dynamic> _$$OnboardingPictureLogoWidgetConfigImplToJson(
        _$OnboardingPictureLogoWidgetConfigImpl instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'labelColor': _$JsonConverterToJson<String, Color>(
          instance.labelColor, const CSSColorConverter().toJson),
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
      labelColor: _$JsonConverterFromJson<String, Color>(
          json['labelColor'], const CSSColorConverter().fromJson),
      border: json['border'] == null
          ? null
          : InputBorderWidgetConfig.fromJson(
              json['border'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TextFormFieldWidgetConfigImplToJson(
        _$TextFormFieldWidgetConfigImpl instance) =>
    <String, dynamic>{
      'labelColor': _$JsonConverterToJson<String, Color>(
          instance.labelColor, const CSSColorConverter().toJson),
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
      typicalColor: _$JsonConverterFromJson<String, Color>(
          json['typicalColor'], const CSSColorConverter().fromJson),
      errorColor: _$JsonConverterFromJson<String, Color>(
          json['errorColor'], const CSSColorConverter().fromJson),
    );

Map<String, dynamic> _$$BorderWidgetConfigImplToJson(
        _$BorderWidgetConfigImpl instance) =>
    <String, dynamic>{
      'typicalColor': _$JsonConverterToJson<String, Color>(
          instance.typicalColor, const CSSColorConverter().toJson),
      'errorColor': _$JsonConverterToJson<String, Color>(
          instance.errorColor, const CSSColorConverter().toJson),
    };

_$TextWidgetConfigImpl _$$TextWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TextWidgetConfigImpl(
      selection: json['selection'] == null
          ? null
          : TextSelectionWidgetConfig.fromJson(
              json['selection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TextWidgetConfigImplToJson(
        _$TextWidgetConfigImpl instance) =>
    <String, dynamic>{
      'selection': instance.selection,
    };

_$TextSelectionWidgetConfigImpl _$$TextSelectionWidgetConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TextSelectionWidgetConfigImpl(
      cursorColor: _$JsonConverterFromJson<String, Color>(
          json['cursorColor'], const CSSColorConverter().fromJson),
      selectionColor: _$JsonConverterFromJson<String, Color>(
          json['selectionColor'], const CSSColorConverter().fromJson),
      selectionHandleColor: _$JsonConverterFromJson<String, Color>(
          json['selectionHandleColor'], const CSSColorConverter().fromJson),
    );

Map<String, dynamic> _$$TextSelectionWidgetConfigImplToJson(
        _$TextSelectionWidgetConfigImpl instance) =>
    <String, dynamic>{
      'cursorColor': _$JsonConverterToJson<String, Color>(
          instance.cursorColor, const CSSColorConverter().toJson),
      'selectionColor': _$JsonConverterToJson<String, Color>(
          instance.selectionColor, const CSSColorConverter().toJson),
      'selectionHandleColor': _$JsonConverterToJson<String, Color>(
          instance.selectionHandleColor, const CSSColorConverter().toJson),
    };
