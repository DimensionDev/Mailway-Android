import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/Keypair.dart';

class IdentityItem extends StatelessWidget {
  final Contact contact;
  final Keypair keypair;
  final Function onTap;

  const IdentityItem({Key key, this.contact, this.keypair, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap?.call();
      },
      title: Text(contact.name),
      leading: contact.avatar == null
          ? Icon(Icons.account_circle)
          : Image.file(File(contact.avatar)),
      subtitle: Text(keypair.key_id.substring(keypair.key_id.length - 8)),
    );
  }
}
