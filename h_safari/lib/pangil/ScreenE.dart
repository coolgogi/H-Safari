import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Alarm.dart';
import 'setting.dart';
import 'terms_of_use.dart';
import 'package:h_safari/pangil/MySearch.dart';
import 'package:h_safari/mypage/modifyprofile.dart';
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
import 'setting.dart';
import 'terms_of_use.dart';


class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('찾고싶은 상품을 입력하세요', style: TextStyle(fontSize: 13)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => mysearch()));
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
        body: ListView(
          children: <Widget>[
            Text(
              '  My Page',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('닉네임',
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(
                      '야옹이',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                      InkWell(
                      onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModifyProfile()));
                        },
                        child: Icon(
                        Icons.border_color,
                        size: 20,
                    ),
                      )
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('환경 설정'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Setting()));
              },
            ),
            ListTile(
              leading: Icon(Icons.filter_frames),
              title: Text('이용 약관'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Terms()));
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('로그아웃'),
            ),
          ],
        )
    );
  }
}



