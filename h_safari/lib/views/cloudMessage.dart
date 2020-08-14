import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:h_safari/models/firebase_provider.dart';

FcmFirstDemoState pageState;

class CloudMessage{
  FirebaseProvider fp;
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // Firestore users fields
  final String fName = "name";
  final String fToken = "token";
  final String fCreateTime = "createTime";
  final String fPlatform = "platform";

  Map<String, bool> _map = Map();


  // Cloud Functions
  final HttpsCallable sendFCM = CloudFunctions.instance
      .getHttpsCallable(functionName: 'sendFCM') // 호출할 Cloud Functions 의 함수명
    ..timeout = const Duration(seconds: 30); // 타임아웃 설정(옵션)

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

}





class FcmFirstDemo extends StatefulWidget {
  @override
  FcmFirstDemoState createState() {
    pageState = FcmFirstDemoState();
    return pageState;
  }
}

class FcmFirstDemoState extends State<FcmFirstDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;
  bool didUpdateUserInfo = false;

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // Firestore users fields
  final String fName = "user";
  final String fToken = "token";
  final String fCreateTime = "가입일";
  final String fPlatform = "platform";

  final TextStyle tsTitle = TextStyle(color: Colors.grey, fontSize: 13);
  final TextStyle tsContent = TextStyle(color: Colors.blueGrey, fontSize: 15);

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
//    if (didUpdateUserInfo == false) updateUserInfo();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("FcmFirstDemo")),
      body: Column(
        children: <Widget>[
          Container(
            child: ListTile(
                title: Text("Auth UID"),
                subtitle: Text(
                    (fp.getUser() != null) ? fp.getUser().email : "")),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.collection("users").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                    break;
                  default:
                    return ListView(
                      children:
                      snapshot.data.documents.map((DocumentSnapshot doc) {
//                        Timestamp ts = doc[fCreateTime];
//                        String dt = timestampToStrDateTime(ts);
                        String dt = doc[fCreateTime];

                        if (!_map.containsKey(doc[fToken])) {
                          _map[doc[fToken]] = false;
                        }

                        return Card(
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 80,
                                            child: Text("Name", style: tsTitle),
                                          ),
                                          Expanded(
                                              child: Text(doc[fName],
                                                  style: tsContent))
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 80,
                                            child: Text("platform",
                                                style: tsTitle),
                                          ),
                                          Expanded(
                                              child: Text(doc[fPlatform],
                                                  style: tsContent))
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 80,
                                            child: Text("createAt",
                                                style: tsTitle),
                                          ),
                                          Expanded(
                                              child: Text(dt, style: tsContent))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  value: _map[doc[fToken]],
                                  onChanged: (flag) {
                                    setState(() {
                                      print(flag);
                                      _map[doc[fToken]] = flag;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.message),
                                  tooltip: "custom message",
                                  onPressed: () {
                                    showMessageEditor(doc[fToken]);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  tooltip: "send a sample message",
                                  onPressed: () {
                                    sendSampleFCM(doc[fToken]);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text("Send Sample FCM to Selected Device"),
              onPressed: sendSampleFCMtoSelectedDevice,
            ),
          )
        ],
      ),
    );
  }

  void updateUserInfo() async {
    print("업데이트");
    if (fp.getUser() == null) return;
    String token = await _fcm.getToken();
    if (token == null) return;

    var user = _db.collection("users2").document(fp.getUser().uid);
    await user.setData({
      fName: fp.getUser().email,
      fToken: token,
      fCreateTime: FieldValue.serverTimestamp(),
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