import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailwayui/scene/QRCode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';
import 'package:uuid/uuid.dart';

void showShareSheet(BuildContext context, String data, {String fileName}) {
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
          onTap: () async {
            Navigator.of(context).pop();
            final tempDir = (await getTemporaryDirectory()).path;
            final tempFile = File('$tempDir/${fileName ?? Uuid().v4().toString()}');
            await tempFile.writeAsString(data);
            ShareExtend.share(tempFile.path, 'file');
        },
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
