import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/ContactChannel.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/widget/ColoredTextIcon.dart';
import 'package:mailwayui/widget/ContactAvatar.dart';

class ContactInfoScene extends StatelessWidget {
  final Contact contact;
  final Keypair keypair;
  final List<ContactChannel> channels;

  const ContactInfoScene({Key key, this.contact, this.keypair, this.channels})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: mediaQuery.size.width * 0.5,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ContactAvatar(
                          contact: contact,
                          size: mediaQuery.size.width * 0.5,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      iconTheme: Theme.of(context).iconTheme,
                      textTheme: Theme.of(context).textTheme,
                      actionsIconTheme: Theme.of(context).iconTheme,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  Text(
                    contact.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Public Key",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 4),
                  Text(keypair.key_id.substring(keypair.key_id.length - 8)),
                  SizedBox(height: 8),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: ColoredTextIcon(
                        child: Text("Share Contact"),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = channels[index];
                  return ListTile(
                    onTap: () {},
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  );
                },
                childCount: channels.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}