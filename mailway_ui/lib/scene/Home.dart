import 'package:flutter/material.dart';
import 'package:mailwayui/scene/Contact.dart';
import 'package:mailwayui/scene/Inbox.dart';
import 'package:mailwayui/widget/AppDrawer.dart';

class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> {
  final navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        navigatorKey: navigatorKey,
      ),
      body: Navigator(
        key: navigatorKey,
        initialRoute: "/",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/":
              return MaterialPageRoute(
                  settings: settings, builder: (context) => InboxScene());
            case "/contact":
              return MaterialPageRoute(
                  settings: settings, builder: (context) => ContactScene());
            default:
              throw new Exception('Invalid route: ${settings.name}');
          }
        },
      ),
    );
  }
}
