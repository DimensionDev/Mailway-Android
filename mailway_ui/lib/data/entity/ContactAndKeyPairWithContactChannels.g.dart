// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactAndKeyPairWithContactChannels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactAndKeyPairWithContactChannels
    _$ContactAndKeyPairWithContactChannelsFromJson(Map<String, dynamic> json) {
  return ContactAndKeyPairWithContactChannels(
    contact: json['contact'] == null
        ? null
        : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    keypair: json['keypair'] == null
        ? null
        : Keypair.fromJson(json['keypair'] as Map<String, dynamic>),
    channels: (json['channels'] as List)
        ?.map((e) => e == null
            ? null
            : ContactChannel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContactAndKeyPairWithContactChannelsToJson(
        ContactAndKeyPairWithContactChannels instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'keypair': instance.keypair,
      'channels': instance.channels,
    };
