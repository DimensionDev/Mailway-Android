
import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatMemberNameStub.dart';
import 'package:mailwayui/data/entity/ChatMessage.dart';

part 'ChatWithChatMessagesWithChatMemberNameStubs.g.dart';


@JsonSerializable()
class ChatWithChatMessagesWithChatMemberNameStubs {
  Chat chat;
  List<ChatMessage> messages;
  List<ChatMemberNameStub> chatMemberNameStubs;


  ChatWithChatMessagesWithChatMemberNameStubs({
    this.chat,
    this.messages,
    this.chatMemberNameStubs,
  });

  factory ChatWithChatMessagesWithChatMemberNameStubs.fromJson(Map<String, dynamic> json) =>
      _$ChatWithChatMessagesWithChatMemberNameStubsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatWithChatMessagesWithChatMemberNameStubsToJson(this);
}

