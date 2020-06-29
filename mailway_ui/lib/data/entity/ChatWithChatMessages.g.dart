// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatWithChatMessages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatWithChatMessages _$ChatWithChatMessagesFromJson(Map<String, dynamic> json) {
  return ChatWithChatMessages(
    chat: json['chat'] == null
        ? null
        : Chat.fromJson(json['chat'] as Map<String, dynamic>),
    messages: (json['messages'] as List)
        ?.map((e) =>
            e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatWithChatMessagesToJson(
        ChatWithChatMessages instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'messages': instance.messages,
    };
