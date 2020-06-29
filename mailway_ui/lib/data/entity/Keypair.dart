import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';

part 'Keypair.g.dart';

@JsonSerializable()
class Keypair {
  String id;
  String key_id;
  String private_key;
  String public_key;
  int created_at;
  int updated_at;
  String contactId;

  Keypair({
    this.id,
    this.key_id,
    this.private_key,
    this.public_key,
    this.created_at,
    this.updated_at,
    this.contactId,
  });

  factory Keypair.fromJson(Map<String, dynamic> json) =>
      _$KeypairFromJson(json);

  Map<String, dynamic> toJson() => _$KeypairToJson(this);
}
