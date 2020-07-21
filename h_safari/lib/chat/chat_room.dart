import 'package:flutter/material.dart';
import 'package:h_safari/chat/message_model.dart';
import 'package:h_safari/chat/user_model.dart';

class ChatRoom extends StatefulWidget {

  final User user;
  ChatRoom({this.user});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  _chatDesign(Message message, bool isMe, bool isSameUser) {
    if (isMe) { //내가 보내는 메세지 디자인
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 3, bottom: 5),
            child: Text(
              '5:27pm',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ),
          Container(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.60),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    } else { //상대의 메세지 디자인
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !isSameUser ?
          Container(
            margin: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(message.sender.image),
            ),
          ):
          Container(
            child: SizedBox(width: 45,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              !isSameUser ?
              Text(
                message.sender.name,
                style: TextStyle(
                  height: 2,
                  fontSize: 13,
                ),
              ):
              Container(
                child: null,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.60),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(message.text),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 5),
                    child: Text(
                      '5:27pm',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }

  _sendMessageBox() { // 메세지 입력 박스
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 60,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Colors.green,
            onPressed: () {}, //사진 불러오기 (찍는 기능도 넣을지 고민)
          ),
          Expanded(
            child: TextField(
              decoration:
              InputDecoration.collapsed(hintText: 'Send a message.'),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.green,
            onPressed: () {}, //전송 -> 데이타 등록
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId;
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(
        title: Text(widget.user.name),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender.id == currentUser.id;
                final bool isSameUser = prevUserId == message.sender.id; //같은 sender면 사진이랑 닉네임 한번만
                prevUserId = message.sender.id;
                return _chatDesign(message, isMe, isSameUser); //채팅 입력하는 함수
              },
            ),
          ),
          _sendMessageBox() // 메세지 입력 박스
        ],
      ),
    );
  }
}