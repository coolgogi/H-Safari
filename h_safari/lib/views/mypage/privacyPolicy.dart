import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, '개인정보처리방침'),
        body: Center(
          child: Text(
            '개인정보처리방침',
            style: TextStyle(fontSize: 24.0),
          ),
        ));
  }
}
