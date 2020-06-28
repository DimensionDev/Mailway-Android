import 'package:flutter/material.dart';

class ColoredTextIcon extends StatelessWidget {
  final Widget child;
  final Color color;

  const ColoredTextIcon({
    Key key,
    this.child,
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: color,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: color,
        ),
        child: child,
      ),
    );
  }
}
