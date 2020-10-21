import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/category/category.dart';
import 'package:h_safari/views/home/home.dart';
import 'package:h_safari/views/chat/chatList.dart';
import 'package:h_safari/views/post/write.dart';
import 'package:h_safari/views/mypage/myPage.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

// ignore: must_be_immutable
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

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  _BottomBarState(String tp) {
    email = tp;
    print("_BottomBarState : $email");
  }

  int _currentIndex = 0;
  List<Widget> _children;
  final pageController = PageController();

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
      MyPage(email)
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
                  title: Text('홈'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  title: Text('카테고리'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  title: Text('글쓰기'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  title: Text('채팅'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('마이페이지'),
                ),
              ])),
    );
  }

  // ignore: non_constant_identifier_names
  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print('token : ' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  // ignore: non_constant_identifier_names
  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
