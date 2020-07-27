//who : YH
//date : ??
//for : signup

import 'package:flutter/material.dart';
import '../models/firebase_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //from SH
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  TextEditingController _pwConCheck = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _mailCon.dispose();
    _pwCon.dispose();
    super.dispose();
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  var _color = Colors.black12;
  final _formkey = GlobalKey<FormState>();
  bool _agree = false;
  final _pwkey = GlobalKey<FormState>();
  bool _visiblepw = false; //비밀번호 입력에서 텍스트 가리는 변수
  bool _visiblepw2 = false; //비밀번호 확인에서 텍스트 가리는 변수

  @override
  Widget build(BuildContext context) {
    if (fp == null) {
      fp = Provider.of<FirebaseProvider>(context);
    }

    return Scaffold(
      key: _scaffoldKey, //from SH (?)
      appBar: AppBar(
        centerTitle: true,
        title: Text('회원가입'),
      ),
      body: SingleChildScrollView( //화면 스크롤이 가능하게
        child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //닉네임과 텍스트필드
                          Text("닉네임: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '닉네임은 다시 변경할 수 없습니다.',
                              ),
                              validator: (value) {//아무것도 입력하지 않을 경우 뜨는 에러 메세지
                                if(value.isEmpty) {return '닉네임을 입력하지 않았습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30),

                          //아이디를 입력하는 텍스트 필드
                          Text("아이디: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                              child: TextFormField(
                                controller: _mailCon,
                                decoration: InputDecoration(
                                hintText: '학번을 입력하세요.',
                              ),
                              validator: (value) { //아무것도 입력하지 않으면 뜨는 에러 메세지
                                  //YJ 한동메일 아니면 경고메세지
                                  //return RedgExp(r"^[a-zA-Z0-9]+@[handong]+\.[edu]+").hasMatch(value)?null:"한동메일을 입력해주십시오";
                                if(value.isEmpty) {return '아이디를 입력하지 않았습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30,),

                          //비밀번호를 입력하는 텍스트 필드 (비밀번호 몇 글자 이상이라던가, 특수기호 등등 이런거도 넣을지는 아직 미정입니다.)
                          //안 넣는게 더 편할 것 같긴 해요.
                          Text("비밀번호: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField( //텍스트 입력시 가려지도록
                              obscureText: !_visiblepw,
                              controller: _pwCon,
                              decoration: InputDecoration(
                                hintText: '비밀번호를 입력하세요.',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _visiblepw ? Icons.visibility : Icons.visibility_off
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _visiblepw = !_visiblepw;
                                      });
                                    },
                                  )
                              ),
                              validator: (_pwkey) { //아무것도 입력하지 않으면 뜨는 에러 메세지
                                if(_pwkey.isEmpty) {return '비밀번호를 입력하지 않았습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30),

                          //입력한 비밀번호가 위에서 입력한 비번과 맞는지 확인하는 텍스트 필드.
                          Text("비빌번호 확인: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: TextFormField( //텍스트 입력시 가려지도록222
                              obscureText: !_visiblepw2,
                              controller: _pwConCheck,
                              decoration: InputDecoration(
                                hintText: '비밀번호를 입력하세요.',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _visiblepw2 ? Icons.visibility : Icons.visibility_off
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _visiblepw2 = !_visiblepw2;
                                      });
                                    },
                                  )
                              ),
                              validator: (value) { //일단 구현은 해보았는데 이것도 아직 제대로 작동하는지는 확인을 안해봤어요. 연동하고 해보겠습니다.
                                if(value != _pwkey) {return '비밀번호가 일치하지 않습니다.';}},
                            ),
                          ),

                          SizedBox(height: 30),

                          Row( //누르면 약관이 적혀있는 페이지로 이동하는 글자형 버튼
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

                              Row( //약관을 읽은 뒤 동의하는 버튼.
                                children: [
                                  Text('약관에 동의합니다.'),
                                  Checkbox(
                                    key: null,
                                    value: _agree,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _agree = !_agree;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ]
                          ),

                          SizedBox(height: 30,),

                          Row( //마지막 회원가입 버튼.
                            //아직 틀만 잡은거라 다 구현이 된건 아니에요
                            //구현할 것: 모든 글을 다 적었는지 확인, 비밀번호와 비밀번호 확인이 서로 일치하는지, 양관에 동의 했는지 -> 이게 중요한듯. 비밀번호 확인 하
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  if (_agree != false) { //약관 동의 버튼을 안누르면 회원가입이 안되도록(_agree는 약관 체크박스 변수)
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode()); // 키보드 감춤
                                    _signUp();
                                  }else{ //동의를 안하면 뜨는 스낵바
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text('이용약관을 확인하고 동의해 주세요.'),
                                          action: SnackBarAction(label: '확인', onPressed: () {},),
                                        )
                                    );
                                  }
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
  void _signUp() async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-Up...")
          ],
        ),
      ));
    bool result = await fp.signUpWithEmail(_mailCon.text, _pwCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result) {
      Navigator.pop(context);
    } else {
      showLastFBMessage();
    }
  }

  showLastFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(fp.getLastFBMessage()),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }

}

//이용약관 페이지 입니다!
//따로 dart파일을 안만들고 여기다 했어요. -> 다 잘했습니다.
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
            child: Text( //여기다 이용약관을 적어야 하는데 일일히 \n을 넣어줘야 하는 노가다 작업이 예상됩니다. ㅋㅋㅋ 파이팅해봅시
                '제1장 총칙\n\n제1조(목적)\n본 약관은 정부24 (이하 "당 사이트")가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n제2조(용어의 정의)\n본 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n\n① 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 이용할 수 있는 자'
                    '\n아니 더 길게 안되나\n 좀 더 길게\n 실험을 해봅시다\n 배고프다\n 아니 근데 이거 스크롤이 아니라\n 그냥 박스가 길어지는데\n'
            ),
          ),
        ),
      ),
    );
  }
}