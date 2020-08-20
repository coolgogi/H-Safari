//안씀
//import 'package:flutter/material.dart';
//import 'package:h_safari/widget/widget.dart';
//
//class ResetPW extends StatefulWidget {
//  @override
//  _ResetPWState createState() => _ResetPWState();
//}
//
//class _ResetPWState extends State<ResetPW> {
//  var _blankFocusnode = new FocusNode(); //키보드 없애는 용
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        FocusScope.of(context).requestFocus(_blankFocusnode);
//      },
//      child: Scaffold(
//        appBar: appBar(context, '비밀번호'),
//        body: SingleChildScrollView(
//          child: Padding(
//            padding: EdgeInsets.all(8.0),
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                inputTextField('변경 전'),
//                inputTextField('변경 후'),
//                inputTextField('변경 후 확인'),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    FlatButton(
//                      child: Text('취소'),
//                      color: Colors.green[200],
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('저장'),
//                      color: Colors.green[200],
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                    )
//                  ],
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget inputTextField(String title) {
//    return Container(
//      height: 60,
//      child: Padding(
//        padding: EdgeInsets.all(8.0),
//        child: TextField(
//          decoration: InputDecoration(
//            border: OutlineInputBorder(),
//            labelText: '$title',
//          ),
//        ),
//      ),
//    );
//  }
//}
