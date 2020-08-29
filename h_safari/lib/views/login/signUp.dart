import 'package:flutter/material.dart';
import 'package:h_safari/views/mypage/terms_of_use.dart';
import '../../helpers/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _mailConCheck = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  TextEditingController _pwConCheck = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  bool clothe = false; //의류
  bool book = false; //서적
  bool food = false; //음식
  bool necessary = false; //생활용품
  bool furniture = false; //'가구/전자제품'
  bool beauty = false; //'뷰티/잡화'
  bool house = false; //'양도'
  bool others = false; //'기타'
  bool finished = false; //'마감'
  List<bool> category;

  final _formkey = GlobalKey<FormState>();
  bool _agree = false; //약관 동의 변수
  bool _agree2 = false;
  bool _visiblepw = false; //비밀번호 입력에서 텍스트 가리는 변수
  bool _visiblepw2 = false; //비밀번호 확인에서 텍스트 가리는 변수
  var _blankFocusnode = new FocusNode(); //키보드 없애는 용

  @override
  void dispose() {
    _mailCon.dispose();
    _pwCon.dispose();
    _mailConCheck.dispose();
    _pwConCheck.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (fp == null) {
      fp = Provider.of<FirebaseProvider>(context);
    }
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusnode);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Container(
              child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "학번:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mailCon,
                          decoration: InputDecoration(
                            hintText: '학번을 입력하세요.',
                            helperText: ' ',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                          ),
                          validator: (value) {
                            return value.isEmpty ? '학번을 입력하지 않았습니다.' : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "학번 확인:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mailConCheck,
                          decoration: InputDecoration(
                            hintText: '학번을 다시 한번 입력하세요.',
                            helperText: ' ',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? '학번을 입력하지 않았습니다.'
                                : (value != _mailCon.text
                                    ? '학번이 일치하지 않습니다.'
                                    : null);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "비밀번호:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          obscureText: !_visiblepw,
                          controller: _pwCon,
                          decoration: InputDecoration(
                              hintText: '비밀번호를 입력하세요.',
                              helperText: ' ',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _visiblepw
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      _visiblepw ? Colors.green : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _visiblepw = !_visiblepw;
                                  });
                                },
                              )),
                          validator: (value) {
                            return value.isEmpty ? '비밀번호를 입력하지 않았습니다.' : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "비빌번호 확인: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          obscureText: !_visiblepw2,
                          controller: _pwConCheck,
                          decoration: InputDecoration(
                              hintText: '비밀번호를 한번 더 입력하세요.',
                              helperText: ' ',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _visiblepw2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      _visiblepw2 ? Colors.green : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _visiblepw2 = !_visiblepw2;
                                  });
                                },
                              )),
                          validator: (value) {
                            return value.isEmpty
                                ? '비밀번호를 입력하지 않았습니다.'
                                : (value != _pwCon.text
                                    ? '비밀번호가 일치하지 않습니다.'
                                    : null);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RawMaterialButton(
                            child: Text(
                              '이용약관 보기',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Terms()));
                            },
                          ),
                          Row(
                            children: [
                              Text('약관에 동의합니다.'),
                              Checkbox(
                                key: null,
                                value: _agree,
                                activeColor: Colors.green,
                                onChanged: (bool value) {
                                  setState(() {
                                    _agree = !_agree;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RawMaterialButton(
                            child: Text(
                              '개인정보처리방침 보기',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Terms()));
                            },
                          ),
                          Row(
                            children: [
                              Text('약관에 동의합니다.'),
                              Checkbox(
                                key: null,
                                value: _agree2,
                                activeColor: Colors.green,
                                onChanged: (bool value) {
                                  setState(() {
                                    _agree2 = !_agree2;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                if (_formkey.currentState.validate()) {}
                                if (_agree != false) {
                                  if (_agree2 != false) {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    _signUp();
                                  } else {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('개인정보처리방침을 확인하고 동의해 주세요.'),
                                      backgroundColor: Colors.green,
                                      action: SnackBarAction(
                                        label: '확인',
                                        textColor: Colors.white,
                                        onPressed: () {},
                                      ),
                                    ));
                                  }
                                } else {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text('이용약관을 확인하고 동의해 주세요.'),
                                    backgroundColor: Colors.green,
                                    action: SnackBarAction(
                                      label: '확인',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  ));
                                }
                              },
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
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
    String emailSetting = _mailCon.text + "@handong.edu";
    bool result = await fp.signUpWithEmail(emailSetting, _pwCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result) {
      addUser(emailSetting);
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text("학번@handong.edu를 확인하세요!\nGmail에서 인증을 완료해야 로그인이 됩니다!"),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
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

  Future<bool> addUser(String email) {
    category = [
      clothe,
      book,
      food,
      necessary,
      furniture,
      beauty,
      house,
      others
    ];
    Map<String, dynamic> user = {
      "user": email,
      "가입일": new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
      "의류": clothe,
      "서적": book,
      "음식": food,
      "생활용품": necessary,
      "가구전자제품": furniture,
      "뷰티잡화": beauty,
      "양도": house,
      "기타": others,
      "마감": finished,
      "unreadNotification": false,
    };

    Firestore.instance
        .collection("users")
        .document(email)
        .setData(user)
        .catchError((e) {
      print(e.toString());
    });
  }

  String ErrorMessage(String value) {
    if (_pwCon.text != _pwConCheck.text) {
      return '비밀번호가 일치하지 않습니다.';
    }
  }
}
