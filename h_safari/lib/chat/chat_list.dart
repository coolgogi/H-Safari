import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅 리스트'),
      ),
      body: ListView.builder(
        itemCount: 10 ,//여기에 저장된 방의 갯수를 불러와야함
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Row( //프로필이미지랑 또다른 Container을 위젯으로 가짐
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 7,
                    )
                  ]),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column( //1: 닉네임, 시간   2: 마지막 메세지
                    children: <Widget>[
                      Row( //column의 첫번째로 닉네임, 시간을 가짐
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row( //닉네임 옆에 안읽은 메세지가 있을 때 뜨는 동그라미 추가
                            children: <Widget>[
                              Text(
                                '야옹이',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // 읽었는가 ?
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                ),
                              ),
                              // :
                              // Container(child: null,),
                            ],
                          ),
                          Text(
                            '10:21am',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '네 그럼 어디서 거래하는 것이 편하신지 말씀해주세요! 저는 다 괜찮습니다~!!',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis, //글 수가 오버플로시 ...으로 표시
                          maxLines: 2, //최대 글자줄수는 2줄
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
