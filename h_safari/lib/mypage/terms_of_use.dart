import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('terms of use'),
        ),
        body: Center(
          child: Text(
            'terms of use',
            style: TextStyle(fontSize: 24.0),
          ),
        )
    );
  }
}
