import 'package:barcode_scan/barcode_scan.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mailwayui/data/AppViewModel.dart';

class ImportContactScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = AppViewModel.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text("Add Contacts"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
                'Import a QR code or Bizcard file to add a contact. You can export any Bizcard from the contact list'),
          ),
          ListTile(
            onTap: () async {
              var result = await BarcodeScanner.scan();
              await viewModel.insertIdentityCard(result.rawContent);
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.code),
            title: Text("Scan the Bizcard QR code"),
          ),
          ListTile(
            onTap: () async {
              final file = await FilePicker.getFile(
                allowedExtensions: ['mbc'],
                type: FileType.custom,
              );
              final content = await file.readAsString();
              await viewModel.insertIdentityCard(content);
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.insert_drive_file),
            title: Text("Import a Bizcard file"),
          ),
        ],
      ),
    );
  }
}
