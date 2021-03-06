import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:h_safari/views/mypage/myPost.dart';
import 'package:h_safari/views/mypage/myWanna.dart';
import 'package:h_safari/views/mypage/favoriteCategory.dart';
import 'package:h_safari/views/mypage/terms_of_use.dart';
import 'package:h_safari/views/mypage/privacyPolicy.dart';

class MyPage extends StatefulWidget {
  String email;
  MyPage(String email) {
    email = email;
  }

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  FirebaseProvider fp;
  String currentId;
  bool _isSwitchedNum = true;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .get()
        .then((doc) {
      setState(() {
        _isSwitchedNum = doc['마감'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    User currentUser = fp.getUser();
    int idx = currentUser.email.indexOf("@");
    currentId = currentUser.email.substring(0, idx);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMain('마이페이지'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 7, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('환영합니다!',
                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                  Text(
                    '$currentId님',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyPost(currentUser.email)));
                      },
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Text(
                          '내가 쓴 게시글',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                          right: BorderSide(
                              style: BorderStyle.solid, color: Colors.black12),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyWanna(currentUser.email)));
                      },
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Text(
                          '거래신청한 게시글',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.thumb_up),
              title: Text('선호 카테고리 설정'),
              onTap: () {
                showFavorite(currentUser.email);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('홈 마감글 On/Off'),
                  Switch(
                    value: _isSwitchedNum,
                    onChanged: (value) {
                      setState(() {
                        _isSwitchedNum = value;
                      });
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(fp.getUser().email)
                          .update({
                        "마감": _isSwitchedNum,
                      });
                    },
                    activeTrackColor: Colors.green[100],
                    activeColor: Colors.green[400],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('비밀번호 재설정'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("비밀번호 재설정"),
                      content: Container(child: Text("비밀번호 재설정 메일을 보내시겠습니까?")),
                      actions: <Widget>[
                        FlatButton(
                          child:
                              Text("취소", style: TextStyle(color: Colors.green)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "확인",
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            fp.sendPasswordResetEmail();
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("전송 완료!"),
                                content: Container(
                                  child: Text("이메일을 확인하세요!"),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "확인",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('개인정보처리방침'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()));
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
              leading: Icon(Icons.help_outline),
              title: Text('문의하기'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("문의하기"),
                      content: Container(
                          child: Text(
                              "HandongSafari@gmail.com로 문의 메일을 보내주시면 성심성의껏 답변해 드리겠습니다:)")),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "확인",
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.close),
                title: Text('로그아웃'),
                onTap: () {
                  fp.signOut();
                  var user = FirebaseFirestore.instance
                      .collection("users")
                      .doc(fp.getUser().email);
                  user.update({"token": "", "platform": ""});
                }),
          ],
        ),
      ),
    );
  }

  void showFavorite(String email) {
    FirebaseFirestore.instance.collection("users").doc(email).get().then((doc) {
      moveFavorite(doc);
    });
  }

  void moveFavorite(DocumentSnapshot doc) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FavoriteCategory(doc)));
  }

  Widget checkOk() {
    return AlertDialog(
      title: Text("전송되었습니다"),
      content: Container(height: 200, child: Text("")),
      actions: <Widget>[
        FlatButton(
            child: Text("확인"),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}
