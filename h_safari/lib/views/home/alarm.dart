// 기본 import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 알림과 firebase 연결 import
import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/delete/post(writer).dart';
import 'package:h_safari/views/post/post.dart';
import 'package:provider/provider.dart';
import 'package:h_safari/services/database.dart';
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
  String userEmail;

  Widget alarmList() {
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp.getUser().email.toString();
    return StreamBuilder<QuerySnapshot>(
      stream: alarm,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView(
                shrinkWrap: true,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return alertTile(
                    document['type'],
                    document['sendBy'],
                    document['time'],
                    document['postName'],
                    document['postID'],
                    document['unread'],
                    document.documentID,
                  );
                }).toList(),
              )
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

  IconData getMyIcon(String type) {
    if (type == "구매신청")
      return Icons.notifications_active;
    else if (type == "댓글")
      return Icons.comment;
    else if (type == "마감") return Icons.done;
  }

  Widget alertTile(String type, String sendBy, String time, String postName,
      String postID, bool unread, String documentID) {
    return FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: unread ? Colors.yellow[50] : Colors.white, // 기본 배경색 : color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 0.5,
                    )
                  ]),
              child: Icon(
                getMyIcon(type), // 아이콘 종류
                color: Colors.brown, // 아이콘 색
              ),
            ), // 아이콘
            SizedBox(
              width: 14,
            ), // 아이콘과 글자들 사이의 박스 삽입
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
              children: <Widget>[
                Text(
                  type, // 게시물 제목
                  style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold), // 게시물 제목 스타일 지정
                ),
                Text(
                  "게시글: $postName", // 알람 내용
                  style: TextStyle(fontSize: 13), // 알림 내용 스타일 지정
                ), // 아이콘과 글자들 사이의 박스 삽입
                Text(
                  time, // 시간
                  style: TextStyle(
                      fontSize: 10, color: Colors.black45), // 시간 스타일 지정
                ),
              ],
            ),
          ],
        ),
        onPressed: () {
          showDocument(postID, type);
          DatabaseMethods().updateUnreadAlram(userEmail, documentID);
        });
  }

  // 문서 조회 (Read)
  void showDocument(String documentID, String type) {
    Firestore.instance
        .collection('post')
        .document(documentID)
        .get()
        .then((doc) {
      showReadPostPage(doc, documentID, type);
    });
  }

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc, String documentID, String type) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => type != '거래수락' ? Post(doc, true) : Post(doc, false)));
  }
}
