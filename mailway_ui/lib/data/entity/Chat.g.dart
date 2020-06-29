// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    chatId: json['chatId'] as String,
    title: json['title'] as String,
    identity_public_key: json['identity_public_key'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'title': instance.title,
      'identity_public_key': instance.identity_public_key,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
