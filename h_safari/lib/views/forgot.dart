import 'package:flutter/material.dart';

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
      appBar: appBarForgot(context, '비밀번호를 까먹었을 때'),
      body: forgotBody(_formkey),
    );
  }
}

Widget appBarForgot(BuildContext context, String title){
  return AppBar(
    title: Text(title),
    elevation : 0.0,
    centerTitle: true,
  );
}

Widget forgotBody(final _formkey){
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("아이디: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '학번을 입력하세요.',
              ),
              validator: (value) {
                if(value.isEmpty) {return '아이디를 입력하지 않았습니다.';}},
            ),
          ),

          SizedBox(height: 30,),

          Center(
            child: RaisedButton(
              onPressed: () {
                Scaffold.of(_formkey.currentContext).showSnackBar(SnackBar(content: Text('학번@handong.edu로 인증 메일을 발송하였습니다.'),));
              },
              child: Text('확인', style: TextStyle(fontSize: 15),),
            ),
          ),

          SizedBox(height: 30,),

          Text("인증번호 확인: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: '메일로 발송된 인증번호를 입력 오네가이시마스'
             ),
            ),
          ),
        ],
      ),
    ),
  );
}