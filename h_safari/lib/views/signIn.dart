import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/loading.dart';
import 'signUp.dart';
import 'package:provider/provider.dart';
import '../models/firebase_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot.dart';

import 'package:h_safari/views/cloudMessage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //added by SH
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  bool doRemember = false;
  bool visiblepw = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  var _blankFocusnode = new FocusNode(); //키보드 없애는 용

//  @override
  void initState() {
    super.initState();
    getRememberInfo();
  }

  @override
  void dispose() {
    setRememberInfo();
    _mailCon.dispose();
    _pwCon.dispose();
    super.dispose();
  }

  var _color = Colors.green;
  final _formkey = new GlobalKey<FormState>();
  String _idkey, _pwkey;

//  bool _rememberId = false;

  @override
  Widget build(BuildContext context) {
    //added by SH
    fp = Provider.of<FirebaseProvider>(context);
    logger.d(fp.getUser());
    return Scaffold(
      key: _scaffoldKey, //added by SH
      resizeToAvoidBottomPadding: true, //화면 스크롤 가능하게 하는거라던데 일단 추가했어요.
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusnode);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 40),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: Form(
                    key: _formkey, //아이디 폼키
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 250,
                              height: 250,
                              child: Image.asset('Logo/h-safari_homeicon.png.png'),
                          )
                        ),

                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //Text("ID: ", style: TextStyle(fontSize: 30),),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: TextFormField(
                                  //아이디를 입력하는 텍스트 필드
                                  keyboardType: TextInputType.number,
                                  controller: _mailCon,
                                  //added by SH
                                  decoration: InputDecoration(
                                    //hintText: '아이디를 입력하세요.',
                                    hintText: '아이디',
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                  ),
                                  validator: (value) {
                                    //아무것도 입력하지 않았을 때 뜨는 에러메세지.
                                    if (value.isEmpty) {
                                      return 'ID를 입력하지 않았습니다.';
                                    }
                                  },
                                  onSaved: (value) => _idkey = value,
                                ),
                              ),
                            ),
                          ],
                        ), //아이디 텍스트

                        SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //Text("비밀번호: ", style: TextStyle(fontSize: 30),),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: TextFormField(
                                  obscureText: !visiblepw,
                                  controller: _pwCon, //added by SH
                                  decoration: InputDecoration(
                                      //hintText: '비밀번호를 입력하세요.',
                                      hintText: '비밀번호',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          visiblepw
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: visiblepw
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            visiblepw = !visiblepw;
                                          });
                                        },
                                      )),
                                  validator: (value) {
                                    //마찬가지로 아무것도 입력하지 않으면 뜨는 에러 메세지
                                    if (value.isEmpty) {
                                      return '비밀번호를 입력하지 않았습니다.';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ), //비밀번호 텍스트

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                //아이디 저장유무를 확인하는 버튼. 다만 아직 실제 저장되는건 미구현입니다.
                                Text(
                                  '아이디 저장',
                                  style: TextStyle(fontSize: 15),
                                ),
                                //아니면 자동 로그인?
                                Checkbox(
                                  key: null,
                                  value: doRemember, //from _rememberId
                                  activeColor: Colors.green,
                                  onChanged: (bool value) {
                                    setState(() {
                                      doRemember = value; //from _rememberId
                                    });
                                  },
                                ),
                              ],
                            ),
                            RawMaterialButton(
                              //비밀번호를 찾는 페이지로 이동하는 버튼. 겉모습은 버튼이 아니라 그냥 글자 모양.
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FindPw()));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: 200,
                                  height: 50,
                                  child: RaisedButton(
                                    color: Colors.green,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(
                                          color: Colors.green,
                                        )),
                                    onPressed: () {
                                      //로그인 버튼. 일단 저번에 영상에서 본걸로 로그인과 비밀번호가 일치하는지 확인하는거 구현 해봤는데 안되는 것 같아요.
                                      FocusScope.of(context).requestFocus(
                                          new FocusNode()); //added by SH
                                      _signIn(); //added by SH
                                    },
                                    child: Text(
                                      '로그인',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                //회원가입 버튼. 누르면 회원가입 창으로 이동합니다
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FcmFirstDemo()));
                              },
                              child: Text(
                                'Push 알림 test',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),

                            RawMaterialButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Loading()));},
                              child: Text('로딩화면', style: TextStyle(fontSize: 15, color: Colors.grey, decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //added by SH
  void _signIn() async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: Duration(seconds: 10),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("   Signing-In...")
            ],
          )));
    bool result = await fp.signInWithEmail(_mailCon.text, _pwCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false) showLastFBMessage();
  }

  getRememberInfo() async {
    logger.d(doRemember);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doRemember = (prefs.getBool("doRemember") ?? false);
    });
    if (doRemember) {
      setState(() {
        _mailCon.text = (prefs.getString("userEmail") ?? "");
        _pwCon.text = (prefs.getString("userPasswd") ?? "");
      });
    }
  }

  setRememberInfo() async {
    logger.d(doRemember);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("doRemember", doRemember);
    if (doRemember) {
      prefs.setString("userEmail", _mailCon.text);
      prefs.setString("userPasswd", _pwCon.text);
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
