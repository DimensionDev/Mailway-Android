import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/PayloadKind.dart';

part 'QuoteMessage.g.dart';

@JsonSerializable()
class QuoteMessage {
  final String id;
  final int created_at;
  final int updated_at;
  final String chatMessageId;
  final String message_id;
  final String digest;
  final PayloadKind digest_kind;
  final String digest_description;
  final String sender_name;
  final String sender_public_key;
  final String chat_message_id;

  QuoteMessage({
    this.id,
    this.created_at,
    this.updated_at,
    this.chatMessageId,
    this.message_id,
    this.digest,
    this.digest_kind,
    this.digest_description,
    this.sender_name,
    this.sender_public_key,
    this.chat_message_id,
  });


  factory QuoteMessage.fromJson(Map<String, dynamic> json) =>
      _$QuoteMessageFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteMessageToJson(this);
}
