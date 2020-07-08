import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home 이랑 같음')),
      body:
      ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('My Page'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                        'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                  ),
                  Text('야옹이'),
                ],
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.autorenew),
            title: Text('환경 설정'),
          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text('와이 파이'),
          ),
          ListTile(
            leading: Icon(Icons.access_alarms),
            title: Text('시간'),
          ),
        ],
      )

    );
  }
}
