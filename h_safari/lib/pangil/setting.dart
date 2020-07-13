import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
        ),
        body: Center(
          child: Text(
            'Setting',
            style: TextStyle(fontSize: 24.0),
          ),
        )
    );
  }
}
