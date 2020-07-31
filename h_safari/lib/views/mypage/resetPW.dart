import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class resetPW extends StatefulWidget {
  @override
  _resetPWState createState() => _resetPWState();
}

class _resetPWState extends State<resetPW> {
  var _blankFocusnode = new FocusNode(); //키보드 없애는 용
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
        appBar: appBar(context, '비밀번호'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '변경 전',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '변경 후',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '확인',
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Text('취소'),
                      color: Colors.green[200],
                      onPressed: () {

                      },
                    ),
                    FlatButton(
                      child: Text('저장'),
                      color: Colors.green[200],
                      onPressed: () {

                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
