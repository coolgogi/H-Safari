import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:h_safari/widget/widget.dart';

class FindPw extends StatefulWidget {
  @override
  _FindPwState createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, '비밀번호 재설정'),
      body: forgotBody(_formkey),
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
              "학번: ",
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
                  return value.isEmpty ? '학번을 입력하지 않았습니다.' : null;
                },
                controller : _controller,
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
                          onPressed: () {
                            String settingEmail = _controller.text + "@handong.edu";
                            fAuth.sendPasswordResetEmail(email: settingEmail);
                            Navigator.pop(context);
                          },
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

}

