import 'package:flutter/material.dart';
import 'package:h_safari/views/category/category.dart';
import 'package:h_safari/views/home/home.dart';
import 'package:h_safari/views/chat/chatList.dart';
import 'package:h_safari/views/post/write.dart';
import 'package:h_safari/views/mypage/myPage.dart';

//
//import 'package:h_safari/models/firebase_provider.dart';
//
//int copyIndex = 0; //게시글 작성하고 초기화 시킬 때 사용할 인덱스 복사값

class BottomBar extends StatefulWidget {
  String email;

  BottomBar(String tp) {
    email = tp;
  }

  @override
  _BottomBarState createState() => _BottomBarState(email);
}

class _BottomBarState extends State<BottomBar> {
  String email;

  _BottomBarState(String tp) {
    email = tp;
    print("_BottomBarState : $email");
  }

  int _currentIndex = 0;
  List<Widget> _children;
  final pageController = PageController();

//
//  FirebaseProvider fp;

  @override
  void _onTap(int index) {
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyWrite()));
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _children = [
      Home(email),
      MyCategory(),
      MyWrite(),
      ChatList(email),
      MyPage()
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.green,
              type: BottomNavigationBarType.fixed,
              onTap: _onTap,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  title: Text('Category'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  title: Text('Write'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  title: Text('Chat'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('MyPage'),
                ),
              ])),
    );
  }
}
