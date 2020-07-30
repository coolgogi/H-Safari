import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class asking extends StatefulWidget {
  @override
  _askingState createState() => _askingState();
}

class _askingState extends State<asking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, '문의하기'),
        body: Center(
          child: Text(
            'terms of use',
            style: TextStyle(fontSize: 24.0),
          ),
        )
    );
  }
}
