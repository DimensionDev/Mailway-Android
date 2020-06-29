// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactWithChannels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactWithChannels _$ContactWithChannelsFromJson(Map<String, dynamic> json) {
  return ContactWithChannels(
    contact: json['contact'] == null
        ? null
        : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    channels: (json['channels'] as List)
        ?.map((e) => e == null
            ? null
            : ContactChannel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContactWithChannelsToJson(
        ContactWithChannels instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'channels': instance.channels,
    };
