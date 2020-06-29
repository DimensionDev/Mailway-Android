// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMemberNameStub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMemberNameStub _$ChatMemberNameStubFromJson(Map<String, dynamic> json) {
  return ChatMemberNameStub(
    chatMemberNameStubId: json['chatMemberNameStubId'] as String,
    key_id: json['key_id'] as String,
    public_key: json['public_key'] as String,
    name: json['name'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
    i18nNames: (json['i18nNames'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$ChatMemberNameStubToJson(ChatMemberNameStub instance) =>
    <String, dynamic>{
      'chatMemberNameStubId': instance.chatMemberNameStubId,
      'key_id': instance.key_id,
      'public_key': instance.public_key,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'i18nNames': instance.i18nNames,
    };
