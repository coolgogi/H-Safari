import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:h_safari/views/category/category_model/category1.dart';
import 'package:h_safari/views/main/home.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
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

  Widget appBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: InkWell(
        child: Icon(
          Icons.cake,
          color: Colors.green,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Center(
            child: Text(
              '$title',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar('알림'),

        body: Container(
            child: alarmList(),
        ),
    );
  }
}



class alertTile extends StatelessWidget {
  final String type;
  final String sendBy;
  final String time;
  final String postName;

  alertTile({this.type, this.sendBy, this.time, this.postName});
  Color color = Colors.green[300]; // 기본 배경색

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: FlatButton(
            color: color, // 기본 배경색 : color
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.person, // 아이콘 종류
                    color: Colors.white, // 아이콘 색
                  ),// 아이콘
                  SizedBox(
                    width: 10,
                  ),// 아이콘과 글자들 사이의 박스 삽입

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
                    children: <Widget>[
                      Text(
                        '$postName', // 게시물 제목
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), // 게시물 제목 스타일 지정
                      ),
                      Text(
                        '$type', // 알람 내용
                        style: TextStyle(fontSize: 10, color: Colors.black45), // 알림 내용 스타일 지정
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '$time', // 시간
                style: TextStyle(fontSize: 10, color: Colors.black45), // 시간 스타일 지정
              )
            ],
          ),
            onPressed: () { // 클릭 시 변화림
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    category1())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
                color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화

            }
        ),
      ),
    );
  }
}
