import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:h_safari/helpers/authPage.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, value: 0.1);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//  @override
//  void setState(fn) {
//    Future myFuture() async {
//      await Future.delayed(Duration(seconds: 2));
//      Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
//    }
//
//    super.setState(fn);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MainPage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ScaleTransition(
                        scale: _animation,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'Logo/loadingPage-shadow.png.png',
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('에러');
          } else
            return Center();
        },
      ),
    );
  }

  Future MainPage() async {
    await Future.delayed(Duration(seconds: 3), () => Navigator.pop(context));
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }
}
