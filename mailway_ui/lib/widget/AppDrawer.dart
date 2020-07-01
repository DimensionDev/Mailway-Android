import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/scene/Contact.dart';
import 'package:mailwayui/scene/Inbox.dart';
import 'package:mailwayui/scene/Settings.dart';
import 'package:mailwayui/widget/ExpansionTileEx.dart';
import 'package:mailwayui/widget/IdentityItem.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey navigatorKey;

  const AppDrawer({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appData = AppData.of(context);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ExpansionTileEx(
                  title: Text("Inbox"),
                  leading: Icon(
                    Icons.inbox,
                    color: Colors.lightBlue.shade300,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    (navigatorKey.currentState as NavigatorState).pushReplacement(
                        MaterialPageRoute(builder: (context) => InboxScene()));
                  },
                  children: appData.myKeys
                      .map(
                        (e) => IdentityItem(
                          contact: e.contact,
                          keypair: e.keypair,
                          onTap: () {},
                        ),
                      )
                      .toList(),
                  childrenPadding: EdgeInsets.only(left: 40),
                ),
                _DrawerMenuItem(
                  title: "Drafts",
                  icon: Icons.drafts,
                  color: Colors.orange,
                ),
                _DrawerMenuItem(
                  title: "Contacts",
                  icon: Icons.contacts,
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    (navigatorKey.currentState as NavigatorState).pushReplacement(MaterialPageRoute(
                        builder: (context) => ContactScene()));
                  },
                ),
                _DrawerMenuItem(
                  title: "Plugins",
                  icon: Icons.pages,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          _DrawerMenuItem(
            title: "Settings",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (_) => SettingsScene(), fullscreenDialog: true));
            },
          )
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback onTap;
  final Color color;

  const _DrawerMenuItem(
      {Key key, this.title, this.icon, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      leading: Icon(icon, color: color),
    );
  }
}
