import 'package:flutter/material.dart';
import 'package:mailwayui/data/database.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPair.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPairWithContactChannels.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';
import 'package:mailwayui/data/entity/ContactWithChannels.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/ntge/NtgeUtils.dart';
import 'package:mailwayui/scene/ModifyContact.dart';
import 'package:uuid/uuid.dart';

class AppData {
  List<ContactAndKeyPairWithContactChannels> myKeys;
  List<Contact> contacts;

  AppData({@required this.myKeys, @required this.contacts});

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
    _data.contacts = _data.myKeys.map((e) => e.contact).toList();
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
