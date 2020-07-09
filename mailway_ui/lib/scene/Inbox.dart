import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/scene/ChatTimeline.dart';
import 'package:mailwayui/scene/Decrypt.dart';
import 'package:mailwayui/scene/RecipientSelect.dart';
import 'package:mailwayui/widget/AppDrawer.dart';

class InboxScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = AppData.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
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
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        child: Icon(Icons.add),
        children: [
          SpeedDialChild(
            child: Icon(Icons.send),
            backgroundColor: Colors.green,
            label: 'Write',
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                      builder: (context) => RecipientSelectScene(),
                      fullscreenDialog: true));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.inbox),
            backgroundColor: Colors.lightBlue,
            label: 'Receive',
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                      builder: (context) => DecryptScene(),
                      fullscreenDialog: true));
            },
          ),
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: data.chats.length,
        itemBuilder: (context, index) {
          final item = data.chats[index];
          return ListTile(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChatTimelineScene(
                        data: item,
                      )));
            },
            leading: Icon(Icons.account_circle),
            title: Text(item.chatMemberNameStubs.map((e) => e.name).join(", ")),
            subtitle: Text(
              item.messages.last?.payload,
              maxLines: 1,
            ),
          );
        },
      ),
    );
  }
}
