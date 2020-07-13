import 'package:flutter/material.dart';

class ScreenF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ScreenF'),
        ),
        body: Center(
          child: Text(
            'ScreenF',
            style: TextStyle(fontSize: 24.0),
          ),
        )
    );
  }
}
