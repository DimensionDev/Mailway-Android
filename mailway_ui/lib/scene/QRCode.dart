import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_extend/share_extend.dart';

class QRCodeScene extends StatelessWidget {
  final String data;
  final GlobalKey globalKey = GlobalKey();

  QRCodeScene({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("QR Code"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final RenderRepaintBoundary boundary =
                  globalKey.currentContext.findRenderObject();
              final image = await boundary.toImage();
              final byteData =
                  await image.toByteData(format: ImageByteFormat.png);
              final bytes = byteData.buffer.asUint8List();

              final tempDir = (await getTemporaryDirectory()).path;
              final qrcodeFile = File('$tempDir/qr_code.png');
              await qrcodeFile.writeAsBytes(bytes);
              await ShareExtend.share(qrcodeFile.path, "image");
            },
          ),
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: QrImage(
            data: data,
          ),
        ),
      ),
    );
  }
}
