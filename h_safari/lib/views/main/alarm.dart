// 기본 import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 알림과 firebase 연결 import
import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/views/post/post(writer).dart';
import 'package:provider/provider.dart';
import 'package:h_safari/views/chat/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// widget import
import 'package:h_safari/widget/widget.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  Stream alarm;
  FirebaseProvider fp;

  Widget alarmList() {
    fp = Provider.of<FirebaseProvider>(context);

    return StreamBuilder(
      stream: alarm,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return alertTile(
                    snapshot.data.documents[index].data['type'],
                    snapshot.data.documents[index].data['sendBy'],
                    snapshot.data.documents[index].data['time'],
                    snapshot.data.documents[index].data['postName'],
                    snapshot.data.documents[index].data['postID'],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetAlarms();
    super.initState();
  }

  getUserInfogetAlarms() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseMethods().getUserAlarms(user.email.toString()).then((snapshots) {
      setState(() {
        alarm = snapshots;
        print(
            "we got the data + ${alarm.toString()} this is name  ${user.email.toString()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, '알림'),
      body: Container(
        child: alarmList(),
      ),
    );
  }

  Widget alertTile(
      String type, String sendBy, String time, String postName, String postID) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: FlatButton(
            color: Colors.green[300], // 기본 배경색 : color
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.person, // 아이콘 종류
                  color: Colors.white, // 아이콘 색
                ), // 아이콘
                SizedBox(
                  width: 10,
                ), // 아이콘과 글자들 사이의 박스 삽입

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
                  children: <Widget>[
                    Text(
                      '$postName', // 게시물 제목
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold), // 게시물 제목 스타일 지정
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '$type', // 알람 내용
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black45), // 알림 내용 스타일 지정
                        ),
                        SizedBox(
                          width: 10,
                        ), // 아이콘과 글자들 사이의 박스 삽입

                        Text(
                          '$time', // 시간
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black45), // 시간 스타일 지정
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              showDocument(postID);
              // 클릭 시 변화림
//                Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                  ())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
//                color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화
            }),
      ),
    );
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection('post')
        .document(documentID)
        .get()
        .then((doc) {
      showReadPostPage(doc, documentID);
    });
  }

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc, String documentID) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyPost(doc, documentID)));
  }
}

//class alertTile extends StatelessWidget {
//  final String type;
//  final String sendBy;
//  final String time;
//  final String postName;
//  final String postID;
//
//  alertTile({this.type, this.sendBy, this.time, this.postName, this.postID});
//
//  Color color = Colors.green[300]; // 기본 배경색
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        showDocument(postID);
//      },
//      child: Container(
//        height: 50,
//        child: Padding(
//          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
//          child: FlatButton(
//              color: color, // 기본 배경색 : color
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Icon(
//                    Icons.person, // 아이콘 종류
//                    color: Colors.white, // 아이콘 색
//                  ), // 아이콘
//                  SizedBox(
//                    width: 10,
//                  ), // 아이콘과 글자들 사이의 박스 삽입
//
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
//                    children: <Widget>[
//                      Text(
//                        '$postName', // 게시물 제목
//                        style: TextStyle(fontSize: 15,
//                            fontWeight: FontWeight.bold), // 게시물 제목 스타일 지정
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(
//                            '$type', // 알람 내용
//                            style: TextStyle(fontSize: 10, color: Colors
//                                .black45), // 알림 내용 스타일 지정
//                          ),
//                          SizedBox(
//                            width: 10,
//                          ), // 아이콘과 글자들 사이의 박스 삽입
//
//                          Text(
//                            '$time', // 시간
//                            style: TextStyle(fontSize: 10, color: Colors
//                                .black45), // 시간 스타일 지정
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//
//                ],
//              ),
//              onPressed: () { // 클릭 시 변화림
////                Navigator.push(context, MaterialPageRoute(builder: (context) =>
////                  ())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
////                color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화
//
//              }
//          ),
//        ),
//      ),
//    );
//  }
//}
