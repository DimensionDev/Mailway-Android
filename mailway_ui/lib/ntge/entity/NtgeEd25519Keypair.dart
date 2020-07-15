import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/PayloadKind.dart';

part 'NtgeEd25519Keypair.g.dart';

@JsonSerializable()
class NtgeEd25519Keypair {
  final String keyId;
  final String publicKey;
  final String privateKey;

  NtgeEd25519Keypair({
    this.keyId,
    this.publicKey,
    this.privateKey,
  });

  factory NtgeEd25519Keypair.fromJson(Map<String, dynamic> json) =>
      _$NtgeEd25519KeypairFromJson(json);

  Map<String, dynamic> toJson() => _$NtgeEd25519KeypairToJson(this);
}

@JsonSerializable()
class DecodeResult {
  final String message;
  final MailwayMessageExtra extra;

  DecodeResult({
    this.message,
    this.extra,
  });

  factory DecodeResult.fromJson(Map<String, dynamic> json) =>
      _$DecodeResultFromJson(json);

  Map<String, dynamic> toJson() => _$DecodeResultToJson(this);
}

@JsonSerializable()
class MailwayMessageExtra {
  final int version;
  final String sender_key;
  final List<String> recipient_keys;
  final String message_id;
  final MailwayExtraQuoteMessage quote_message;
  final PayloadKind payload_kind;

  MailwayMessageExtra({
    this.version,
    this.sender_key,
    this.recipient_keys,
    this.message_id,
    this.quote_message,
    this.payload_kind,
  });

  factory MailwayMessageExtra.fromJson(Map<String, dynamic> json) =>
      _$MailwayMessageExtraFromJson(json);

  Map<String, dynamic> toJson() => _$MailwayMessageExtraToJson(this);
}

@JsonSerializable()
class MailwayExtraQuoteMessage {
  final String id;
  final String digest;
  final PayloadKind digest_kind;
  final String digest_description;
  final String sender_name;
  final String sender_public_key;

  MailwayExtraQuoteMessage({
    this.id,
    this.digest,
    this.digest_kind,
    this.digest_description,
    this.sender_name,
    this.sender_public_key,
  });

  factory MailwayExtraQuoteMessage.fromJson(Map<String, dynamic> json) =>
      _$MailwayExtraQuoteMessageFromJson(json);

  Map<String, dynamic> toJson() => _$MailwayExtraQuoteMessageToJson(this);
}
