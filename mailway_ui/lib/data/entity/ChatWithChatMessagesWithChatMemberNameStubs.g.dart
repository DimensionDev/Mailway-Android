// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatWithChatMessagesWithChatMemberNameStubs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatWithChatMessagesWithChatMemberNameStubs
    _$ChatWithChatMessagesWithChatMemberNameStubsFromJson(
        Map<String, dynamic> json) {
  return ChatWithChatMessagesWithChatMemberNameStubs(
    chat: json['chat'] == null
        ? null
        : Chat.fromJson(json['chat'] as Map<String, dynamic>),
    messages: (json['messages'] as List)
        ?.map((e) => e == null
            ? null
            : ChatMessageAndQuoteMessage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    chatMemberNameStubs: (json['chatMemberNameStubs'] as List)
        ?.map((e) => e == null
            ? null
            : ChatMemberNameStub.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatWithChatMessagesWithChatMemberNameStubsToJson(
        ChatWithChatMessagesWithChatMemberNameStubs instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'messages': instance.messages,
      'chatMemberNameStubs': instance.chatMemberNameStubs,
    };
