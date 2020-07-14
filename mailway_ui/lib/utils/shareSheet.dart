import 'package:flutter/material.dart';
import 'package:mailwayui/scene/QRCode.dart';
import 'package:share/share.dart';

void showShareSheet(BuildContext context, String data) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Share.share(data);
          },
          leading: Icon(Icons.textsms),
          title: Text("Share Text"),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.insert_drive_file),
          title: Text("Share file"),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QRCodeScene(
                  data: data,
                ),
              ),
            );
          },
          leading: Icon(Icons.image),
          title: Text("Generate qr code"),
        )
      ],
    ),
  );
}
