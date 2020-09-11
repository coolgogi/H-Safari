import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_safari/views/login/loading.dart';
import 'helpers/firebase_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            cursorColor: Colors.green,
          ),
          home: Loading()),
    );
  }
}
