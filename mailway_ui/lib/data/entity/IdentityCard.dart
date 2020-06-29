import 'package:json_annotation/json_annotation.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';

part 'IdentityCard.g.dart';

@JsonSerializable()
class IdentityCard {
  String id;
  String identityCard;

  IdentityCard({
    this.id,
    this.identityCard,
  });

  factory IdentityCard.fromJson(Map<String, dynamic> json) =>
      _$IdentityCardFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityCardToJson(this);
}
