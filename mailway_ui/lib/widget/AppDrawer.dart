import 'package:flutter/material.dart';
import 'package:mailwayui/scene/Contact.dart';
import 'package:mailwayui/scene/Inbox.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _DrawerMenuItem(
                  title: "Inbox",
                  icon: Icons.inbox,
                  color: Colors.lightBlue.shade300,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => InboxScene()));
                  },
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
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

  const _DrawerMenuItem({Key key, this.title, this.icon, this.onTap, this.color})
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
