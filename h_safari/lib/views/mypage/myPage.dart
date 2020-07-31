import 'package:flutter/material.dart';
import 'package:h_safari/views/mypage/asking.dart';
import 'package:h_safari/views/mypage/favoriteCategory.dart';
import 'package:h_safari/views/mypage/resetPW.dart';
import 'package:h_safari/views/mypage/terms_of_use.dart';
import 'package:firebase_auth/firebase_auth.dart';

//from SH
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/delete/email.dart';

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  FirebaseProvider fp;
  String currentId;


  Widget appBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    currentId = currentUser.email.replaceAll("@handong.edu", "");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar('마이페이지'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Student Number',
                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                  Text(
                    '$currentId님',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(7)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            '내가 쓴 글',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          decoration: BoxDecoration(border: Border(
                            right: BorderSide(style: BorderStyle.solid, color: Colors.black12),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          child: Text(
                            '관심 글',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          decoration: BoxDecoration(border: Border(
                            right: BorderSide(style: BorderStyle.solid, color: Colors.black12),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            '거래 글',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('알림 설정'),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('선호 카테고리 설정'),
              onTap: () {
                showFavorite(currentUser.email);
              },
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('비밀번호 재설정'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => resetPW()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('문의하기'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => asking()));
              },
            ),
            ListTile(
              leading: Icon(Icons.filter_frames),
              title: Text('이용 약관'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Terms()));
              },
            ),
            ListTile(
                leading: Icon(Icons.accessibility),
                title: Text('로그아웃'),
                onTap: () {
                  fp.signOut();
                }),
          ],
        ),
      ),
    );
  }

  void showFavorite(String email){
    Firestore.instance
        .collection("users")
        .document(email)
        .get()
        .then((doc) {
      moveFavorite(doc);
    });
  }
  void moveFavorite(DocumentSnapshot doc){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteCategory(doc)));
  }
}
