import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPairWithContactChannels.dart';
import 'package:mailwayui/widget/IdentityItem.dart';

class ComposeScene extends StatefulWidget {
  final List<Contact> selectedContact;

  const ComposeScene({Key key, this.selectedContact}) : super(key: key);
  @override
  _ComposeSceneState createState() => _ComposeSceneState();
}

class _ComposeSceneState extends State<ComposeScene> {
  ContactAndKeyPairWithContactChannels selectedSender;
  String text;

  @override
  Widget build(BuildContext context) {
    final data = AppData.of(context);
    final viewModel = AppViewModel.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
        centerTitle: true,
        title: DropdownButton<ContactAndKeyPairWithContactChannels>(
          isExpanded: true,
          value: selectedSender ?? data.myKeys.first,
          underline: Container(),
          items: data.myKeys
              .map(
                (e) => DropdownMenuItem<ContactAndKeyPairWithContactChannels>(
                  value: e,
                  child: IdentityItem(
                    contact: e.contact,
                    keypair: e.keypair,
                    padding: EdgeInsets.all(0),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedSender = value;
            });
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              await viewModel.newChat(selectedSender, text, widget.selectedContact);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListTile(
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              text = value;
            });
          },
          autofocus: true,
          expands: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
    );
  }
}
