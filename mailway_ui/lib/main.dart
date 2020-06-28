import 'package:flutter/material.dart';
import 'package:mailwayui/scene/Inbox.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final pageTransition = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(),
      TargetPlatform.windows: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mailway',
      theme: ThemeData(
        pageTransitionsTheme: pageTransition,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InboxScene(),
    );
  }
}
