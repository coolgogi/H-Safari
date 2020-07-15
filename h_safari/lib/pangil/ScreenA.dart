import 'package:flutter/material.dart';
import 'Alarm.dart';
import 'package:h_safari/yh/post.dart';

import 'package:h_safari/pangil/MySearch.dart';

import 'category/category1.dart';
import 'category/category2.dart';
import 'category/category3.dart';
import 'category/category4.dart';
import 'category/category5.dart';
import 'category/category6.dart';
import 'category/category7.dart';
import 'category/category8.dart';
import 'category/category9.dart';
import 'category/category10.dart';
import 'category/category11.dart';
import 'category/category12.dart';

import '../firebase/firebase_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  int _counter = 0;
  FirebaseProvider fp;

  @override
  bool get wantKeepAlive => true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('찾고싶은 상품을 입력하세요', style: TextStyle(fontSize: 13)),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => mysearch()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => mysearch()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Alarm()));
            },
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.text,
              icon: Icon(
                choice.icon,
              ),
              // 이전 코드와 다른 부분
            );
          }).toList(),
          isScrollable: true,
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'CATEGORY',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '여성 의류',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category1()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '남성 의류',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category2()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '패션 잡화',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category3()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '뷰티/미용',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category4()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '스포츠/레저',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category5()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '디지털/가전',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category6()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '도서/티켓',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category7()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '생활/식품',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category8()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '문구/가구',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category9()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '한동나눔',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category10()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '양도구해요/해요',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category11()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '구인구직',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category12()));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: TabBarView(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),

                  //from SH


                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH


                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  //from SH
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: RaisedButton(
                      color: Colors.indigo[300],
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        fp.signOut();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),

//      Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//
//
//          ],
//        ),
//      ),
    );
  }
}

class Choice {
  Choice(
    this.text,
    this.icon,
  );

  final String text;
  final IconData icon;

// 매개변수를 전달할 때 {}가 있다면 매개변수 이름을 생략할 수 없다.
// Choice({this.title, this.icon});
}

final choices = [
  Choice('전체', Icons.account_balance),
  Choice('남성의류', Icons.flight),
  Choice('여성의류', Icons.directions_car),
  Choice('패션잡화', Icons.directions_bike),
  Choice('뷰티/미용', Icons.directions_boat),
  Choice('스포츠/레저', Icons.directions_bus),
  Choice('디지털/가전', Icons.directions_railway),
  Choice('도서/티켓', Icons.directions_walk),
  Choice('생활/식품', Icons.directions_bike),
  Choice('문구/가구', Icons.directions_boat),
  Choice('한동나눔', Icons.directions_bus),
  Choice('양도', Icons.directions_railway),
  Choice('구인구직', Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  // 매개변수 주변에 {}가 있기 때문에 text와 icon이라는 매개변수 이름을 함께 사용해야 한다.
  const ChoiceCard({Key key, this.text, this.icon}) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // 아이콘과 텍스트 양쪽에서 사용하기 위해 별도 변수로 처리
    final TextStyle textStyle = Theme.of(context).textTheme.display3;
    return Card(
      child: Column(
        children: <Widget>[
          // 아이콘이 위쪽, 문자열이 아래쪽.
          Icon(icon, size: 128.0, color: textStyle.color),
          Text(text, style: textStyle),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      color: Colors.green,
      margin: EdgeInsets.all(12),
    );
  }
}
