import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class resetPW extends StatefulWidget {
  @override
  _resetPWState createState() => _resetPWState();
}

class _resetPWState extends State<resetPW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, '비밀번호 재설정'),
        body: Center(
          child: Text(
            'terms of use',
            style: TextStyle(fontSize: 24.0),
          ),
        )
    );
  }
}
