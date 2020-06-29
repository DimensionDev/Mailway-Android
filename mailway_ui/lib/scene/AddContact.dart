import 'package:flutter/material.dart';
import 'package:mailwayui/widget/ColoredTextIcon.dart';

class ContactAditionData {
  final String type;
  final Key key;
  String value;

  ContactAditionData({
    this.type,
    this.key,
  });
}

class AddContactScene extends StatefulWidget {
  @override
  _AddContactSceneState createState() => _AddContactSceneState();
}

class _AddContactSceneState extends State<AddContactScene> {
  List<ContactAditionData> additionData = List();
  String name = "";


  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () {},
            child: ColoredTextIcon(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Text("Save"),
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
                title: TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: TextField(
                  controller: TextEditingController(text: "dsadsdsads"),
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Public key"),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: () {},
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
            ],
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
          setState(() {
            additionData.add(ContactAditionData(type: type, key: UniqueKey()));
          });
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
                      title: TextField(
                        decoration: InputDecoration(hintText: hint),
                        onChanged: (it) {
                          setState(() {
                            additionData[key].value = it;
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
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
}
