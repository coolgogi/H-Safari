import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'setting.dart';
import 'terms_of_use.dart';
import 'package:h_safari/mypage/modifyprofile.dart';



class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new Icon(Icons.cake),
          title: Text('MyPage'),
        ),

        body: ListView(
          children: <Widget>[
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



