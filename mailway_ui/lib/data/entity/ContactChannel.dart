import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Contact.dart';

part 'ContactChannel.g.dart';

@JsonSerializable()
class ContactChannel {
  String id;
  String name;
  String value;
  int created_at;
  int updated_at;
  String contactId;

  ContactChannel({
    this.id,
    this.name,
    this.value,
    this.created_at,
    this.updated_at,
    this.contactId,
  });

  factory ContactChannel.fromJson(Map<String, dynamic> json) =>
      _$ContactChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactChannelToJson(this);
}
