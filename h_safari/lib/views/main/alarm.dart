import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:h_safari/views/category/category_model/category1.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import '../../helpers/helperfunctions.dart';
import '../../models/constants.dart';
import '../chat/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  Stream alarm;
  FirebaseProvider fp;

  Widget alarmList(){

    fp = Provider.of<FirebaseProvider>(context);

    return StreamBuilder(
      stream : alarm,
      builder: (context, snapshot){
        return snapshot.hasData
            ? ListView.builder(
              itemCount : snapshot.data.documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return alertTile(
                  type : snapshot.data.documents[index].data['type'],
                  sendBy: snapshot.data.documents[index].data['sendBy'],
                  time: snapshot.data.documents[index].data['time'],
                  postName: snapshot.data.documents[index].data['postName'],
                );
              })
            : Container(
                child: Text("hello world"),
              );
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
<<<<<<< HEAD
        appBar: AppBar(
            title: Text('알림')
        ),
        body: Container(
            child: alarmList(),
        ),
//        ListView(
//          children: <Widget>[
//            alarmlist(),
//          ],
//        )
    );
  }
}


// alarmlist : 각각 전송되는 알람의 형태와 기능.
//class alarmlist extends StatefulWidget {
//  @override
//  _alarmlistState createState() => _alarmlistState();
//}
//
//class _alarmlistState extends State<alarmlist> {
//  Color color = Colors.black12; // 기본 배경색
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Container(
//      color: color, // 기본 배경색 : color
//      child: ListTile( // 알람 : ListTile
//        title: Row(
//          children: <Widget>[
//            Icon(
//              Icons.person, // 아이콘 종류
//              color: Colors.lightBlueAccent, // 아이콘 색
//            ),// 아이콘
//
//            SizedBox(
//              width: 10,
//            ),// 아이콘과 글자들 사이의 박스 삽입
//
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
//              children: <Widget>[
//                Text(
//                  '원피스 싸게 팔아요~', // 게시물 제목
//                  style: TextStyle(fontSize: 15), // 게시물 제목 스타일 지정
//                ),
//                Text(
//                  'OOO님이 댓글을 남기셨습니다.', // 알람 내용
//                  style: TextStyle(fontSize: 10, color: Colors.black45), // 알림 내용 스타일 지정
//                ),
//              ],
//            )
//          ],
//        ),
//
//        onTap: () { // 클릭 시 변화림
//          setState(() {
//            Navigator.push(context, MaterialPageRoute(builder: (context) => category1())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
//            color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화
//          });
//        },
//      ),
//    );//Container
//  }
//}

class alertTile extends StatelessWidget {
  final String type;
  final String sendBy;
  final String time;
  final String postName;

  alertTile({this.type, this.sendBy, this.time, this.postName});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GestureDetector(
      onTap:(){

      },
      child: Container(
        color: Colors.blue, // 기본 배경색 : color
        child: ListTile( // 알람 : ListTile
          title: Row(
            children: <Widget>[
              Icon(
                Icons.person, // 아이콘 종류
                color: Colors.lightBlueAccent, // 아이콘 색
              ),// 아이콘
              SizedBox(
                width: 10,
              ),// 아이콘과 글자들 사이의 박스 삽입

              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
                children: <Widget>[
                  Text(
                    '$postName', // 게시물 제목
                    style: TextStyle(fontSize: 15), // 게시물 제목 스타일 지정
                  ),
                  Text(
                    '$type', // 알람 내용
                    style: TextStyle(fontSize: 10, color: Colors.black45), // 알림 내용 스타일 지정
                  ),
                ],
              )
            ],
          ),
//          onTap: () { // 클릭 시 변화림
//            setState(() {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => category1())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
//              color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화
//            });
//          },
        ),
      ),//Container
    );
  }
}
