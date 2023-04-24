import 'package:flutter/material.dart';

class AppCommender extends StatefulWidget {
  const AppCommender({Key? key}) : super(key: key);

  @override
  _AppCommenderState createState() => _AppCommenderState();
}

class _AppCommenderState extends State<AppCommender>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  bool _visible = false;
  show() async {
    if (!_visible) {
      _visible = true;
      await _animationController.forward();
      await Future.delayed(const Duration(seconds: 3));
      await _animationController.reverse();
      _visible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
