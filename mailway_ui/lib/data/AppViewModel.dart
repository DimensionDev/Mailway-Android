import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/data/database.dart';
import 'package:mailwayui/data/entity/Chat.dart';
import 'package:mailwayui/data/entity/ChatAndChatMemberNameStubCrossRef.dart';
import 'package:mailwayui/data/entity/ChatMemberNameStub.dart';
import 'package:mailwayui/data/entity/ChatMessage.dart';
import 'package:mailwayui/data/entity/ChatWithChatMessagesWithChatMemberNameStubs.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPair.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPairWithContactChannels.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/data/entity/PayloadKind.dart';
import 'package:mailwayui/data/entity/QuoteMessage.dart';
import 'package:mailwayui/ntge/NtgeUtils.dart';
import 'package:mailwayui/ntge/entity/NtgeEd25519Keypair.dart';
import 'package:mailwayui/scene/ModifyContact.dart';
import 'package:uuid/uuid.dart';

class AppData {
  List<ContactAndKeyPairWithContactChannels> myKeys;
  List<ContactAndKeyPair> contacts;
  List<ChatWithChatMessagesWithChatMemberNameStubs> chats;

  AppData({
    @required this.myKeys,
    @required this.contacts,
    @required this.chats,
  });

  static AppData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDataState>().data;
}

class AppDataState extends InheritedWidget {
  final AppData data;

  AppDataState({
    @required this.data,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDataState oldWidget) => true;
}

class AppViewModel {
  static AppViewModel of(BuildContext context) {
    _AppStateManagerState state =
        context.findAncestorStateOfType<_AppStateManagerState>();
    return state?.state;
  }

  final _AppStateManagerState _parent;
  final AppDatabase _database;

  AppData get _data => _parent.data;

  AppViewModel._(this._parent) : _database = AppDatabase();

  void commitData(AppData data) {
    _parent.setData(data);
  }

  Future initialization() async {
    _data.myKeys = await _database.getContactsWithPrivateKey();
    _data.contacts = await _database.getContactsWithoutPrivateKey();
    _data.chats =
        await _database.getChatWithChatMessagesWithChatMemberNameStubs();
    commitData(_data);
  }

  Future createContact(
    Contact contact,
    List<ContactChannel> channels,
    Keypair keypair,
  ) async {
    if (contact.id.isEmpty) {
      contact.id = Uuid().v4().toString();
    }
    if (keypair.contactId != contact.id) {
      keypair.contactId = contact.id;
    }
    if (keypair.id.isEmpty) {
      keypair.id = Uuid().v4().toString();
    }
    channels.forEach((channel) {
      if (channel.contactId != contact.id) {
        channel.contactId = contact.id;
      }
      if (channel.id.isEmpty) {
        channel.id = Uuid().v4().toString();
      }
    });
    await _database.insertContact(contact);
    await _database.insertKeypair(keypair);
    for (final channel in channels) {
      await _database.insertContactChannel(channel);
    }
    _data.myKeys = await _database.getContactsWithPrivateKey();
    commitData(_data);
  }

  Future generateNewIdentity(
    String name,
    String color,
    List<ContactAdditionData> additionData,
  ) async {
    final contactId = Uuid().v4().toString();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final contact = Contact(
      id: contactId,
      color: color,
      name: name,
      created_at: timestamp,
      updated_at: timestamp,
    );
    final ed25519Keypair = await NtgeUtils().generateKeypair();
    final keypair = Keypair(
      id: Uuid().v4().toString(),
      created_at: timestamp,
      updated_at: timestamp,
      contactId: contactId,
      key_id: ed25519Keypair.keyId,
      public_key: ed25519Keypair.publicKey,
      private_key: ed25519Keypair.privateKey,
    );
    final channels = additionData
        .where((element) => element.value != null && element.value.isNotEmpty)
        .map(
          (e) => ContactChannel(
            id: Uuid().v4().toString(),
            name: e.type,
            value: e.value,
            created_at: timestamp,
            updated_at: timestamp,
          ),
        )
        .toList();
    await createContact(contact, channels, keypair);
  }

  Future updateContact(
    Contact contact,
    List<ContactChannel> channels,
    String name,
    List<ContactAdditionData> additionData,
  ) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    for (final channel in channels) {
      await _database.deleteContactChannel(channel);
    }

    final newChannels = additionData
        .where((element) => element.value != null && element.value.isNotEmpty)
        .map(
          (e) => ContactChannel(
            id: Uuid().v4().toString(),
            name: e.type,
            value: e.value,
            created_at: timestamp,
            updated_at: timestamp,
            contactId: contact.id,
          ),
        )
        .toList();
    for (final channel in newChannels) {
      await _database.insertContactChannel(channel);
    }

    await _database.updateContact(contact);

    _data.myKeys = await _database.getContactsWithPrivateKey();
    commitData(_data);
  }

  Future removeContact(Contact contact) async {}

  Future<ContactAndKeyPairWithContactChannels> getContactInfo(
    Contact item,
  ) async {
    return await _database.queryContact(item.id);
  }

  Future newChat(
    Keypair sender,
    String text,
    List<String> selectedContact,
  ) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final messageId = Uuid().v4().toString();
    final armorMessage = await NtgeUtils().encryptMessageWithExtra(
      sender,
      text,
      selectedContact,
      messageId,
    );
    await insertOrCreateChat(selectedContact, sender.public_key, sender.public_key, timestamp,
        text, armorMessage, messageId);
  }

  Future insertOrCreateChat(
    List<String> selectedContact,
    String senderPublicKey,
    String messageSenderKey,
    int timestamp,
    String text,
    String armorMessage,
    String messageId, {
    MailwayExtraQuoteMessage quoteMessage,
  }) async {
    final existsChat = await _database.getChatMessageByMessageId(messageId);
    if (existsChat != null) {
      return;
    }

    final selectedContactsWithKeys = await _database.getContactsAndKeyPairsIn(
        (selectedContact..add(senderPublicKey)).toList());
    final chatMembers = await _database.getChatMemberNameStubsIn(
        selectedContactsWithKeys.map((e) => e.keypair.key_id).toList());
    final newMembers = selectedContactsWithKeys
        .where((element) =>
            !chatMembers.any((m) => m.key_id == element.keypair.key_id))
        .map((e) => ChatMemberNameStub(
              chatMemberNameStubId: Uuid().v4().toString(),
              key_id: e.keypair.key_id,
              public_key: e.keypair.public_key,
              name: e.contact.name,
              updated_at: timestamp,
              created_at: timestamp,
              i18nNames: e.contact.i18nNames,
            ))
        .toList();
    for (var value in newMembers) {
      await _database.insertChatMemberNameStub(value);
    }
    final totalChatMembers = chatMembers + newMembers;
    final allChatWithStubs = await _database.getChatsWithChatMemberNameStubs();
    Function deepEq = const DeepCollectionEquality.unordered().equals;
    final currentChatWithStubs = allChatWithStubs.firstWhere(
      (element) =>
          element.chat.identity_public_key == senderPublicKey &&
          deepEq(
            element.chatMemberNameStubs.map((e) => e.key_id).toList(),
            selectedContactsWithKeys.map((e) => e.keypair.key_id).toList(),
          ),
      orElse: () => null,
    );
    var currentChat = currentChatWithStubs?.chat;
    if (currentChat == null) {
      currentChat = Chat(
        chatId: Uuid().v4().toString(),
        title: "",
        identity_public_key: senderPublicKey,
        created_at: timestamp,
        updated_at: timestamp,
      );
      await _database.insertChat(currentChat);
      final crossref = totalChatMembers.map((e) =>
          ChatAndChatMemberNameStubCrossRef(
              chatId: currentChat.chatId,
              chatMemberNameStubId: e.chatMemberNameStubId));
      for (var value in crossref) {
        await _database.insertChatAndChatMemberNameStubCrossRef(value);
      }
    }
    if (quoteMessage != null) {
      final dbQuoteMessage = QuoteMessage(
        id: Uuid().v4().toString(),
        message_id: quoteMessage.id,
        created_at: timestamp,
        updated_at: timestamp,
        chatMessageId: currentChat.chatId,
        digest: quoteMessage.digest,
        digest_description: quoteMessage.digest_description,
        digest_kind: quoteMessage.digest_kind,
        sender_public_key: quoteMessage.sender_public_key,
        sender_name: quoteMessage.sender_name,
      );
      await _database.insertQuoteMessage(dbQuoteMessage);
    }
    final chatMessage = ChatMessage(
      id: Uuid().v4().toString(),
      created_at: timestamp,
      updated_at: timestamp,
      message_timestamp: timestamp,
      compose_timestamp: timestamp,
      receive_timestamp: timestamp,
      share_timestamp: null,
      sender_public_key: messageSenderKey,
      recipient_public_keys:
          selectedContactsWithKeys.map((e) => e.keypair.public_key).toList(),
      payload_kind: PayloadKind.plaintext,
      payload: text,
      version: 1,
      chatId: currentChat.chatId,
      quote_message_id: quoteMessage?.id,
      armored_message: armorMessage,
      message_id: messageId,
    );
    await _database.insertChatMessage(chatMessage);
    _data.chats =
        await _database.getChatWithChatMessagesWithChatMemberNameStubs();
    commitData(_data);
  }

  Future insertIdentityCard(String identityCardContent) async {
    final result = await NtgeUtils().insertIdentityCard(identityCardContent);
    if (result) {
      _data.contacts = await _database.getContactsWithoutPrivateKey();
      commitData(_data);
    }
  }

  Future<DecodeResult> decrypt(String text) async {
    return await NtgeUtils().decodeMessageWithExtra(text);
  }
}

class AppStateManager extends StatefulWidget {
  final Widget child;

  const AppStateManager({Key key, this.child}) : super(key: key);

  @override
  _AppStateManagerState createState() => _AppStateManagerState();
}

class _AppStateManagerState extends State<AppStateManager> {
  AppData data;

  void setData(AppData value) {
    setState(() {
      data = value;
    });
  }

  AppViewModel get state => AppViewModel._(this);

  @override
  void initState() {
    super.initState();
    data = AppData(
      myKeys: [],
      contacts: [],
      chats: [],
    );
    state.initialization();
  }

  @override
  Widget build(BuildContext context) {
    return AppDataState(
      data: data,
      child: widget.child,
    );
  }
}
