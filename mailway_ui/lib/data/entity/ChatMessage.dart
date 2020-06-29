import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/PayloadKind.dart';

part 'ChatMessage.g.dart';

@JsonSerializable()
class ChatMessage {
  String id;
  int created_at;
  int updated_at;
  int message_timestamp;
  int compose_timestamp;
  int receive_timestamp;
  int share_timestamp;
  String sender_public_key;
  List<String> recipient_public_keys;
  String armored_message;
  String payload;
  PayloadKind payload_kind;
  int version;
  String chatId;

  ChatMessage({
    this.id,
    this.created_at,
    this.updated_at,
    this.message_timestamp,
    this.compose_timestamp,
    this.receive_timestamp,
    this.share_timestamp,
    this.sender_public_key,
    this.recipient_public_keys,
    this.armored_message,
    this.payload,
    this.payload_kind,
    this.version,
    this.chatId,
  });
  
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
