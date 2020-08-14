import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/firebase_provider.dart';
import '../../services/database.dart';
import 'chatRoom.dart';
import 'package:h_safari/widget/widget.dart';

class ChatList extends StatefulWidget {
  String email;

  ChatList(String tp) {
    email = tp;
  }

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Stream<QuerySnapshot> chatRooms;

  FirebaseProvider fp;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    databaseMethods.getUserChats(widget.email).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain("Chatting Rooms"),
      body: Container(
        child: getChatList(),
      ),
    );
  }

  Widget getChatList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                    return ChatRoomsTile(
                      context,
                      snapshot.data.documents[index].data['users'],
                      snapshot.data.documents[index].data["chatRoomName"],
                      snapshot.data.documents[index].data['lastMessage'],
                      snapshot.data.documents[index].data['lastDate']
                              .split(RegExp(r" |:|-"))[1] +
                          '/' +
                          snapshot.data.documents[index].data['lastDate']
                              .split(RegExp(r" |:|-"))[2] +
                          '\n' +
                          snapshot.data.documents[index].data['lastDate']
                              .split(RegExp(r" |:|-"))[3] +
                          ':' +
                          snapshot.data.documents[index].data['lastDate']
                              .split(RegExp(r" |:|-"))[4],
                      snapshot.data.documents[index].data["lastSendBy"],
                      snapshot.data.documents[index].data["lastSendBy"] == widget.email
                          ? false
                          : snapshot.data.documents[index].data['unread'],
                    );
                })
            : Container();
      },
    );
  }

  Widget ChatRoomsTile(BuildContext context, List users, String chatRoomId,
      String message, String date, String sendBy, bool unread) {
    String friendName;
    bool isMyPost = false;
    if(users[0]==widget.email){
      friendName = users[1];
      isMyPost = true;}
    else {
      friendName = users[0];
      isMyPost = false;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(
                  chatRoomId: chatRoomId,
                )));
        sendBy != friendName
            ? null
            : DatabaseMethods().updateUnreadMessagy(chatRoomId);
      },
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.brown),
            borderRadius: BorderRadius.circular(15),
            color: Colors.brown[50]),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(top: 5),
        child: Column(
          //1: 닉네임, 시간   2: 마지막 메세지
          children: <Widget>[
            Row(
              //column의 첫번째로 닉네임, 시간을 가짐
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  isMyPost ? chatRoomId: chatRoomId.split(RegExp(r"_"))[1],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: <Widget>[
                    unread
                        ? Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent,
                      ),
                    )
                        : Container(
                      child: null,
                    ),
                    Text(
                      date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                    //글 수가 오버플로시 ...으로 표시
                    maxLines: 1, //최대 글자줄수는 2줄
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: Colors.black45,
                  ),
                  onTap: () {
                    deleteChatRoom(chatRoomId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  deleteChatRoom(String chatRoomId) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          {
            return AlertDialog(
              content: Text('채팅방을 삭제하시겠습니까?'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.pop(context, '취소');
                  },
                ),
                FlatButton(
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {
                    DatabaseMethods().deleteChatRoom(chatRoomId);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
        });
  }
}
