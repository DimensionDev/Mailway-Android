// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    id: json['id'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
    message_timestamp: json['message_timestamp'] as int,
    compose_timestamp: json['compose_timestamp'] as int,
    receive_timestamp: json['receive_timestamp'] as int,
    share_timestamp: json['share_timestamp'] as int,
    sender_public_key: json['sender_public_key'] as String,
    recipient_public_keys: (json['recipient_public_keys'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    armored_message: json['armored_message'] as String,
    payload: json['payload'] as String,
    payload_kind:
        _$enumDecodeNullable(_$PayloadKindEnumMap, json['payload_kind']),
    version: json['version'] as int,
    chatId: json['chatId'] as String,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'message_timestamp': instance.message_timestamp,
      'compose_timestamp': instance.compose_timestamp,
      'receive_timestamp': instance.receive_timestamp,
      'share_timestamp': instance.share_timestamp,
      'sender_public_key': instance.sender_public_key,
      'recipient_public_keys': instance.recipient_public_keys,
      'armored_message': instance.armored_message,
      'payload': instance.payload,
      'payload_kind': _$PayloadKindEnumMap[instance.payload_kind],
      'version': instance.version,
      'chatId': instance.chatId,
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
