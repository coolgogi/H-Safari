import 'package:flutter/material.dart';
import 'login.dart';

//from 광일
import 'pangilmain.dart' ;
import 'package:youtube_flutter/ScreenA.dart';
import 'package:youtube_flutter/ScreenB.dart';
import 'package:youtube_flutter/ScreenC.dart';
import 'package:youtube_flutter/ScreenD.dart';
import 'package:youtube_flutter/ScreenE.dart';

//from 연희
import 'login.dart';
import 'writePost.dart';
import 'post.dart';

//from 예진



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'H-Safari'),//Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("연희 PAGE"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          ListTile(
            title: Text("예진 PAGE"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WritePost()));
            },
          ),
          ListTile(
            title: Text("광일 PAGE"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => GI_MyApp()));
            },
          ),
          ListTile(
            title: Text("수현 PAGE"),
            onTap: () {
//              Navigator.push(
//                  context, MaterialPageRoute(builder: (context) => AuthPage()));
            },
          )
        ].map((child) {
          return Card(
            child: child,
          );
        }).toList(),
      ),
    );
  }
}
