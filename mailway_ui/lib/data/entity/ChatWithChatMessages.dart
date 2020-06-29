import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatMessage.dart';

part 'ChatWithChatMessages.g.dart';

@JsonSerializable()
class ChatWithChatMessages {
  Chat chat;
  List<ChatMessage> messages;

  ChatWithChatMessages({
    this.chat,
    this.messages,
  });

  factory ChatWithChatMessages.fromJson(Map<String, dynamic> json) =>
      _$ChatWithChatMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$ChatWithChatMessagesToJson(this);
}
