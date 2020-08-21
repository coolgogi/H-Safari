import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:provider/provider.dart';
import 'package:h_safari/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  getMyIcon(String type) {
    if (type == "구매신청")
      return Icons.record_voice_over;
    else if (type == "댓글")
      return Icons.comment;
    else if (type == "마감")
      return Icons.done;
    else if (type == "거래수락") return Icons.favorite;
  }

  getTitle(String type) {
    if (type == "구매신청")
      return "누군가 구매를 희망합니다.\n게시글의 대기리스트를 확인하세요!";
    else if (type == "댓글")
      return "게시글에 댓글이 달렸습니다.";
    else if (type == "마감")
      return "게시글이 마감되었습니다";
    else if (type == "거래수락") return "거래가 수락되었어요, 채팅방을 통해 거래를 진행하세요!";
  }

  Widget alertTile(String type, String sendBy, String time, String postName,
      String postID, bool unread, String documentID) {
    return FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: unread ? Colors.yellow[50] : Colors.white,
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
                getMyIcon(type),
                color: Colors.brown,
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$type  (게시글: $postName) ",
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
                ),
                Text(
                  getTitle(type),
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 10, color: Colors.black45),
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

  void showDocument(String documentID, String type) {
    Firestore.instance
        .collection('post')
        .document(documentID)
        .get()
        .then((doc) {
      if (!doc.exists) {
        warning(context);
      } else
        showReadPostPage(doc, documentID, type);
    });
  }

  void showReadPostPage(DocumentSnapshot doc, String documentID, String type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                type == "구매신청" ? Post(doc, true) : Post(doc, false)));
  }

  void warning(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('삭제된 게시글입니다!'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context, '확인');
                },
              )
            ],
          );
        });
  }
}
