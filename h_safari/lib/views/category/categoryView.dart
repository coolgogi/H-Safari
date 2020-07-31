// 기본 import
import 'package:flutter/material.dart';

// widget import
import 'package:h_safari/widget/widget.dart';

class categoryView extends StatefulWidget {
  final String select;
  categoryView({this.select});

  @override
  _categoryViewState createState() => _categoryViewState(select : select);
}

class _categoryViewState extends State<categoryView> {
  final String select;
  _categoryViewState({this.select});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSelect(context, '$select'),
    );
  }
}
