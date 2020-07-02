import 'package:flutter/material.dart';

class ContactInfoScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(),
        SliverList(delegate: null)
      ],),
    );
  }
}
