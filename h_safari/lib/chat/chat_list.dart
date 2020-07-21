import 'package:flutter/material.dart';
import 'package:h_safari/chat/chat_room.dart';

import 'message_model.dart';

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
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        itemCount: chats.length, //여기에 저장된 방의 갯수를 불러와야함
        itemBuilder: (BuildContext context, int index) {
          final Message chat = chats[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ChatRoom(user: chat.sender))),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                //프로필이미지랑 또다른 Container을 위젯으로 가짐
                children: <Widget>[
                  Container(
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 7,
                      )
                    ]),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(chat.sender.image),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      //1: 닉네임, 시간   2: 마지막 메세지
                      children: <Widget>[
                        Row(
                          //column의 첫번째로 닉네임, 시간을 가짐
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              //닉네임 옆에 안읽은 메세지가 있을 때 뜨는 동그라미 추가
                              children: <Widget>[
                                Text(
                                  chat.sender.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chat.unread
                                    ? Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber,
                                  ),
                                )
                                    : Container(
                                  child: null,
                                ),
                              ],
                            ),
                            Text(
                              chat.time,
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
                            chat.text,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                            //글 수가 오버플로시 ...으로 표시
                            maxLines: 2, //최대 글자줄수는 2줄
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}