import 'package:flutter/material.dart';
import '../views/category/category.dart';
import '../views/main/home.dart';
import 'package:h_safari/views/chat/chatList.dart';
import '../views/post/write.dart';
import 'package:h_safari/views/mypage/myPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/firebase_provider.dart';
import 'package:provider/provider.dart';


int copyIndex = 0; //게시글 작성하고 초기화 시킬 때 사용할 인덱스 복사값

class BottomBar extends StatefulWidget {

  String email;
  BottomBar(String tp){
    email = tp;
  }

  @override
  _BottomBarState createState() => _BottomBarState(email);
}

class _BottomBarState extends State<BottomBar> {

  String email;
  _BottomBarState(String tp){
    email = tp;
    print("_BottomBarState : $email");
  }


  int _currentIndex = 0;

//  List<Widget> _children = [Home(), MyCategory(), MyWrite(), ChatList(), MyPage()];
  List<Widget> _children;
  FirebaseProvider fp;
  @override

  void _onTap(int index) {
    if()
    setState(() {
      _currentIndex = index;
    });
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {

    _children = [Home(email), MyCategory(), MyWrite(), ChatList(email), MyPage()];

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
                  backgroundColor: Colors.blueGrey,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    title: Text('Category'),
                    backgroundColor: Colors.blueGrey
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_box),
                    title: Text('Write'),
                    backgroundColor: Colors.blueGrey
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    title: Text('Chat'),
                    backgroundColor: Colors.blueGrey
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('MyPage'),
                  backgroundColor: Colors.blueGrey,
                ),
              ])),
    );
  }
}