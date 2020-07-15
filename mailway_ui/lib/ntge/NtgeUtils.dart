import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/ntge/entity/NtgeEd25519Keypair.dart';

class NtgeUtils {
  static final NtgeUtils _singleton = NtgeUtils._internal();

  factory NtgeUtils() {
    return _singleton;
  }

  NtgeUtils._internal();

  final _channel = const MethodChannel('com.dimension.mailwaycore/ntge');

  Future<NtgeEd25519Keypair> generateKeypair() async {
    final jsonData = await _channel.invokeMethod("keypair_generate");
    return NtgeEd25519Keypair.fromJson(json.decode(jsonData));
  }

  Future<String> encryptMessageWithExtra(
    Keypair sender,
    String message,
    List<String> recipient,
    String messageId,
  ) async {
    final String result = await _channel.invokeMethod(
      "mailway_message_encode",
      {
        'content': message,
        'recipient': jsonEncode(recipient.toList()),
        'sender': jsonEncode(sender.toJson()),
        'message_id': messageId,
      },
    );
    return result;
  }

  Future<bool> insertIdentityCard(String content) async {
    return await _channel.invokeMethod(
      'insert_identity_card',
      {
        'content': content,
      },
    );
  }

  Future<String> generateShareContact(String contactId) async {
    return await _channel.invokeMethod(
      'generate_share_contact',
      {
        'contactId': contactId,
      },
    );
  }

  Future<DecodeResult> decodeMessageWithExtra(String message) async {
    final String result = await _channel.invokeMethod(
      'mailway_message_decode',
      {
        'message': message,
      },
    );
    return DecodeResult.fromJson(json.decode(result));
    
  }
}
