import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/extensions/color.dart';
import 'package:mailwayui/widget/ContactAvatar.dart';

class IdentityItem extends StatelessWidget {
  final Contact contact;
  final Keypair keypair;
  final GestureTapCallback onTap;
  final EdgeInsetsGeometry padding;

  const IdentityItem(
      {Key key,
      this.contact,
      this.keypair,
      this.onTap,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.all(16),
        child: Row(
          children: [
            ContactAvatar(
              contact: contact,
            ),
            SizedBox(width: 8),
            Container(
              height: 40,
              width: 2,
              color: contact.color?.toColor() ?? Colors.grey,
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
