import 'package:flutter/material.dart';
import 'modifyprofile.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('home 이랑 같음')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Text(
                'My Page',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0,25,15,15),
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
                      SizedBox(
                        width: 20,
                        height: 30,
                        child: RawMaterialButton(
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
                        ),
                      ),
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
          ),
        ));
  }
}
