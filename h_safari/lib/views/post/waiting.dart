import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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

  Stream waitingUserList;
  FirebaseProvider fp;
  String userEmail;


  //  List<String> test = ['신청자1', '신청자2', '신청자3', '신청자4', '신청자5'];
  List<String> test = List();

  Widget waitingList(){
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp.getUser().email.toString();

    return StreamBuilder<QuerySnapshot>(
      stream : waitingUserList,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView(
          shrinkWrap: true,
          children :
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

//    // 이름 만드는 리스트
//    var deco = ['귀여운', '잘생긴', '못생긴', '뚱뚱한', '착한', '한동대', '키가 큰', '키가 작은'];
//    var animal = ['토끼', '강아지', '기린', '큰부리새', '김광일?', '코뿔소', '하마', '코끼리', '표범'];
//    // 랜덤 변수 지정
//    final _random = new Random();
//    // 이름 값을 저장하는 리스트. (DB랑 연결되면 DB에 저장이 될 예정)
//    List<String> names = [];
//    for (int j = 1; j <= 10; j++) {
//      // decoWord : 꾸미는 단어 랜덤으로 뽑기
//      var decoWord = deco[_random.nextInt(deco.length)];
//      // animal : 동물 단어 랜덤으로 뽑기
//      var animalWord = animal[_random.nextInt(animal.length)];
//      // userWord : 유저별 랜덤이름
//      var userWord = decoWord + ' ' + animalWord;
//
//      // userWord를 리스트 names에 삽입. (DB랑 연결되면 DB에 추가할 예정)
//      names.add(userWord);
//    }



    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar(context, '대기신청자'),
        body: Container(
          child: waitingList(),
        ),
    ); //Scaffold
  }
//        StreamBuilder(
//          stream: Firestore.instance
//              .collection('post')
//              .document(documentID)
//              .collection("userList")
//              .orderBy("time")
//              .snapshots(),
//          builder: (context, snapshot) {
//            return
////              Center(
////              child:
//                GestureDetector(
//                  child: ListView.builder(
//                    // shrinkWrap : (무슨 역할인지,, 모르겠어요)
//                      shrinkWrap: true,
//                      // itemCount : userName이 저장된 리스트 names의 길이만큼 다이어로그에 보여준다.
////                        itemCount: names.length,
//                      itemCount: snapshot.data.documents.length,
//                      // itemBuilder : userName이 보여지는 공간
//                      itemBuilder: (BuildContext context, int index) {
//                        return Padding(
//                          // padding : padding을 아래 10px 지정
//                            padding: const EdgeInsets.only(
//                                left: 40, right: 40, top: 20),
//                            child: Container(
//                              // ListTile의 스타일 지정
//                              decoration: BoxDecoration(
//
//                                // 모서리 둥근 정도
//                                  borderRadius: BorderRadius.all(
//                                      Radius.circular(10)),
//                                  // 배경색
//                                  color: Colors.green[200]),
//                              height: 55,
//                              width: double.maxFinite,
//                              child: //Text('$test[index]'),
//                              ListTile(
////                                  title: Text('[' +
////                                      (index + 1).toString() +
////                                      '] ' +
////                                      names[index])),
//                                title: Text(snapshot.data.documents[index]
//                                    .data['sendBy']),
//                                subtitle: Text(snapshot.data.documents[index]
//                                    .data['time']),
//                                onTap: () {
////                                  sendMessage(snapshot.data.documents[index]
////                                      .data['sendBy'].toString());
//                                  AlertDialog(
//                                    title : Text("hello"),
//                                  );
//                                },
////                                leading: GestureDetector(
////                                  behavior: HitTestBehavior.translucent,
//
//
////                                  child: Container(
////                                    width: 20,
////                                    height: 48,
//////                                    padding: EdgeInsets.symmetric(vertical: 4.0),
//////                                    alignment: Alignment.center,
//////                                    child: CircleAvatar(),
////                                  ),
////                                ),
//
//                              ), //ListTile
//                            ) //Container
//                        ); //Padding
//                      } //itembuilder
//                  ), //List.view builder
//              ); //GestureDetector
////            ); //center
//          }, //builder
//        ) //streamBuilder
    //  ); //Scaffold
    //}

  IconData getMyIcon(String type) {
    if (type == "구매신청")
      return Icons.notifications_active;
    else if (type == "댓글")
      return Icons.comment;
    else if (type == "마감") return Icons.done;
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
//            Container(
//              padding: EdgeInsets.all(8),
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  shape: BoxShape.circle,
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black38,
//                      spreadRadius: 0.5,
//                    )
//                  ]),
//              child: Icon(
//                getMyIcon(type), // 아이콘 종류
//                color: Colors.brown, // 아이콘 색
//              ),
//            ), // 아이콘
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
                ), // 아이콘과 글자들 사이의 박스 삽입
//                Text(
//                  time, // 시간
//                  style: TextStyle(
//                      fontSize: 10, color: Colors.black45), // 시간 스타일 지정
//                ),
              ],
            ),
          ],
        ),
        onPressed: () {
//          showDocument(postID);
//          DatabaseMethods().updateUnreadAlram(userEmail, documentID);
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
        MaterialPageRoute(builder: (context) => ChatRoom(
              chatRoomId: chatRoomId,
            )));
  }
}

String getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

