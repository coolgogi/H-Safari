import 'package:flutter/cupertino.dart';
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
  var _color = Colors.green;
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
//      appBar: AppBar(
//        iconTheme: IconThemeData(color: _color),
//        backgroundColor: Colors.white,
//        centerTitle: true, //가운데 정렬
//        title: Text('로그인 창', style: TextStyle(color: Colors.green),),
//        elevation: 1, //숫자가 낮을수록 앱바 밑에 그림자?가 사라지게 함(플랫해진다)
//      ),
      body:

      SingleChildScrollView(
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

                      SizedBox(height: 70),

                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                        ),
                      ),

                      SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //Text("ID: ", style: TextStyle(fontSize: 30),),
                          Flexible(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: TextFormField( //아이디를 입력하는 텍스트 필드
                                controller: _mailCon, //added by SH
                                decoration: InputDecoration(
                                  //hintText: '아이디를 입력하세요.',
                                  hintText: '아이디',
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                ),
                                validator: (value) { //아무것도 입력하지 않았을 때 뜨는 에러메세지.
                                  if(value.isEmpty) {return 'ID를 입력하지 않았습니다.';}},
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
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          visiblepw ? Icons.visibility : Icons.visibility_off,
                                          color: visiblepw ? Colors.green : Colors.grey,
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
                          ),
                        ],
                      ), //비밀번호 텍스트

                      SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [//아이디 저장유무를 확인하는 버튼. 다만 아직 실제 저장되는건 미구현입니다.
                              Text('아이디 저장', style: TextStyle(fontSize: 15),), //아니면 자동 로그인?
                              Checkbox(
                                key: null,
                                value: doRemember,//from _rememberId
                                activeColor: Colors.green,
                                onChanged: (bool value) {
                                  setState(() {
                                    doRemember = value;//from _rememberId
                                  });
                                },
                              ),
                            ],
                          ),
                          RawMaterialButton(//비밀번호를 찾는 페이지로 이동하는 버튼. 겉모습은 버튼이 아니라 그냥 글장 모양.
                            child: Text('Forgot Password?', style: TextStyle(fontSize: 15, decoration: TextDecoration.underline),),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FindPw()));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),

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
                                      side: BorderSide(color: Colors.green,)
                                  ),
                                  onPressed: () {//로그인 버튼. 일단 저번에 영상에서 본걸로 로그인과 비밀번호가 일치하는지 확인하는거 구현 해봤는데 안되는 것 같아요.
                                    //그래서 일단은 스낵바가 뜨는거 보는 용도로만 사용할게요.
//                          if(_idkey.currentState.validate() && _pwkey.currentState.validate()) {
//                            Scaffold.of(_idkey.currentContext).showSnackBar(SnackBar(content: Text('아이디 혹은 비밀번호가 잘못 되었습니다.'),));
//                          }
                                    FocusScope.of(context).requestFocus(new FocusNode());//added by SH
                                    _signIn();//added by SH

                                  },
                                  child: Text('로그인', style: TextStyle(fontSize: 20, color: Colors.white),),
                                ),
                              ),
                            ],
                          ),

                          RawMaterialButton(
                            onPressed: () {//회원가입 버튼. 누르면 회원가입 창으로 이동합니다
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                            },
                            child: Text('회원가입', style: TextStyle(fontSize: 15, color: Colors.grey, decoration: TextDecoration.underline),),
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
          //added from SH
//          (fp.getUser() != null && fp.getUser().isEmailVerified == false)
//                ? Container(
//                      margin:
//                             const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                      decoration: BoxDecoration(color: Colors.red[300]),
//                      child: Column(
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.all(10.0),
//                            child: Text(
//                              "Mail authentication did not complete."
//                                  "\nPlease check your verification email.",
//                              style: TextStyle(color: Colors.white),
//                            ),
//                          ),
//                          RaisedButton(
//                            color: Colors.lightBlue[400],
//                            textColor: Colors.white,
//                            child: Text("Resend Verify Email"),
//                            onPressed: () {
//                              FocusScope.of(context)
//                                  .requestFocus(new FocusNode()); // 키보드 감춤
//                              fp.getUser().sendEmailVerification();
//                            },
//                          )
//                        ],
//                      ),
//                    ) : Container(),
          ////////////////////////////////////////////////////////////////////////
          ////////////////////////////////////////////////////////////////////////
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


//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        iconTheme: IconThemeData(color: Colors.green),
//        backgroundColor: Colors.white,
//        elevation: 1,
//        centerTitle: true,
//        title: Text('비밀번호 찾기', style: TextStyle(color: Colors.green)),
//      ),
//      body: Padding(
//        padding: const EdgeInsets.all(30.0),
//        child: Form(
//          key: _formkey,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Text("아이디: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//              SizedBox(height: 10),
//              Container(
//                alignment: Alignment.centerLeft,
//                height: 30,
//                child: TextFormField(
//                  decoration: InputDecoration(
//                    hintText: '학번을 입력하세요.',
//                  ),
//                  validator: (value) {
//                    if(value.isEmpty) {return '아이디를 입력하지 않았습니다.';}},
//                ),
//              ),
//
//              SizedBox(height: 50,),
//
//              Center(
//                child: ButtonTheme(
//                  minWidth: 150,
//                  height: 40,
//                  child: RaisedButton(
//                    color: Colors.green,
//                    elevation: 0,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(30),
//                        side: BorderSide(color: Colors.green,)
//                    ),
//                    onPressed: () {
//                      Scaffold.of(_formkey.currentContext).showSnackBar(
//                          SnackBar(
//                            content: Text('비밀번호 변경 메일을 발송하였습니다.', style: TextStyle(color: Colors.white),),
//                            backgroundColor: Colors.green,
//                            action: SnackBarAction(label: '확인', textColor: Colors.white , onPressed: () {},),
//                            duration: Duration(seconds: 2),
//                          )
//                      );
////                      PwMail(context); //메일을 보냈다는 링크
//                    },
//                    child: Text('확인', style: TextStyle(fontSize: 17, color: Colors.white),),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
////void PwMail(BuildContext context) async{
////  String result = await showDialog(
////      context: context,
////      barrierDismissible: false,
////      builder: (BuildContext context) {
////        return AlertDialog(
////          content: Text('해당 메일을 확인해 주세요.'),
////          actions: <Widget>[
////            FlatButton(
////              child: Text('확인', style: TextStyle(color: Colors.green),),
////              onPressed: (){
////                Navigator.pop(context, '확인');
////              },
////            )],
////        );
////      }
////  );
////}
//Widget appBarSignIn(BuildContext context, String title){
//  return AppBar(
//    title: Text(title),
//    elevation: 0.0,
//    centerTitle: true,
//  );
//}