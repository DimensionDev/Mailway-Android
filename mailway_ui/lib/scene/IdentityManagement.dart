import 'package:flutter/material.dart';

class IdentityManagementScene extends StatefulWidget {
  @override
  _IdentityManagementSceneState createState() =>
      _IdentityManagementSceneState();
}

class _IdentityManagementSceneState extends State<IdentityManagementScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("Identity"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: SliverAnimatedList(
          initialItemCount: 0,
          itemBuilder: (context, index, animation) {
            return ListTile();
          },
        ),
      ),
    );
  }
}
