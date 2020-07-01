import 'dart:convert';

import 'package:flutter/services.dart';
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

}