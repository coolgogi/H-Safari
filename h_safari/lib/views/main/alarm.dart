import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:h_safari/views/category/category_model/category1.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('알림')
        ),
        body: ListView(
          children: <Widget>[
            alarmlist(),
          ],
        )
    );
  }
}


// alarmlist : 각각 전송되는 알람의 형태와 기능.
class alarmlist extends StatefulWidget {
  @override
  _alarmlistState createState() => _alarmlistState();
}

class _alarmlistState extends State<alarmlist> {
  Color color = Colors.black12; // 기본 배경색

  @override
  Widget build(BuildContext context) {
    return Container(

      color: color, // 기본 배경색 : color
      child: ListTile( // 알람 : ListTile
        title: Row(
          children: <Widget>[
            Container(

              width: 265,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person, // 아이콘 종류
                    color: Colors.lightBlueAccent,
                    size: 35,// 아이콘 색
                  ),
                  SizedBox(
                    width: 10,
                  ),// 아이콘과 글자들 사이의 박스 삽입

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
                    children: <Widget>[
                      Text(
                        '원피스 싸게 팔아요~', // 게시물 제목
                        style: TextStyle(fontSize: 15), // 게시물 제목 스타일 지정
                      ),
                      Text(
                        'OOO님이 댓글을 남기셨습니다.', // 알람 내용
                        style: TextStyle(fontSize: 10, color: Colors.black45), // 알림 내용 스타일 지정
                      ),
                    ],
                  )
                ],
              ),
            ),// 아이콘
            Container(
                child: Text('7월 15일'))


          ],
        ),
        

        onTap: () { // 클릭 시 변화림
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => category1())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
            color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화
          });
        },
      ),
    );
  }
}
