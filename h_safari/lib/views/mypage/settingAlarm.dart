import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/models/firebase_provider.dart';


class settingAlarm extends StatefulWidget {
  @override
  _settingAlarmState createState() => _settingAlarmState();
}

class _settingAlarmState extends State<settingAlarm> {

  FirebaseProvider fp;
  // _isSwitchedNum : 알림설정 스위치 별 bool 값을 가지고 있는 리스트
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
          SetAlarm(context, '전체알림', 0),
          SetAlarm(context, '공지알림', 1),
          SetAlarm(context, '댓글알림', 2),
          SetAlarm(context, '물품마감알림', 3),
          SetAlarm(context, '구매신청알림', 4),
          SetAlarm(context, '마감된 글 보기', 5),
        ],
      ),
    );
  }

  // SetAlarm : 알림설정 문구 & 스위치 위젯
  // title(알림문구), num(알림설정 순서)
  Widget SetAlarm(BuildContext context, String title, int num) {
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
            // Container : 알림문구를 감싸고 역할
            Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('$title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),

            // Container : Switch를 감싸고 역할
            Container(
              child: Transform.scale(
                scale: 1.3,
                child: Switch(
                  //value : _isSwitchedNum[num]의 기본값 저장 (true)
                  value: _isSwitchedNum[num],

                  // onChanged : 눌렀을 경우 value값을 가져와 _isSwitchedNum[num]에 지정하여 값을 변경
                  onChanged: (value) {
                    setState(() {
                      _isSwitchedNum[num] = value;


                    });
                    Firestore.instance.collection("users").document(fp.getUser().email).updateData({
                      "마감" : _isSwitchedNum[5],
                    });
                  },

                  // activeTrackColor : Switch 라인색
                  activeTrackColor: Colors.lightGreenAccent[100],

                  // activeColor : Switch 버튼색
                  activeColor: Colors.green[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SizedBox width 크기 지정 위젯
  Widget mySize(int size) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / size,
    );
  }
}
