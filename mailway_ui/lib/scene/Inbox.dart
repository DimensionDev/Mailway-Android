import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mailwayui/widget/AppDrawer.dart';

class InboxScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("Inbox"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        child: Icon(Icons.add),
        children: [
          SpeedDialChild(
            child: Icon(Icons.inbox),
            backgroundColor: Colors.lightBlue,
            label: 'Receive',
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(Icons.send),
            backgroundColor: Colors.green,
            label: 'Write',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
