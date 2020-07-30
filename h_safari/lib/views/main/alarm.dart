// 기본 import
import 'package:flutter/material.dart';

// 알림과 firebase 연결 import
import 'package:h_safari/models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:h_safari/views/chat/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
xw
// widget import
import 'package:h_safari/widget/widget.dart';

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
        appBar: appBar(context, '알림'),

        body: Container(
            child: alarmList(),
        ),
    );
  }
}



