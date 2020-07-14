import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/scene/ContactInfo.dart';
import 'package:mailwayui/scene/ModifyContact.dart';
import 'package:mailwayui/widget/IdentityItem.dart';

class IdentityManagementScene extends StatefulWidget {
  @override
  _IdentityManagementSceneState createState() =>
      _IdentityManagementSceneState();
}

class _IdentityManagementSceneState extends State<IdentityManagementScene> {
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
        title: Text("Identity"),
      ),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: appData.myKeys
              .map(
                (e) => IdentityItem(
                  contact: e.contact,
                  keypair: e.keypair,
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => ContactInfoScene(
                          keypair: e.keypair,
                          contact: e.contact,
                          channels: e.channels,
                        ),
                      ),
                    );
                  },
                ) as Widget,
              )
              .toList()
                ..add(
                  ListTile(
                    title: RaisedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => ModifyContactScene()));
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add identity"),
                    ),
                  ) as Widget,
                ),
        ),
      ),
    );
  }
}
