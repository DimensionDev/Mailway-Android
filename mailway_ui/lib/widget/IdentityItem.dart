import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailwayui/data/entity/Contact.dart';
import 'package:mailwayui/data/entity/Keypair.dart';
import 'package:mailwayui/extensions/color.dart';

class IdentityItem extends StatelessWidget {
  final Contact contact;
  final Keypair keypair;
  final Function onTap;

  const IdentityItem({Key key, this.contact, this.keypair, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            contact.avatar == null
                ? Icon(
                    Icons.account_circle,
                    size: 40,
                  )
                : Image.file(File(contact.avatar)),
            SizedBox(width: 8),
            Container(
              height: 40,
              width: 2,
              color: contact.color?.toColor() ?? Colors.grey,
            ),
            SizedBox(width: 8),
            Column(
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

    return ListTile(
      contentPadding: EdgeInsets.only(left: 4, right: 16),
      onTap: () {
        onTap?.call();
      },
      title: Text(contact.name),
//      trailing: Padding(
//        padding: EdgeInsets.all(16),
//        child: AspectRatio(
//          aspectRatio: 1,
//          child: Container(
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: contact.color?.toColor() ?? Colors.grey,
//            ),
//          ),
//        ),
//      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          contact.avatar == null
              ? Icon(
                  Icons.account_circle,
                  size: 40,
                )
              : Image.file(File(contact.avatar)),
          SizedBox(width: 4),
          VerticalDivider(
            indent: 8,
            endIndent: 8,
            thickness: 2,
            color: contact.color?.toColor() ?? Colors.grey,
          ),
        ],
      ),
      subtitle: Text(keypair.key_id.substring(keypair.key_id.length - 8)),
    );
  }
}
