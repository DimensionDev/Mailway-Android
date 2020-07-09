import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/ChatMessage.dart';
import 'package:mailwayui/data/entity/QuoteMessage.dart';

part 'ChatMessageAndQuoteMessage.g.dart';

@JsonSerializable()
class ChatMessageAndQuoteMessage {
  ChatMessage chatMessage;
  QuoteMessage quoteMessage;

  ChatMessageAndQuoteMessage({
    this.chatMessage,
    this.quoteMessage,
  });

  factory ChatMessageAndQuoteMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageAndQuoteMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageAndQuoteMessageToJson(this);
}
