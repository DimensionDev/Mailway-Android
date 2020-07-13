import 'package:barcode_scan/barcode_scan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mailwayui/data/AppViewModel.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/scene/ContactInfo.dart';
import 'package:mailwayui/extensions/color.dart';
import 'package:mailwayui/widget/ContactAvatar.dart';

class ContactScene extends StatefulWidget {
  @override
  _ContactSceneState createState() => _ContactSceneState();
}

class _ContactSceneState extends State<ContactScene> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    final data = AppData.of(context);
    final viewModel = AppViewModel.of(context);
    final contacts = data.contacts
        .where((element) => element.name.contains(filter))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text("Contacts"),
        actions: [
        ],
      ),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        child: Icon(Icons.add),
        children: [
          SpeedDialChild(
            child: Icon(Icons.code),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            label: 'Scan QR code',
            onTap: () async {
              var result = await BarcodeScanner.scan();
              await viewModel.insertIdentityCard(result.rawContent);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.folder),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            label: 'Browser file',
            onTap: () async {
              final file = await FilePicker.getFile();
              final content = await file.readAsString();
              await viewModel.insertIdentityCard(content);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  filled: true,
                ),
                onChanged: (text) {
                  setState(() {
                    filter = text;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider.builder(
              itemCount: data.myKeys.length,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 123,
              ),
              itemBuilder: (context, index) {
                final item = data.myKeys[index];
                return Padding(
                  padding:
                      EdgeInsets.only(top: 16, bottom: 32, left: 8, right: 8),
                  child: Card(
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _ContactIdentityItem(
                      contact: item.contact,
                      keypair: item.keypair,
                    ),
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = contacts[index];
                return ListTile(
                  onTap: () async {
                    final result = await viewModel.getContactInfo(item);
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => ContactInfoScene(
                          contact: item,
                          keypair: result.keypair,
                          channels: result.channels,
                        ),
                      ),
                    );
                  },
                  leading: ContactAvatar(
                    contact: item,
                  ),
                  title: Text(item.name),
                );
              },
              childCount: contacts.length,
            ),
          )
        ],
      ),
    );
  }
}

class _ContactIdentityItem extends StatelessWidget {
  final Contact contact;
  final Keypair keypair;
  final Function onTap;

  const _ContactIdentityItem({Key key, this.contact, this.keypair, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16, top: 16, bottom: 16),
        child: Row(
          children: [
            SizedBox(width: 4),
            Container(
              height: 28,
              width: 4,
              decoration: BoxDecoration(
                color: contact.color?.toColor() ?? Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            SizedBox(width: 16.0 - 4 - 4),
            ContactAvatar(
              contact: contact,
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  keypair.key_id.substring(keypair.key_id.length - 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
