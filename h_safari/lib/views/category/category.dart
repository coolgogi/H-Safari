// 기본 import
import 'package:flutter/material.dart';

// widget.dart import
import 'package:h_safari/widget/widget.dart';

class MyCategory extends StatefulWidget {
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain('카테고리'),
      body: categoryBox(),
    );
  }
}

