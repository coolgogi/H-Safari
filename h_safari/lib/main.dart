import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/login/loading.dart';
import 'helpers/firebase_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
