import 'package:flutter/material.dart';

class DecryptScene extends StatefulWidget {
  @override
  _DecryptSceneState createState() => _DecryptSceneState();
}

class _DecryptSceneState extends State<DecryptScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Decrypting"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "",
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  expands: true,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                children: [
                  Chip(
                    avatar: Icon(Icons.add_circle_outline),
                    label: Text("Decrypt a file"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
