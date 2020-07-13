import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Alarm.dart';
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
          title: TextField(
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: '검색'),
            onChanged: (String str) {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('shopping cart button is clicked');
              },
            ),
            IconButton(
              icon: Icon(Icons.add_alert),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Alarm()));
              },
            ),
          ],

        ),
        drawer: Drawer(
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
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'Computer',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'Clothes',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'Food',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'Quick',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'Book',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'gifticon',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
                title: Text(
                  'CarFul',
                  style: TextStyle(
                      fontSize: 15.0, backgroundColor: Colors.greenAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
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
                    Text('닉네임', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text('야옹이', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Icon(Icons.border_color, size: 15,)
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('환경 설정'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
            ListTile(
              leading: Icon(Icons.filter_frames),
              title: Text('이용 약관'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Terms()));
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('로그아웃'),
            ),
          ],
        ));
  }
}



