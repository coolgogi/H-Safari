import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, '이용약관'),
        body: Center(
          child: Text(
            'terms of use',
            style: TextStyle(fontSize: 24.0),
          ),
        ));
  }
}
