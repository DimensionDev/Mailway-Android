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
