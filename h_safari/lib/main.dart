//누가 : 수현
//언제 : 2020-07-13
//main을 하나로 쓰면 충돌이 많이 나서 각자 main을 만들어주기로 했음

import 'package:flutter/material.dart';
import 'package:h_safari/helpers/authPage.dart';


//added from SH
import 'models/firebase_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            builder: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
        home: AuthPage()
      ),
    );
  }
}
