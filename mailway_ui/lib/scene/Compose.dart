import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPairWithContactChannels.dart';
import 'package:mailwayui/widget/IdentityItem.dart';

class ComposeScene extends StatefulWidget {
  final ContactAndKeyPairWithContactChannels sender;
  final List<String> selectedContactPublicKey;

  const ComposeScene({Key key, this.selectedContactPublicKey, this.sender})
      : super(key: key);
  @override
  _ComposeSceneState createState() => _ComposeSceneState();
}

class _ComposeSceneState extends State<ComposeScene> {
  ContactAndKeyPairWithContactChannels selectedSender;
  String text;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedSender = widget.sender ?? AppData.of(context).myKeys.first;
  }

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
        title: widget.sender == null
            ? DropdownButton<ContactAndKeyPairWithContactChannels>(
                isExpanded: true,
                value: selectedSender,
                underline: Container(),
                items: data.myKeys
                    .map(
                      (e) => DropdownMenuItem<
                          ContactAndKeyPairWithContactChannels>(
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
              )
            : Text(widget.sender.contact.name),
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              await viewModel.newChat(selectedSender.keypair, text,
                  widget.selectedContactPublicKey);
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
