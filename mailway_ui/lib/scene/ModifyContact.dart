import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/widget/ColoredTextIcon.dart';
import 'package:mailwayui/extensions/color.dart';

class ContactAdditionData {
  final String type;
  final Key key;
  String value;

  ContactAdditionData({
    this.type,
    this.key,
    this.value,
  });
}

class ModifyContactScene extends StatefulWidget {
  final Keypair keypair;
  final Contact contact;
  final List<ContactChannel> channels;

  const ModifyContactScene({Key key, this.keypair, this.contact, this.channels})
      : super(key: key);

  @override
  _ModifyContactSceneState createState() => _ModifyContactSceneState();
}

class _ModifyContactSceneState extends State<ModifyContactScene> {
  final scaffoldKey = GlobalKey();
  List<ContactAdditionData> additionData = List();
  String name = "";
  Color color;

  @override
  void initState() {
    super.initState();
    if (widget.channels != null) {
      additionData = widget.channels
          .map(
            (e) => ContactAdditionData(
              type: e.name,
              key: UniqueKey(),
              value: e.value,
            ),
          )
          .toList();
    }
    if (widget.contact?.name != null) {
      name = widget.contact.name;
    }
    if (widget.contact?.color != null) {
      color = widget.contact.color.toColor();
    } else {
      color = Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final viewModel = AppViewModel.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () async {
              if (widget.keypair == null) {
                await viewModel.generateNewIdentity(name, color.toHex(), additionData);
              } else {
                widget.contact.color = color.toHex();
                await viewModel.updateContact(
                  widget.contact,
                  widget.channels,
                  name,
                  additionData,
                );
              }
              Navigator.of(context).pop();
            },
            child: ColoredTextIcon(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Text("Save"),
                  SizedBox(width: 8),
                  Icon(Icons.save),
                ],
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: query.size.width * 0.3,
                        ),
                        SizedBox(
                          height: 20.0 + 8.0,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonTheme(
                        minWidth: 0,
                        padding: EdgeInsets.all(8),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          colorBrightness: Brightness.dark,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(999)),
                          child: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(labelText: "Name"),
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  showColorPicker(context);
                },
                title: Text("Set ID color"),
                trailing: Padding(
                  padding: EdgeInsets.all(8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              widget.keypair?.private_key == null
                  ? null
                  : ListTile(
                      title: TextField(
                        controller: TextEditingController(
                            text: widget.keypair.private_key),
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Private key"),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.keypair.private_key));
                        },
                      ),
                    ),
              widget.keypair?.public_key == null
                  ? null
                  : ListTile(
                      title: TextField(
                        controller: TextEditingController(
                            text: widget.keypair.public_key),
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Public key"),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.keypair.public_key));
                        },
                      ),
                    ),
              ListTile(
                title: Text("Contacts"),
              ),
              ...buildContactInput(context, Icon(Icons.email), "Add E-Mail",
                  "email", "Input E-Mail address"),
              ...buildContactInput(context, Icon(Icons.email), "Add Twitter",
                  "twitter", "Input Twitter user name"),
              ...buildContactInput(context, Icon(Icons.email), "Add Facebook",
                  "facebook", "Input facebook user name"),
              ...buildContactInput(context, Icon(Icons.email), "Add Telegram",
                  "telegram", "Input telegram user name"),
              ...buildContactInput(context, Icon(Icons.email), "Add Discord",
                  "discord", "Input discord user name"),
              widget.keypair == null
                  ? null
                  : ListTile(
                      title: RaisedButton(
                        onPressed: () async {
                          await viewModel.removeContact(widget.contact);
                          Navigator.of(context).pop();
                        },
                        child: Text("Remove identity"),
                      ),
                    ),
            ].where((element) => element != null).toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildContactInput(
    BuildContext context,
    Widget icon,
    String title,
    String type,
    String hint,
  ) {
    return [
      ListTile(
        leading: icon,
        title: Text(title),
        onTap: () {
          if (!additionData.any(
              (element) => element.type == type && element.value.isEmpty)) {
            setState(() {
              additionData
                  .add(ContactAdditionData(type: type, key: UniqueKey()));
            });
          }
        },
      ),
      ...additionData
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              value.type != type
                  ? null
                  : ListTile(
                      key: value.key,
                      title: TextFormField(
                        initialValue: value.value,
                        decoration: InputDecoration(hintText: hint),
                        onChanged: (it) {
                          setState(() {
                            additionData[key].value = it;
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            additionData.removeAt(key);
                          });
                        },
                      ),
                    ),
            ),
          )
          .values
          .where((element) => element != null)
          .toList(),
    ];
  }

  void showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: Colors.cyan,
            onColorChanged: (_color) {
              setState(() {
                color = _color;
              });
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Done'),
            onPressed: () {
//              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
