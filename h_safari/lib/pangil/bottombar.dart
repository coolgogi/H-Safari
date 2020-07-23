import 'package:flutter/material.dart';
import 'package:h_safari/pangil/Category.dart';
import 'home.dart';
import 'package:h_safari/chat/chat_list.dart';
import 'write.dart';
import 'package:h_safari/mypage/mypage.dart';
import '../SH/chat_main.dart';

class GI_MyApp extends StatefulWidget {
  @override
  _GI_MyAppState createState() => _GI_MyAppState();
}

class _GI_MyAppState extends State<GI_MyApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [Home(), MyCategory(), MyWrite(), ChatList(), MyPage()];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.orangeAccent,
              type: BottomNavigationBarType.fixed,
              onTap: _onTap,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  backgroundColor: Colors.blueGrey,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    title: Text('Category'),
                    backgroundColor: Colors.blueGrey),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_box),
                    title: Text('Write'),
                    backgroundColor: Colors.blueGrey),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    title: Text('Chat'),
                    backgroundColor: Colors.blueGrey),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('MyPage'),
                  backgroundColor: Colors.blueGrey,
                ),
              ])),
    );
  }
}
//void main() => runApp(MyApp());
//

//class GI_MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}


//
//class _MyHomePageState extends State<MyHomePage> {
//  int _currentIndex = 0;
//
//  final List<Widget> _children = [Home(), First(), Second(), Third(), Fourth()];
//
//  void _onTap(int index) {
//    setState(() {
//      _currentIndex = index;
//    });
//  }
//
//  void onPageChanged(int index) {
//    setState(() {
//      _currentIndex = index;
//    });
//  }
//
//  final pageController = PageController();
//
//  @override
//  Widget build(BuildContext context) {
//    return DefaultTabController(
//      length: choices.length,
//      child: Scaffold(
//          body: _children[_currentIndex],
//          bottomNavigationBar: BottomNavigationBar(
//              type: BottomNavigationBarType.fixed,
//              onTap: _onTap,
//              currentIndex: _currentIndex,
//              items: [
//                BottomNavigationBarItem(
//                  icon: Icon(Icons.home),
//                  title: Text('Home'),
//                  backgroundColor: Colors.blueGrey,
//                ),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.chat_bubble_outline),
//                    title: Text('Chat'),
//                    backgroundColor: Colors.blueGrey),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.add_box),
//                    title: Text('Write'),
//                    backgroundColor: Colors.blueGrey),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.grade),
//                    title: Text('Scrab'),
//                    backgroundColor: Colors.blueGrey),
//                BottomNavigationBarItem(
//                  icon: Icon(Icons.person),
//                  title: Text('MyPage'),
//                  backgroundColor: Colors.blueGrey,
//                ),
//              ])),
//    );
//  }
//}
