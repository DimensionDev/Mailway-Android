import 'package:json_annotation/json_annotation.dart';

part 'ChatAndChatMemberNameStubCrossRef.g.dart';

@JsonSerializable()
class ChatAndChatMemberNameStubCrossRef {
  String chatId;
  String chatMemberNameStubId;

  ChatAndChatMemberNameStubCrossRef({
    this.chatId,
    this.chatMemberNameStubId,
  });

  
  factory ChatAndChatMemberNameStubCrossRef.fromJson(Map<String, dynamic> json) =>
      _$ChatAndChatMemberNameStubCrossRefFromJson(json);

  Map<String, dynamic> toJson() => _$ChatAndChatMemberNameStubCrossRefToJson(this);
}
