import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/scene/ModifyContact.dart';
import 'package:mailwayui/widget/AppDrawer.dart';

class ContactScene extends StatefulWidget {
  @override
  _ContactSceneState createState() => _ContactSceneState();
}

class _ContactSceneState extends State<ContactScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
            rootNavigator: true,
          ).push(
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (_) => ModifyContactScene(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
