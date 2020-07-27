import 'package:flutter/material.dart';

import 'signUp.dart';
import 'package:h_safari/views/mypage/favoriteCategory.dart';
import 'signUp.dart';


//added by SH
import 'package:provider/provider.dart';
import '../models/firebase_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot.dart';
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

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


  ////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  var _color = Colors.blue;
  final _formkey = new GlobalKey<FormState>();
  String _idkey, _pwkey;
//  bool _rememberId = false;

  @override
  Widget build(BuildContext context) {
    //added by SH
    fp = Provider.of<FirebaseProvider>(context);

    logger.d(fp.getUser());
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    return Scaffold(

      key : _scaffoldKey, //added by SH
      resizeToAvoidBottomPadding: false, //화면 스크롤 가능하게 하는거라던데 일단 추가했어요.

      appBar: appBarSignIn(context, '로그인 창입니다'),
//      AppBar(
//        centerTitle: true, //가운데 정렬
//        title: Text('로그인 창'),
//        backgroundColor: _color,
//        elevation: 0.0, //숫자가 낮을수록 앱바 밑에 그림자?가 사라지게 함(플랫해진다)
//      ),

      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(.0),
            child: Form(
                key: _formkey, //아이디 폼키
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID ", style: TextStyle(fontSize: 30),), //아이디 텍스트
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: TextFormField( //아이디를 입력하는 텍스트 필드
                        controller: _mailCon, //added by SH
                        decoration: InputDecoration(
                          hintText: '아이디를 입력하세요.',
                        ),
                        validator: (value) { //아무것도 입력하지 않았을 때 뜨는 에러메세지.
                          if(value.isEmpty) {return 'ID를 입력하지 않았습니다.';}},
                        onSaved: (value) => _idkey = value,
                      ),
                    ),

                    SizedBox(height: 30),

                    Text("비밀번호 ", style: TextStyle(fontSize: 30),), //비밀번호 텍스트
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: TextFormField(
                        obscureText: !visiblepw,
                        controller: _pwCon, //added by SH
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요.',
                          suffixIcon: IconButton(
                            icon: Icon(
                              visiblepw ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: ()  {
                              setState(() {
                                visiblepw = !visiblepw;
                              });
                            },
                          )
                        ),
                        validator: (value) { //마찬가지로 아무것도 입력하지 않으면 뜨는 에러 메세지
                          if(value.isEmpty) {return '비밀번호를 입력하지 않았습니다.';}},
                      ),
                    ),

                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RawMaterialButton(//비밀번호를 찾는 페이지로 이동하는 버튼. 겉모습은 버튼이 아니라 그냥 글장 모양.
                          child: Text('비밀번호 찾기', style: TextStyle(fontSize: 15),),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FindPw()));
                          },
                        ),
                        Row(
                          children: [//아이디 저장유무를 확인하는 버튼. 다만 아직 실제 저장되는건 미구현입니다.
                            Text('아이디 저장', style: TextStyle(fontSize: 15),), //아니면 자동 로그인?
                            Checkbox(
                              key: null,
                              value: doRemember,//from _rememberId
                              onChanged: (bool value) {
                                setState(() {
                                  doRemember = value;//from _rememberId
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //회원가입과 로그인 버튼을 적당히 떨어트려 놓았습니다(거리두기^^)
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {//회원가입 버튼. 누르면 회원가입 창으로 이동합니다
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                          },
                          child: Text('회원가입', style: TextStyle(fontSize: 15),),
                        ),

                        RaisedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(new FocusNode());//added by SH
                            _signIn();//added by SH

                          },
                          child: Text('로그인'),
                        ),
                      ],
                    ),

                    RaisedButton( //임시로 만든 선호 카테고리 페이지 이동용 버튼~~~~~~~~~~~~~~~~~~~~~~~~~~~
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteCategory()));
                      },
                      child: Text('선호 카테고리'),
                    ),
                  ],
                )
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
        )
      ));
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
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
}


Widget appBarSignIn(BuildContext context, String title){
  return AppBar(
    title: Text(title),
    elevation: 0.0,
    centerTitle: true,
  );
}