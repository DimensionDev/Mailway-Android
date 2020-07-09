import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/ChatWithChatMessagesWithChatMemberNameStubs.dart';

class ChatTimelineScene extends StatelessWidget {
  final ChatWithChatMessagesWithChatMemberNameStubs data;

  const ChatTimelineScene({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appData = AppData.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        centerTitle: true,
        title: Text(data.chatMemberNameStubs.map((e) => e.name).join(", ")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.reply_all),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          indent: 16,
          endIndent: 16,
          color: Theme.of(context).dividerColor,
        ),
        physics: BouncingScrollPhysics(),
        itemCount: data.messages.length,
        itemBuilder: (context, index) {
          final item = data.messages[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data.chatMemberNameStubs
                                .firstWhere(
                                    (element) =>
                                        element.public_key ==
                                        item.sender_public_key,
                                    orElse: () => null)
                                ?.name ??
                            appData.myKeys
                                .firstWhere((element) =>
                                    element.keypair.public_key ==
                                    item.sender_public_key)
                                .contact
                                .name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.reply),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(item.payload),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateTime.fromMillisecondsSinceEpoch(item.compose_timestamp)
                        .toIso8601String(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
