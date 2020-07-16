import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
        appBar: AppBar(
          title: Text('대화 상대 이름'),
          backgroundColor: Colors.lightGreen,
        ),
        body: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.60
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text('안녕하세요! 제가 올림 물품의 거래를 희망하신다 하셔서 연락드립니다~!'),
                            ),
                          ),
                        ),
                        Text(
                          '5:27pm',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text('data'),
                    ),
                    Container(
                      child: Text('data'),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text('Send message test area'),
              ),
            ],
          ),
        ));
  }
}
