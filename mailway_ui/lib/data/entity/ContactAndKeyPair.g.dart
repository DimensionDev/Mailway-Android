// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactAndKeyPair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactAndKeyPair _$ContactAndKeyPairFromJson(Map<String, dynamic> json) {
  return ContactAndKeyPair(
    contact: json['contact'] == null
        ? null
        : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    keypair: json['keypair'] == null
        ? null
        : Keypair.fromJson(json['keypair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContactAndKeyPairToJson(ContactAndKeyPair instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'keypair': instance.keypair,
    };
