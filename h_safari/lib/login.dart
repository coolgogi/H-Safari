import 'package:flutter/material.dart';
import 'package:youtube_flutter/writePost.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _color = Colors.blue;
  final _idkey = GlobalKey<FormState>();
  final _pwkey = GlobalKey<FormState>();
  bool _rememberId = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(child: Text('로그인 창')),
        backgroundColor: _color,
        elevation: 0.0, //숫자가 낮을수록 앱바 밑에 그림자?가 사라지게 함(플랫해진다)
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            //decoration: kBoxDecorationStyle,
            //height: 300,
            child: Padding(
              padding: const EdgeInsets.all(.0),
              child: Form(
                key: _idkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text("ID ", style: TextStyle(fontSize: 30),),
                   SizedBox(height: 10),
                   Container(
                     alignment: Alignment.centerLeft,
                     //decoration: kBoxDecorationStyle,
                     height: 50,
                     child: TextFormField(
                       decoration: InputDecoration(
                         hintText: '아이디를 입력하세요.',
                       ),
                       validator: (value) {
                         if(value.isEmpty) {return 'ID를 입력하지 않았습니다.';}},
                     ),
                   ),

                   SizedBox(height: 30),

                   Text("비밀번호 ", style: TextStyle(fontSize: 30),),
                   SizedBox(height: 10),
                   Container(
                     alignment: Alignment.centerLeft,
                     height: 50,
                     child: TextFormField(
                       decoration: InputDecoration(
                         hintText: '비밀번호를 입력하세요.',
                       ),
                       validator: (value) {
                         if(value.isEmpty) {return '비밀번호를 입력하지 않았습니다.';}},
                     ),
                   ),

                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RawMaterialButton(
                        child: Text('비밀번호 찾기', style: TextStyle(fontSize: 15),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FindPw()));
                        },
                      ),
                      Row(
                        children: [
                          Text('아이디 저장', style: TextStyle(fontSize: 15),), //아니면 자동 로그인?
                          Checkbox(
                            key: null,
                            value: _rememberId,
                            onChanged: (bool value) {
                              setState(() {
                                _rememberId = value;
                              });
                            },
                          ),
                        ],
                      ),

                    ],
                  ),

                   SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text('회원가입', style: TextStyle(fontSize: 15),),
                      ),

                      RaisedButton(
                        onPressed: () {
                          if(_idkey.currentState.validate() && _pwkey.currentState.validate()) {
                            Scaffold.of(_idkey.currentContext).showSnackBar(SnackBar(content: Text('아이디 혹은 비밀번호가 잘못 되었습니다.'),));
                          }
                        },
                        child: Text('로그인'),
                      ),
                    ],
                  ),

                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WritePost()));
                    },
                    child: Text('게시글 작성', style: TextStyle(fontSize: 15),),
                  ),
               ],
              )
            ),
      ),
          ),
        ),
    );
  }
}

class FindPw extends StatefulWidget {
  @override
  _FindPwState createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('비밀번호 찾기'),
      ),
      body: Padding(
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
                      hintText: '메일로 발송된 인증번호를 입력해주세요.'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

