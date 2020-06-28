import 'package:flutter/material.dart';

AppBarTheme whiteAppBarTheme(BuildContext context) {
  final theme = Theme.of(context);
  return AppBarTheme(
    color: Theme.of(context).scaffoldBackgroundColor,
    iconTheme: Theme.of(context).iconTheme,
    textTheme: Theme.of(context).textTheme,
    actionsIconTheme: Theme.of(context).iconTheme,
  );
}
