// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMessageAndQuoteMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageAndQuoteMessage _$ChatMessageAndQuoteMessageFromJson(
    Map<String, dynamic> json) {
  return ChatMessageAndQuoteMessage(
    chatMessage: json['chatMessage'] == null
        ? null
        : ChatMessage.fromJson(json['chatMessage'] as Map<String, dynamic>),
    quoteMessage: json['quoteMessage'] == null
        ? null
        : QuoteMessage.fromJson(json['quoteMessage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatMessageAndQuoteMessageToJson(
        ChatMessageAndQuoteMessage instance) =>
    <String, dynamic>{
      'chatMessage': instance.chatMessage,
      'quoteMessage': instance.quoteMessage,
    };
