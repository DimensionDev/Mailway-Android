import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailwayui/data/entity/Contact.dart';

class ContactAvatar extends StatelessWidget {
  final Contact contact;
  final double size;

  const ContactAvatar({
    Key key,
    this.contact,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return contact.avatar == null
        ? Icon(
            Icons.account_circle,
            size: size,
          )
        : Image.file(File(contact.avatar));
  }
}
