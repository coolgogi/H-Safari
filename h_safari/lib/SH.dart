//누가 : 수현
//언제 : 2020-07-13
//main을 하나로 쓰면 충돌이 많이 나서 각자 main을 만들어주기로 했음, 여러분들 페이지를 합친걸
//다른걸 만들면 지저분해질까봐 여기에 두고 확인하기로 했습니다.

import 'yh/login.dart';
import 'yh/auth_page.dart';
import 'yh/list.dart';
import 'yh/post.dart';
import 'yh/signup.dart';
import 'yh/writePost.dart';
//import 'pangil/';
import 'package:flutter/material.dart';

//added from SH
import 'firebase/firebase_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class sh_main extends StatefulWidget {
  @override
  _sh_mainState createState() => _sh_mainState();
}

class _sh_mainState extends State<sh_main> {
  @override
  Widget build(BuildContext context) {
    return AuthPage();
  }
}
