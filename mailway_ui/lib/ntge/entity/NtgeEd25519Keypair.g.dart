// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NtgeEd25519Keypair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NtgeEd25519Keypair _$NtgeEd25519KeypairFromJson(Map<String, dynamic> json) {
  return NtgeEd25519Keypair(
    keyId: json['keyId'] as String,
    publicKey: json['publicKey'] as String,
    privateKey: json['privateKey'] as String,
  );
}

Map<String, dynamic> _$NtgeEd25519KeypairToJson(NtgeEd25519Keypair instance) =>
    <String, dynamic>{
      'keyId': instance.keyId,
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
    };

DecodeResult _$DecodeResultFromJson(Map<String, dynamic> json) {
  return DecodeResult(
    message: json['message'] as String,
    extra: json['extra'] == null
        ? null
        : MailwayMessageExtra.fromJson(json['extra'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DecodeResultToJson(DecodeResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'extra': instance.extra,
    };

MailwayMessageExtra _$MailwayMessageExtraFromJson(Map<String, dynamic> json) {
  return MailwayMessageExtra(
    version: json['version'] as int,
    sender_key: json['sender_key'] as String,
    recipient_keys:
        (json['recipient_keys'] as List)?.map((e) => e as String)?.toList(),
    message_id: json['message_id'] as String,
    quote_message: json['quote_message'] == null
        ? null
        : MailwayExtraQuoteMessage.fromJson(
            json['quote_message'] as Map<String, dynamic>),
    payload_kind:
        _$enumDecodeNullable(_$PayloadKindEnumMap, json['payload_kind']),
  );
}

Map<String, dynamic> _$MailwayMessageExtraToJson(
        MailwayMessageExtra instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender_key': instance.sender_key,
      'recipient_keys': instance.recipient_keys,
      'message_id': instance.message_id,
      'quote_message': instance.quote_message,
      'payload_kind': _$PayloadKindEnumMap[instance.payload_kind],
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

MailwayExtraQuoteMessage _$MailwayExtraQuoteMessageFromJson(
    Map<String, dynamic> json) {
  return MailwayExtraQuoteMessage(
    id: json['id'] as String,
    digest: json['digest'] as String,
    digest_kind:
        _$enumDecodeNullable(_$PayloadKindEnumMap, json['digest_kind']),
    digest_description: json['digest_description'] as String,
    sender_name: json['sender_name'] as String,
    sender_public_key: json['sender_public_key'] as String,
  );
}

Map<String, dynamic> _$MailwayExtraQuoteMessageToJson(
        MailwayExtraQuoteMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'digest': instance.digest,
      'digest_kind': _$PayloadKindEnumMap[instance.digest_kind],
      'digest_description': instance.digest_description,
      'sender_name': instance.sender_name,
      'sender_public_key': instance.sender_public_key,
    };
