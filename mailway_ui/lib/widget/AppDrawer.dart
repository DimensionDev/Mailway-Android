import 'package:flutter/material.dart';

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
                ),
                _DrawerMenuItem(
                  title: "Drafts",
                  icon: Icons.drafts,
                ),
                _DrawerMenuItem(
                  title: "Contacts",
                  icon: Icons.contacts,
                ),
                _DrawerMenuItem(
                  title: "Plugins",
                  icon: Icons.pages,
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

  const _DrawerMenuItem({Key key, this.title, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      leading: Icon(icon),
    );
  }
}
