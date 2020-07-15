import 'package:barcode_scan/barcode_scan.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/ContactAndKeyPairWithContactChannels.dart';
import 'package:mailwayui/ntge/entity/NtgeEd25519Keypair.dart';
import 'package:mailwayui/widget/IdentityItem.dart';

class DecryptScene extends StatefulWidget {
  @override
  _DecryptSceneState createState() => _DecryptSceneState();
}

class _DecryptSceneState extends State<DecryptScene> {
  String text = "";

  void decrypt(BuildContext context, String message) async {
    final viewModel = AppViewModel.of(context);
    final appDate = AppData.of(context);
    DecodeResult result;
    try {
      result = await viewModel.decrypt(message);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Can not find a key to decrypt"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
      return;
    }
    final allKeys = [result.extra.sender_key, ...result.extra.recipient_keys];
    final myKey = appDate.myKeys
        .where((element) => allKeys.contains(element.keypair.public_key))
        .toList();
    ContactAndKeyPairWithContactChannels key;
    if (myKey.length > 1) {
      key = await showDialog<ContactAndKeyPairWithContactChannels>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Select a key to join/receive chat"),
          content: ListView.builder(
            itemCount: myKey.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.of(context).pop(myKey[index]);
              },
              title: IdentityItem(
                contact: myKey[index].contact,
                keypair: myKey[index].keypair,
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    } else if (myKey.length == 1) {
      key = myKey.first;
    } else {
      // should not happen
      return;
    }
    final recipientKeys =
        allKeys.where((element) => element != key.keypair.public_key).toList();
    await viewModel.insertOrCreateChat(
      recipientKeys,
      key.keypair.public_key,
      DateTime.now().millisecondsSinceEpoch,
      result.message,
      message,
      result.extra.message_id,
      quoteMessage: result.extra?.quote_message,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("Decrypting"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
                'Scan a QR code or Message file or from clipboard to decode a message.'),
          ),
          ListTile(
            onTap: () async {
              var result = await BarcodeScanner.scan();
              decrypt(context, result.rawContent);
            },
            leading: Icon(Icons.code),
            title: Text("Scan the Message QR code"),
          ),
          ListTile(
            onTap: () async {
              final file = await FilePicker.getFile(
                allowedExtensions: ['mem'],
                type: FileType.custom,
              );
              final content = await file.readAsString();
              decrypt(context, content);
            },
            leading: Icon(Icons.insert_drive_file),
            title: Text("Import a Message file"),
          ),
          ListTile(
            onTap: () async {
              ClipboardData data = await Clipboard.getData('text/plain');
              decrypt(context, data.text);
            },
            leading: Icon(Icons.dashboard),
            title: Text("From clipboard"),
          ),
        ],
      ),
    );
  }
}
