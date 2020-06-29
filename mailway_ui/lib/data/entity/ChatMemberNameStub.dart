import 'package:json_annotation/json_annotation.dart';

part 'ChatMemberNameStub.g.dart';

@JsonSerializable()
class ChatMemberNameStub {
  String chatMemberNameStubId;
  String key_id;
  String public_key;
  String name;
  int created_at;
  int updated_at;
  Map<String, String> i18nNames;

  ChatMemberNameStub({
    this.chatMemberNameStubId,
    this.key_id,
    this.public_key,
    this.name,
    this.created_at,
    this.updated_at,
    this.i18nNames,
  });
  
  factory ChatMemberNameStub.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberNameStubFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMemberNameStubToJson(this);
}
