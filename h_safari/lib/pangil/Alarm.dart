import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
// var myList = List.generate(5, (index) => index * 2); print(myList); -> [0, 2, 4, 6, 8]과 같은 형태의 함수.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('알람'),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            indicatorPadding: EdgeInsets.only(left: 30, right: 30),
            indicator: ShapeDecoration(
                color: Colors.lightBlueAccent,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            labelStyle: TextStyle(fontSize: 15, height: 1),
            tabs: <Widget>[
              Tab(text: '알림함'),
              Tab(text: '쪽지함'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    alarmIcon(),
                    alarmIcon()
                    //from SH
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    alarmIcon(),
                    alarmIcon()
                    //from SH
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget alarmIcon() {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(Icons.person, color: Colors.lightBlueAccent,),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('hello', style: TextStyle(fontSize: 15),),
            Text('Send to me. my name is kim kwang il. I wanna see you!',
              style: TextStyle(
                  fontSize: 10, color: Colors.black45),
            ),
          ],
        )
      ],
    ),
    onTap: () {

    },
  );
}