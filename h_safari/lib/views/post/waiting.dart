import 'dart:math';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/services/database.dart';
import 'package:h_safari/views/chat/chatRoom.dart';

class Waiting extends StatefulWidget {

  String documentID;

  Waiting(String id) {
    documentID = id;
  }

  @override
  _WaitingState createState() => _WaitingState(documentID);
}

class _WaitingState extends State<Waiting> {


  String documentID;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  _WaitingState(String id) {
    documentID = id;
  }

  //  List<String> test = ['신청자1', '신청자2', '신청자3', '신청자4', '신청자5'];
//  List<String> test = List();


  Stream waitingUserList;
  FirebaseProvider fp;
  String userEmail;


  Widget waitingList() {
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp
        .getUser()
        .email
        .toString();

    return StreamBuilder<QuerySnapshot>(
      stream: waitingUserList,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView(
          shrinkWrap: true,
          children:
          snapshot.data.documents.map((DocumentSnapshot document) {
            return waitingTile(
              document['sendBy'],
              document['time'],
              document.documentID,
            );
          }).toList(),
        ) : Container();
      },
    );
  }

  @override //??
  void initState() {
    getWaitingList(documentID);
    super.initState();
  }

  getWaitingList(String documentID) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseMethods().getWaitingList(documentID).then((snapshots) {
      setState(() {
        waitingUserList = snapshots;
        print(
            "we got the data + ${waitingUserList.toString()} this is name  $documentID");
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar(context, '대기신청자'),
        body: Container(
          child: waitingList(),
        ),

    ); //Scaffold
  }

  Widget waitingTile(String sendBy, String time, String documentID) {
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp.getUser().email.toString();

    return FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: true ? Colors.yellow[50] : Colors.white, // 기본 배경색 : color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 14,
            ), // 아이콘과 글자들 사이의 박스 삽입
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
              children: <Widget>[
                Text(
                  sendBy, // 게시물 제목
                  style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold), // 게시물 제목 스타일 지정
                ),
                Text(
                  time, // 알람 내용
                  style: TextStyle(fontSize: 13), // 알림 내용 스타일 지정
                ),
              ],
            ),
          ],
        ),
        onPressed: () {
          sendMessage(sendBy);
        });
  }

  void sendMessage(String email) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String _user = user.email.toString();

    List<String> users = [_user, email];

    String chatRoomId = getChatRoomId(_user, email);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            ChatRoom(chatRoomId: chatRoomId,)));
  }
}

String getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

