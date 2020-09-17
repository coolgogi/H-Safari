import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/services/database.dart';
import 'package:h_safari/views/chat/chatRoom.dart';

// ignore: must_be_immutable
class Waiting extends StatefulWidget {
  String documentID;
  String postName;
  List userList;

  Waiting(String id, String fnName, List waitingUserList) {
    documentID = id;
    postName = fnName;
    userList = waitingUserList;
  }

  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  FirebaseProvider fp;
  String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, '대기신청자'),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.userList.length,
            itemBuilder: (context, index) {
              return waitingTile(
                index + 1,
                widget.userList[index],
              );
            }),
      ),
    );
  }

  Widget waitingTile(int turn, String sendBy) {
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp.getUser().email.toString();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$turn번째 신청자',
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            shape: OutlineInputBorder(),
            child: Text(
              '거래하기',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              transaction(context, sendBy, turn);
            },
          ),
        ],
      ),
    );
  }

  void transaction(BuildContext context, String sendBy, int turn) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('거래를 위한 채팅방을 만드시겠습니까?'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '취소',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context, '취소');
                },
              ),
              FlatButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Map<String, dynamic> transaction = {
                    "postName": widget.postName,
                    "type": "거래수락",
                    "sendBy": sendBy,
                    "time": new DateFormat('yyyy-MM-dd')
                        .add_Hms()
                        .format(DateTime.now()),
                    "postID": widget.documentID,
                    "unread": true,
                  };
                  DatabaseMethods().sendNotification(sendBy, transaction);
                  DatabaseMethods().updateUnreadNotification(sendBy, true);
                  Navigator.pop(context, '확인');
                  Navigator.pop(context, '확인');
                  Navigator.pop(context, '확인');
                  sendMessage(sendBy, turn, widget.postName);
                },
              )
            ],
          );
        });
  }

  void sendMessage(String friendEmail, int turn, String postName) async {
    User user = FirebaseAuth.instance.currentUser;
    String _user = user.email.toString();
    List<String> users = [_user, friendEmail];
    String chatRoomName = "$turn번째_$postName";
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomName": chatRoomName,
    };
    databaseMethods.addChatRoom(chatRoom, chatRoomName);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatRoom(
                  chatRoomId: chatRoomName,
                  chatRoomName: chatRoomName,
                )));
  }
}
