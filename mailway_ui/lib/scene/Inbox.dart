import 'package:flutter/material.dart';
import 'package:mailwayui/widget/AppDrawer.dart';

class InboxScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      appBar: AppBar(
        title: Text("Inbox"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FancyFab(
        icon: Icons.add,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Reveice',
            child: Icon(Icons.inbox),
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'write',
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final List<Widget> children;

  FancyFab({this.onPressed, this.tooltip, this.icon, this.children});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  // Animation<Color> _buttonColor;
  Animation<double> _opacity;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOutCubic;
  double _fabHeight = 56.0;

  @override
  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon = Tween<double>(
      begin: 0.0,
      end: (180.0 - 45.0) / 360.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _curve,
      ),
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _curve,
      ),
    );
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: _curve,
    ));
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        onPressed: animate,
        tooltip: 'Toggle',
        child: RotationTransition(
          turns: _animateIcon,
          child: Icon(widget.icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widget.children
            .asMap()
            .map(
              (index, element) => MapEntry(
                index,
                Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    _translateButton.value * (widget.children.length - index),
                    0.0,
                  ),
                  child: Opacity(
                    opacity: _opacity.value,
                    child: element,
                  ),
                ) as Widget,
              ),
            )
            .values
            .toList()
              ..add(toggle()));
  }
}
