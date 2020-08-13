// SH
// 2020-07-13
// 로그인 되어있는지 아닌지 확인하는 페이지.
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:h_safari/views/signIn.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/views/post/post.dart';

import 'package:provider/provider.dart';
import 'bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;
  bool didUpdateUserInfo = false;

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  final String fnEmail = "user";
  final String fToken = "token";
  final String fPlatform = "platform";

  // Cloud Functions
  final HttpsCallable sendFCM = CloudFunctions.instance
      .getHttpsCallable(functionName: 'sendFCM') // 호출할 Cloud Functions 의 함수명
    ..timeout = const Duration(seconds: 30); // 타임아웃 설정(옵션)

  TextEditingController _titleCon = TextEditingController();
  TextEditingController _bodyCon = TextEditingController();

  Map<String, bool> _map = Map();

  @override
  void initState() {
    super.initState();

    // FCM 수신 설정
    _fcm.configure(
      // 앱이 실행중일 경우
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message["notification"]["title"]),
              subtitle: Text(message["notification"]["body"]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      },
      // 앱이 완전히 종료된 경우
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      // 앱이 닫혀있었으나 백그라운드로 동작중인 경우
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    if (didUpdateUserInfo == false) updateUserInfo();

    logger.d("user: ${fp.getUser()}");

    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
      String tp = fp.getUser().email.toString();

      return BottomBar(tp);
    } else {
      return SignIn();
    }
  }

  void updateUserInfo() async {
    print("업데이트");
    if (fp.getUser() == null) return;
    String token = await _fcm.getToken();
    if (token == null) return;

    var user = _db.collection("users").document(fp.getUser().email);
    await user.updateData({
      fToken: token,
      fPlatform: Platform.operatingSystem
    });
    setState(() {
      didUpdateUserInfo = true;
    });
  }


  void showMessageEditor(String token) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Create FCM"),
          content: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Title"),
                  controller: _titleCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Body"),
                  controller: _bodyCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _titleCon.clear();
                _bodyCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Send"),
              onPressed: () {
                if (_titleCon.text.isNotEmpty && _bodyCon.text.isNotEmpty) {
                  sendCustomFCM(token, _titleCon.text, _bodyCon.text);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  // token에 해당하는 디바이스로 FCM 전송
  void sendSampleFCM(String token) async {
    final HttpsCallableResult result = await sendFCM.call(
      <String, dynamic>{
        fToken: token,
        "title": "Sample Title",
        "body": "This is a Sample FCM"
      },
    );
  }

  // ken리스트에 해당하는 디바이스들로 FCM 전송
  void sendSampleFCMtoSelectedDevice() async {
    List<String> tokenList = List<String>();
    _map.forEach((String key, bool value) {
      if (value) {
        tokenList.add(key);
      }
    });
    if (tokenList.length == 0) return;
    final HttpsCallableResult result = await sendFCM.call(
      <String, dynamic>{
        fToken: tokenList,
        "title": "Sample Title",
        "body": "This is a Sample FCM"
      },
    );
  }

  // koen에 해당하는 디바이스로 커스텀 FCM 전송
  void sendCustomFCM(String token, String title, String body) async {
    if (title.isEmpty || body.isEmpty) return;
    final HttpsCallableResult result = await sendFCM.call(
      <String, dynamic>{
        fToken: token,
        "title": title,
        "body": body,
      },
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    if (ts == null) return "";
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
}