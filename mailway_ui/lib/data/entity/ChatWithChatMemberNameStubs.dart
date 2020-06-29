import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatMemberNameStub.dart';

part 'ChatWithChatMemberNameStubs.g.dart';

@JsonSerializable()
class ChatWithChatMemberNameStubs {
  Chat chat;
  List<ChatMemberNameStub> chatMemberNameStubs;

  ChatWithChatMemberNameStubs({
    this.chat,
    this.chatMemberNameStubs,
  });

  factory ChatWithChatMemberNameStubs.fromJson(Map<String, dynamic> json) =>
      _$ChatWithChatMemberNameStubsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatWithChatMemberNameStubsToJson(this);
}
