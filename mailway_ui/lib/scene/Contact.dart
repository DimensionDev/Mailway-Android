import 'package:flutter/material.dart';
import 'package:mailwayui/scene/AddContact.dart';
import 'package:mailwayui/widget/AppDrawer.dart';

class ContactScene extends StatefulWidget {
  @override
  _ContactSceneState createState() => _ContactSceneState();
}

class _ContactSceneState extends State<ContactScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
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
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddContactScene()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
