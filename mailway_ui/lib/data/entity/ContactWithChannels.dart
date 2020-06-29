import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';

part 'ContactWithChannels.g.dart';

@JsonSerializable()
class ContactWithChannels {
  Contact contact;
  List<ContactChannel> channels;

  ContactWithChannels({
    this.contact,
    this.channels,
  });

  factory ContactWithChannels.fromJson(Map<String, dynamic> json) =>
      _$ContactWithChannelsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactWithChannelsToJson(this);
}
