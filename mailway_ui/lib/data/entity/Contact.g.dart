// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    id: json['id'] as String,
    name: json['name'] as String,
    avatar: json['avatar'] as String,
    note: json['note'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
    i18nNames: (json['i18nNames'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'note': instance.note,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'i18nNames': instance.i18nNames,
    };
