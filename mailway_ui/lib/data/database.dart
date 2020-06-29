import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatMemberNameStub.dart';
import 'package:mailwayui/data/entity/ChatMemberNameStubWithChats.dart';
import 'package:mailwayui/data/entity/ChatMessage.dart';
import 'package:mailwayui/data/entity/ChatWithChatMemberNameStubs.dart';
import 'package:mailwayui/data/entity/ChatWithChatMessages.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPair.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';
import 'package:mailwayui/data/entity/ContactWithChannels.dart';
import 'package:mailwayui/data/entity/IdentityCard.dart';
import 'package:mailwayui/data/entity/Keypair.dart';

class AppDatabase {
  final databaseChannel =
      const MethodChannel('com.dimension.mailwaycore/database');

  Future<List<ContactAndKeyPair>> getContactsWithPrivateKey() async {
    final jsonData = await databaseChannel.invokeMethod("getContactsWithPrivateKey");
    return (json.decode(jsonData) as List).map((e) => ContactAndKeyPair.fromJson(e));
  }

  Future<List<Chat>> getChats() async {
    final jsonData =
        await databaseChannel.invokeMethod("query", {"table": "Chats"});
    return (json.decode(jsonData) as List).map((e) => Chat.fromJson(e));
  }

  Future<List<ChatWithChatMemberNameStubs>>
      getChatsWithChatMemberNameStubs() async {
    final jsonData = await databaseChannel
        .invokeMethod("query", {"table": "ChatWithChatMemberNameStubs"});
    return (json.decode(jsonData) as List)
        .map((e) => ChatWithChatMemberNameStubs.fromJson(e));
  }

  Future<List<ChatWithChatMessages>> getChatWithChatMessages() async {
    final jsonData = await databaseChannel
        .invokeMethod("query", {"table": "ChatWithChatMessages"});
    return (json.decode(jsonData) as List)
        .map((e) => ChatWithChatMessages.fromJson(e));
  }

  Future<List<ChatMemberNameStubWithChats>>
      getChatMemberNameStubWithChats() async {
    final jsonData = await databaseChannel
        .invokeMethod("query", {"table": "ChatMemberNameStubWithChats"});
    return (json.decode(jsonData) as List)
        .map((e) => ChatMemberNameStubWithChats.fromJson(e));
  }

  Future<List<Contact>> getContacts() async {
    final jsonData =
        await databaseChannel.invokeMethod("query", {"table": "Contact"});
    return (json.decode(jsonData) as List).map((e) => Contact.fromJson(e));
  }

  Future<List<ContactAndKeyPair>> getContactsAndKeyPairs() async {
    final jsonData = await databaseChannel
        .invokeMethod("query", {"table": "ContactAndKeyPair"});
    return (json.decode(jsonData) as List)
        .map((e) => ContactAndKeyPair.fromJson(e));
  }

  Future<List<ContactWithChannels>> getContactsWithChannels() async {
    final jsonData = await databaseChannel
        .invokeMethod("query", {"table": "ContactWithChannels"});
    return (json.decode(jsonData) as List)
        .map((e) => ContactWithChannels.fromJson(e));
  }

  Future<List<IdentityCard>> getIdentityCard() async {
    final jsonData = await databaseChannel
        .invokeMethod("query", {"table": "IdentityCard"});
    return (json.decode(jsonData) as List)
        .map((e) => IdentityCard.fromJson(e));
  }

  Future insertChat(Chat data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "Chats", "data": json.encode(data.toJson())});
  }

  Future insertChatMemberNameStub(ChatMemberNameStub data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "ChatMemberNameStub", "data": json.encode(data.toJson())});
  }

  Future insertChatMessage(ChatMessage data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "ChatMessage", "data": json.encode(data.toJson())});
  }

  Future insertContact(Contact data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "Contact", "data": json.encode(data.toJson())});
  }

  Future insertKeypair(Keypair data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "Keypair", "data": json.encode(data.toJson())});
  }

  Future insertContactChannel(ContactChannel data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "ContactChannel", "data": json.encode(data.toJson())});
  }

  Future insertIdentityCard(IdentityCard data) async {
    await databaseChannel.invokeMethod(
        "insert", {"table": "IdentityCard", "data": json.encode(data.toJson())});
  }


  Future updateChat(Chat data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "Chats", "data": json.encode(data.toJson())});
  }

  Future updateChatMemberNameStub(ChatMemberNameStub data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "ChatMemberNameStub", "data": json.encode(data.toJson())});
  }

  Future updateChatMessage(ChatMessage data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "ChatMessage", "data": json.encode(data.toJson())});
  }

  Future updateContact(Contact data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "Contact", "data": json.encode(data.toJson())});
  }

  Future updateKeypair(Keypair data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "Keypair", "data": json.encode(data.toJson())});
  }

  Future updateContactChannel(ContactChannel data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "ContactChannel", "data": json.encode(data.toJson())});
  }

  Future updateIdentityCard(IdentityCard data) async {
    await databaseChannel.invokeMethod(
        "update", {"table": "IdentityCard", "data": json.encode(data.toJson())});
  }


  Future deleteChat(Chat data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "Chats", "data": json.encode(data.toJson())});
  }

  Future deleteChatMemberNameStub(ChatMemberNameStub data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "ChatMemberNameStub", "data": json.encode(data.toJson())});
  }

  Future deleteChatMessage(ChatMessage data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "ChatMessage", "data": json.encode(data.toJson())});
  }

  Future deleteContact(Contact data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "Contact", "data": json.encode(data.toJson())});
  }

  Future deleteKeypair(Keypair data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "Keypair", "data": json.encode(data.toJson())});
  }

  Future deleteContactChannel(ContactChannel data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "ContactChannel", "data": json.encode(data.toJson())});
  }

  Future deleteIdentityCard(IdentityCard data) async {
    await databaseChannel.invokeMethod(
        "delete", {"table": "IdentityCard", "data": json.encode(data.toJson())});
  }
}
