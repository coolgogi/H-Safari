import 'package:flutter/material.dart';
import '../views/category/category.dart';
import '../views/main/home.dart';
import 'package:h_safari/views/chat/chatList.dart';
import '../views/post/write.dart';
import 'package:h_safari/views/mypage/myPage.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
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