import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signUp.dart';
import 'package:provider/provider.dart';
import '../../helpers/firebase_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  bool doRemember = false;
  bool visiblepw = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;
  var _blankFocusnode = new FocusNode();

  @override
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

  final _formkey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    logger.d(fp.getUser());
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusnode);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 55, 50, 0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: Form(
                    key: _formkey,
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
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _mailCon,
                                  decoration: InputDecoration(
                                    hintText: '학번',
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                  ),
                                  validator: (value) {
                                      return value.isEmpty ? '학번을 입력해주세요' : null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: TextFormField(
                                  obscureText: !visiblepw,
                                  controller: _pwCon,
                                  decoration: InputDecoration(
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
                                      return value.isEmpty ? '비밀번호를 입력해주세요.' : null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '아이디 저장',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Checkbox(
                                  key: null,
                                  value: doRemember,
                                  activeColor: Colors.green,
                                  onChanged: (bool value) {
                                    setState(() {
                                      doRemember = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            RawMaterialButton(
                              child: Text(
                                '비밀번호 찾기',
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
                                      FocusScope.of(context).requestFocus(
                                          new FocusNode());
                                      _signIn();
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    decoration: TextDecoration.underline),
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

  checkAll() {
    if(_formkey.currentState.validate()){}
  }

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
    String emailSetting = _mailCon.text + "@handong.edu";
    bool result = await fp.signInWithEmail(emailSetting, _pwCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false) checkAll();
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
}
