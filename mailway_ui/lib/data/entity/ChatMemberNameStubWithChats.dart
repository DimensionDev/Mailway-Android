import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatMemberNameStub.dart';

part 'ChatMemberNameStubWithChats.g.dart';

@JsonSerializable()
class ChatMemberNameStubWithChats {
  ChatMemberNameStub chatMemberNameStub;
  List<Chat> chats;

  ChatMemberNameStubWithChats({
    this.chatMemberNameStub,
    this.chats,
  });
  
  factory ChatMemberNameStubWithChats.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberNameStubWithChatsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMemberNameStubWithChatsToJson(this);
}
