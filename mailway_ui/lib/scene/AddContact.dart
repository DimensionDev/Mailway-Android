import 'package:flutter/material.dart';
import 'package:mailwayui/widget/ColoredTextIcon.dart';

class AddContactScene extends StatefulWidget {
  @override
  _AddContactSceneState createState() => _AddContactSceneState();
}

class _AddContactSceneState extends State<AddContactScene> {
  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(),
      ),
    );
  }
}
