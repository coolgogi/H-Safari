import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, '테스트'),
        body: Center(
          child: Text(
            '테스트',
            style: TextStyle(fontSize: 24.0),
          ),
        ));
  }
}
