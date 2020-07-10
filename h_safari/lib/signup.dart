import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _color = Colors.black12;
  final _formkey = GlobalKey<FormState>();
  bool _agree = false;
  final _pwkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                //decoration: kBoxDecorationStyle,
                //height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("닉네임: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '닉네임은 다시 변경할 수 없습니다.',
                              ),
                              validator: (value) {
                                if(value.isEmpty) {return '닉네임을 입력하지 않았습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30),

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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                color: _color,
                                child: Text('인증번호 발송', style: TextStyle(fontSize: 15),),
                                onPressed: () {
                                  Scaffold.of(_formkey.currentContext).showSnackBar(SnackBar(content: Text('학번@handong.edu로 인증 메일을 발송하였습니다.'),));
                                }
                              ),
                            ]
                          ),

                          SizedBox(height: 30,),

                          Text("인증코드: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '메일로 발송된 인증번호를 입력하세요.',
                              ),
                              validator: (value) {
                                if(value.isEmpty) {return '메일로 발송된 인증번호를 입력하세요.';}},
                            ),
                          ),

                          SizedBox(height: 30,),

                          Text("비빌번호: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '비밀번호를 입력하세요.',
                              ),
                              validator: (_pwkey) {
                                if(_pwkey.isEmpty) {return '비밀번호를 입력하지 않았습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30),

                          Text("비빌번호 확인: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '비밀번호를 입력하세요.',
                              ),
                              validator: (value) {
                                if(value != _pwkey) {return '비밀번호가 일치하지 않습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RawMaterialButton(
                                child: Text('이용약관 보기',
                                  style:
                                  TextStyle(fontSize: 15, decoration: TextDecoration.underline),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyClause()));
                                },
                              ),

                              Row(
                                children: [
                                  Text('약관에 동의합니다.'),
                                  Checkbox(
                                    key: null,
                                    value: _agree,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _agree = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ]
                          ),

                          SizedBox(height: 30,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                },
                                child: Text('회원가입', style: TextStyle(fontSize: 15),),
                              ),

                              /*RaisedButton(
                                onPressed: () {
                                  if(_idkey.currentState.validate() && _pwkey.currentState.validate()) {
                                    Scaffold.of(_idkey.currentContext).showSnackBar(SnackBar(content: Text('아이디 혹은 비밀번호가 잘못 되었습니다.'),));
                                  }
                                },
                                child: Text('로그인'),
                              ),*/
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ),
      ),
    );
  }
}


class MyClause extends StatefulWidget {
  @override
  _MyClauseState createState() => _MyClauseState();
}

class _MyClauseState extends State<MyClause> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('이용약관'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
                '제1장 총칙\n\n제1조(목적)\n본 약관은 정부24 (이하 "당 사이트")가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n제2조(용어의 정의)\n본 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n\n① 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 이용할 수 있는 자'
                    '\n아니 더 길게 안되나\n 좀 더 길게\n 실험을 해봅시다\n 배고프다\n 아니 근데 이거 스크롤이 아니라\n 그냥 박스가 길어지는데\n'
            ),
          ),
        ),
      ),
    );
  }
}