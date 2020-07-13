import 'package:flutter/material.dart';
import 'package:h_safari/modifyprofile.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('home 이랑 같음')),
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
                    RaisedButton(
                      child: Icon(
                        Icons.border_color,
                        size: 15,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifyProfile()));
                      },
                    )
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('환경 설정'),
            ),
            ListTile(
              leading: Icon(Icons.filter_frames),
              title: Text('이용 약관'),
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('로그아웃'),
            ),
          ],
        ));
  }
}
