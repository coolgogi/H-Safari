import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:h_safari/pangil/category/category1.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  Color color = Colors.black12;
  Color color1 = Colors.black12;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('알림')
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: color,
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '원피스 싸게 팔아요~',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'OOO님이 댓글을 남기셨습니다.',
                          style: TextStyle(fontSize: 10, color: Colors.black45),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: () {
                  setState(() {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => category1()));
                      color = Colors.white;
                  });
                },
              ),
            ),
            Container(
              color: color1,
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '그할마에 위치한 집 양도합니다',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'OOO님이 좋아요를 눌렀습니다.',
                          style: TextStyle(fontSize: 10, color: Colors.black45),
                        ),
                      ],
                    ),

                  ],
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => category1()));
                    color1 = Colors.white;

                  });
                },
              ),
            )
          ],
        )
    );
  }
}

