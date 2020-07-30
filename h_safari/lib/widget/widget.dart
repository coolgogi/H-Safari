import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';

// 뒤로가기 기능이 있는 page들을 위한 appBar 생성
Widget appBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.green[100],
    leading: InkWell(
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.green,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.black),
    ),
  );
}

// 뒤로가기 기능이 없고 로고가 들어갈 page들을 위한 appBar 생성
Widget appBarMain(BuildContext context, String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.green[100],
    leading: Icon(
      Icons.cake,
      color: Colors.green,
    ),
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.black),
    ),
  );
}

// select되어 화면을 가져오는 페이지들을 위한 appBar 생성
Widget appBarSelect(BuildContext context, String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.green[100],
    leading: InkWell(
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.green,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),

    title: Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: Center(
          child: Text(
            '$title',
            style: TextStyle(color: Colors.black),
          )),
    ),
  );
}