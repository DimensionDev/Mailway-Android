import 'package:flutter/material.dart';
import 'package:mailwayui/data/database.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPair.dart';
import 'package:uuid/uuid.dart';

class AppData {
  List<ContactAndKeyPair> myKeys;

  AppData({
    this.myKeys,
  });
}

class AppDataState extends InheritedWidget {
  final AppData data;

  AppDataState({
    @required this.data,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDataState oldWidget) => true;

  static AppData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDataState>().data;
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
    commitData(_data);
  }

  Future createContactAndKeyPair(ContactAndKeyPair data) async {
    if (data.contact.id.isEmpty) {
      data.contact.id = Uuid().v4().toString();
    }
    if (data.keypair.contactId != data.contact.id) {
      data.keypair.contactId = data.contact.id;
    }
    await _database.insertContact(data.contact);
    await _database.insertKeypair(data.keypair);
    _data.myKeys = await _database.getContactsWithPrivateKey();
    commitData(_data);
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
