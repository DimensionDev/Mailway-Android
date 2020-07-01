import 'package:flutter/material.dart';
import 'package:mailwayui/scene/IdentityManagement.dart';

class SettingsScene extends StatefulWidget {
  @override
  _SettingsSceneState createState() => _SettingsSceneState();
}

class _SettingsSceneState extends State<SettingsScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Identity"),
              onTap: () {
                Navigator.of(
                  context,
                ).push(
                  MaterialPageRoute(
                    builder: (context) => IdentityManagementScene(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
