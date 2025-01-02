// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_pages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomPagesResponseImpl _$$CustomPagesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomPagesResponseImpl(
      pages: (json['pages'] as List<dynamic>)
          .map((e) => CustomPageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CustomPagesResponseImplToJson(
        _$CustomPagesResponseImpl instance) =>
    <String, dynamic>{
      'pages': instance.pages,
    };

_$CustomPageResponseImpl _$$CustomPageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomPageResponseImpl(
      title: json['title'] as String,
      url: Uri.parse(json['url'] as String),
      extraData: json['extra_data'] as Map<String, dynamic>,
      description: json['description'] as String?,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$CustomPageResponseImplToJson(
        _$CustomPageResponseImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url.toString(),
      'extra_data': instance.extraData,
      'description': instance.description,
      'expires_at': instance.expiresAt?.toIso8601String(),
    };
