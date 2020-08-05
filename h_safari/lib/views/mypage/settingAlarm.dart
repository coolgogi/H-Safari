import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';
import 'dart:math';

class settingAlarm extends StatefulWidget {
  @override
  _settingAlarmState createState() => _settingAlarmState();
}

class _settingAlarmState extends State<settingAlarm> {

  // _isSwitchedNum : 알림설정 스위치 별 bool 값을 가지고 있는 리스트
  final List<bool> _isSwitchedNum = [
    true,
    true,
    true,
    true,
    true
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, '알림설정'),
      body: Column(
        children: <Widget>[
          SetAlarm(context, '전체알림', 0),
          SetAlarm(context, '공지알림', 1),
          SetAlarm(context, '댓글알림', 2),
          SetAlarm(context, '물품마감알림', 3),
          SetAlarm(context, '구매신청알림', 4),
        ],
      ),
    );
  }

  // SetAlarm : 알림설정 문구 & 스위치 위젯
  // title(알림문구), num(알림설정 순서)
  Widget SetAlarm(BuildContext context, String title, int num){

    return Row(
      children: <Widget>[
        // mySize(4) : 화면 width의 4분의 1크기만큼 자리차지
        mySize(4),


        // Container : 알림문구를 감싸고 역할
        Container(
            width:MediaQuery.of(context).size.width / 4,
            child: Text('$title')),

        // mySize(8) : 화면 width의 8분의 1크기만큼 자리차지
        mySize(8),
        // Container : Switch를 감싸고 역할
        Container(
          child: Switch(
            //value : _isSwitchedNum[num]의 기본값 저장 (true)
            value: _isSwitchedNum[num],

            // onChanged : 눌렀을 경우 value값을 가져와 _isSwitchedNum[num]에 지정하여 값을 변경
            onChanged: (value) {
              setState(() {
                _isSwitchedNum[num] = value;
              });
            },

            // activeTrackColor : Switch 라인색
            activeTrackColor: Colors.lightGreenAccent[100],

            // activeColor : Switch 버튼색
            activeColor: Colors.green[400],
          ),
        ),
      ],
    );
  }

  // SizedBox width 크기 지정 위젯
  Widget mySize(int size) {
    return SizedBox(
      width: MediaQuery.of(context).size.width /size,
    );
  }

}

