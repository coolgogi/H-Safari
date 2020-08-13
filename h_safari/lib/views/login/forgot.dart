import 'package:flutter/material.dart';

//메일 발송 백엔드는 아직 미구현
class FindPw extends StatefulWidget {
  @override
  _FindPwState createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  final _formkey = GlobalKey<FormState>();

//page 구성부분
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForgot(context, '비밀번호 찾기'),
      body: forgotBody(_formkey),
    );
  }
}

Widget appBarForgot(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: TextStyle(color: Colors.green)),
    iconTheme: IconThemeData(color: Colors.green),
    backgroundColor: Colors.white,
    elevation: 1,
    centerTitle: true,
  );
}

Widget forgotBody(final _formkey) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "아이디: ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '학번을 입력하세요.',
                helperText: ' ',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '아이디를 입력하지 않았습니다.';
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: ButtonTheme(
              minWidth: 150,
              height: 40,
              child: RaisedButton(
                color: Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Colors.green,
                    )),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Scaffold.of(_formkey.currentContext).showSnackBar(SnackBar(
                      content: Text(
                        '비밀번호 변경 메일을 발송하였습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                      action: SnackBarAction(
                        label: '확인',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: Text(
                  '확인',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
