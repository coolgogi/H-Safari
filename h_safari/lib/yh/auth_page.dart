// SH
// 2020-07-13
// 로그인 되어있는지 아닌지 확인하는 페이지.
import 'package:flutter/material.dart';
import '../firebase/firebase_provider.dart';
import 'post.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'list.dart';
import '../pangil/bottombar.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    
    logger.d("user: ${fp.getUser()}");
    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
      return GI_MyApp();
    } else {
      return Login();
    }
  }
}