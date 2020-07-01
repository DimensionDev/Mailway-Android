import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';
import 'package:mailwayui/data/entity/Keypair.dart';

part 'ContactAndKeyPairWithContactChannels.g.dart';

@JsonSerializable()
class ContactAndKeyPairWithContactChannels {
  Contact contact;
  Keypair keypair;
  List<ContactChannel> channels;

  ContactAndKeyPairWithContactChannels({
    this.contact,
    this.keypair,
    this.channels,
  });

  factory ContactAndKeyPairWithContactChannels.fromJson(Map<String, dynamic> json) =>
      _$ContactAndKeyPairWithContactChannelsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactAndKeyPairWithContactChannelsToJson(this);
}
