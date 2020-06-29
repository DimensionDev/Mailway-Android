// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Keypair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keypair _$KeypairFromJson(Map<String, dynamic> json) {
  return Keypair(
    id: json['id'] as String,
    key_id: json['key_id'] as String,
    private_key: json['private_key'] as String,
    public_key: json['public_key'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int,
    contactId: json['contactId'] as String,
  );
}

Map<String, dynamic> _$KeypairToJson(Keypair instance) => <String, dynamic>{
      'id': instance.id,
      'key_id': instance.key_id,
      'private_key': instance.private_key,
      'public_key': instance.public_key,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'contactId': instance.contactId,
    };
