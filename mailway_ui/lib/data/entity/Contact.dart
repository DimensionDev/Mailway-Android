import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatMessage.dart';

part 'Contact.g.dart';

@JsonSerializable()
class Contact {
  String id;
  String name;
  String avatar;
  String note;
  String color;
  int created_at;
  int updated_at;
  Map<String, String> i18nNames;

  Contact({
    this.id,
    this.name,
    this.avatar,
    this.note,
    this.color,
    this.created_at,
    this.updated_at,
    this.i18nNames,
  });
  
  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
