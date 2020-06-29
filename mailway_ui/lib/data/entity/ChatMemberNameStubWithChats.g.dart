// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMemberNameStubWithChats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMemberNameStubWithChats _$ChatMemberNameStubWithChatsFromJson(
    Map<String, dynamic> json) {
  return ChatMemberNameStubWithChats(
    chatMemberNameStub: json['chatMemberNameStub'] == null
        ? null
        : ChatMemberNameStub.fromJson(
            json['chatMemberNameStub'] as Map<String, dynamic>),
    chats: (json['chats'] as List)
        ?.map(
            (e) => e == null ? null : Chat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatMemberNameStubWithChatsToJson(
        ChatMemberNameStubWithChats instance) =>
    <String, dynamic>{
      'chatMemberNameStub': instance.chatMemberNameStub,
      'chats': instance.chats,
    };
