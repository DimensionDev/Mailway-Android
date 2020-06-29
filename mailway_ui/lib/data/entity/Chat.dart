import 'package:json_annotation/json_annotation.dart';

part 'Chat.g.dart';

@JsonSerializable()
class Chat {
  String chatId;
  String title;
  String identity_public_key;
  int created_at;
  int updated_at;

  Chat({
    this.chatId,
    this.title,
    this.identity_public_key,
    this.created_at,
    this.updated_at,
  });

  
  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
