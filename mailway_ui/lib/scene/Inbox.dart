import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPairWithContactChannels.dart';
import 'package:mailwayui/scene/ChatTimeline.dart';
import 'package:mailwayui/scene/Decrypt.dart';
import 'package:mailwayui/scene/ModifyContact.dart';
import 'package:mailwayui/scene/RecipientSelect.dart';

class InboxScene extends StatelessWidget {
  final ContactAndKeyPairWithContactChannels filter;

  const InboxScene({Key key, this.filter}) : super(key: key);

  void showCreateKeyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Identity Not Found"),
        content: Text("You should create at least one identity first!"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ModifyContactScene(),
                ),
              );
            },
            child: Text("Create one"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = AppData.of(context);
    final messages = filter == null
        ? data.chats
        : data.chats
            .where((element) =>
                element.chat.identity_public_key == filter.keypair.public_key)
            .toList();

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
        title: Text(filter?.contact?.name ?? "Inbox"),
        actions: [
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
              if (data.myKeys.length == 0) {
                showCreateKeyDialog(context);
              } else {
                Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                    builder: (context) => RecipientSelectScene(),
                    fullscreenDialog: true,
                  ),
                );
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.inbox),
            backgroundColor: Colors.lightBlue,
            label: 'Receive',
            onTap: () {
              if (data.myKeys.length == 0) {
                showCreateKeyDialog(context);
              } else {
                Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                    builder: (context) => DecryptScene(),
                    fullscreenDialog: true,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final item = messages[index];
          return ListTile(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => ChatTimelineScene(
                    chatId: item.chat.chatId,
                  ),
                ),
              );
            },
            leading: Icon(Icons.account_circle),
            title: Text(item.chatMemberNameStubs.map((e) => e.name).join(", ")),
            subtitle: Text(
              item.messages.last?.chatMessage?.payload,
              maxLines: 1,
            ),
          );
        },
      ),
    );
  }
}
