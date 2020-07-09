// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuoteMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteMessage _$QuoteMessageFromJson(Map<String, dynamic> json) {
  return QuoteMessage(
    id: json['id'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
    chatMessageId: json['chatMessageId'] as String,
    message_id: json['message_id'] as String,
    digest: json['digest'] as String,
    digest_kind:
        _$enumDecodeNullable(_$PayloadKindEnumMap, json['digest_kind']),
    digest_description: json['digest_description'] as String,
    sender_name: json['sender_name'] as String,
    sender_public_key: json['sender_public_key'] as String,
    chat_message_id: json['chat_message_id'] as String,
  );
}

Map<String, dynamic> _$QuoteMessageToJson(QuoteMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'chatMessageId': instance.chatMessageId,
      'message_id': instance.message_id,
      'digest': instance.digest,
      'digest_kind': _$PayloadKindEnumMap[instance.digest_kind],
      'digest_description': instance.digest_description,
      'sender_name': instance.sender_name,
      'sender_public_key': instance.sender_public_key,
      'chat_message_id': instance.chat_message_id,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PayloadKindEnumMap = {
  PayloadKind.plaintext: 'plaintext',
  PayloadKind.image: 'image',
  PayloadKind.video: 'video',
  PayloadKind.audio: 'audio',
  PayloadKind.other: 'other',
};
