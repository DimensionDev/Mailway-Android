import 'package:json_annotation/json_annotation.dart';

part 'NtgeEd25519Keypair.g.dart';

@JsonSerializable()
class NtgeEd25519Keypair {
  final String keyId;
  final String publicKey;
  final String privateKey;

  NtgeEd25519Keypair({
    this.keyId,
    this.publicKey,
    this.privateKey,
  });


  factory NtgeEd25519Keypair.fromJson(Map<String, dynamic> json) =>
      _$NtgeEd25519KeypairFromJson(json);

  Map<String, dynamic> toJson() => _$NtgeEd25519KeypairToJson(this);
}
