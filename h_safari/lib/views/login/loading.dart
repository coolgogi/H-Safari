import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:h_safari/helpers/authPage.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      value: 0.1
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut
    );

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ScaleTransition(
            scale: _animation,
            alignment: Alignment.center,
            child: Image.asset(
              'Logo/loading page-shadow.png.png',
              fit: BoxFit.fitWidth,
            ),
          )
        ),
      ),
    );
  }
}
