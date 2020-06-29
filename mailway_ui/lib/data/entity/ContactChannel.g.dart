// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactChannel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactChannel _$ContactChannelFromJson(Map<String, dynamic> json) {
  return ContactChannel(
    id: json['id'] as String,
    name: json['name'] as String,
    value: json['value'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
    contactId: json['contactId'] as String,
  );
}

Map<String, dynamic> _$ContactChannelToJson(ContactChannel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'contactId': instance.contactId,
    };
