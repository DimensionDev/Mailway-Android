import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/Keypair.dart';

part 'ContactAndKeyPair.g.dart';

@JsonSerializable()
class ContactAndKeyPair {
  Contact contact;
  Keypair keypair;

  ContactAndKeyPair({
    this.contact,
    this.keypair,
  });

  factory ContactAndKeyPair.fromJson(Map<String, dynamic> json) =>
      _$ContactAndKeyPairFromJson(json);

  Map<String, dynamic> toJson() => _$ContactAndKeyPairToJson(this);
}

