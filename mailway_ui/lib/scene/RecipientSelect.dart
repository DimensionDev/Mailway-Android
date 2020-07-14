import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPair.dart';
import 'package:mailwayui/scene/Compose.dart';
import 'package:mailwayui/widget/ColoredTextIcon.dart';

class RecipientSelectScene extends StatefulWidget {
  @override
  _RecipientSelectSceneState createState() => _RecipientSelectSceneState();
}

class _RecipientSelectSceneState extends State<RecipientSelectScene> {
  String filter;
  List<ContactAndKeyPair> selectedContact;

  @override
  void initState() {
    super.initState();
    filter = "";
    selectedContact = [];
  }

  @override
  Widget build(BuildContext context) {
    final data = AppData.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("Add Users"),
        actions: [
          FlatButton(
            onPressed: selectedContact.length == 0
                ? null
                : () {
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (context) => ComposeScene(
                          selectedContactPublicKey: selectedContact
                              .map((e) => e.keypair.public_key)
                              .toList(),
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
            child: ColoredTextIcon(
              color: Theme.of(context).primaryColor,
              child: Text("DONE"),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListTile(
            title: TextField(
              decoration: InputDecoration(
                labelText: "Search for usernames",
                filled: true,
              ),
              onChanged: (text) {
                setState(() {
                  filter = text;
                });
              },
            ),
          ),
        ]..addAll(
            data.contacts
                .where((element) => element.contact.name.contains(filter))
                .map(
                  (e) => CheckboxListTile(
                    secondary: FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(Icons.account_circle),
                    ),
                    title: Text(e.contact.name),
                    value: selectedContact.contains(e),
                    onChanged: (bool value) {
                      if (selectedContact.contains(e)) {
                        selectedContact.remove(e);
                      } else {
                        selectedContact.add(e);
                      }
                      setState(() {});
                    },
                  ) as Widget,
                )
                .toList(),
          ),
      ),
    );
  }
}
