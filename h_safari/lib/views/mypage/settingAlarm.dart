import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/helpers/firebase_provider.dart';


class SettingAlarm extends StatefulWidget {
  @override
  _SettingAlarmState createState() => _SettingAlarmState();
}

class _SettingAlarmState extends State<SettingAlarm> {

  FirebaseProvider fp;
  final List<bool> _isSwitchedNum = [true, true, true, true, true, false];

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    Firestore.instance.collection("users").document(fp.getUser().email).get().then((doc) {
      _isSwitchedNum[5] = doc["마감"];
      setState((){});
    });
    return Scaffold(
      appBar: appBar(context, '알림설정'),
      body: Column(
        children: <Widget>[
          setAlarm(context, '전체알림', 0),
          setAlarm(context, '공지알림', 1),
          setAlarm(context, '댓글알림', 2),
          setAlarm(context, '물품마감알림', 3),
          setAlarm(context, '구매신청알림', 4),
          setAlarm(context, '마감된 글 보기', 5),
        ],
      ),
    );
  }

  Widget setAlarm(BuildContext context, String title, int num) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[300]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('$title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
            Container(
              child: Transform.scale(
                scale: 1.3,
                child: Switch(
                  value: _isSwitchedNum[num],
                  onChanged: (value) {
                    setState(() {
                      _isSwitchedNum[num] = value;
                    });
                    Firestore.instance.collection("users").document(fp.getUser().email).updateData({
                      "마감" : _isSwitchedNum[5],
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent[100],
                  activeColor: Colors.green[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mySize(int size) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / size,
    );
  }
}
