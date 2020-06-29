// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatWithChatMemberNameStubs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatWithChatMemberNameStubs _$ChatWithChatMemberNameStubsFromJson(
    Map<String, dynamic> json) {
  return ChatWithChatMemberNameStubs(
    chat: json['chat'] == null
        ? null
        : Chat.fromJson(json['chat'] as Map<String, dynamic>),
    chatMemberNameStubs: (json['chatMemberNameStubs'] as List)
        ?.map((e) => e == null
            ? null
            : ChatMemberNameStub.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatWithChatMemberNameStubsToJson(
        ChatWithChatMemberNameStubs instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'chatMemberNameStubs': instance.chatMemberNameStubs,
    };
