//누가 : 수현
//언제 : 2020-07-13
//main을 하나로 쓰면 충돌이 많이 나서 각자 main을 만들어주기로 했음

import 'package:flutter/material.dart';
import 'yejin.dart';
import 'YH.dart';
import 'gwangil.dart';
import 'SH.dart';

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
      home: MyHomePage(title: 'H-Safari test'),//Login(),
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
                  context, MaterialPageRoute(builder: (context) => yh_main()));
            },
          ),
          ListTile(
            title: Text("예진 PAGE"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => yejin_main()));
            },
          ),
          ListTile(
            title: Text("광일 PAGE"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => gwangil_main()));
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