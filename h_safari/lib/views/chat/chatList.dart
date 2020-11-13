import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/services/database.dart';
import 'package:h_safari/widget/widget.dart';
import 'chatRoom.dart';

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
  DatabaseMethods databaseMethods = new DatabaseMethods();
  int isChat = 0;

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
                  if (snapshot.data.documents[index].data['users']
                      .contains(widget.email)) {
                    isChat++;
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
                      snapshot.data.documents[index].data["lastSendBy"] ==
                              widget.email
                          ? false
                          : snapshot.data.documents[index].data['unread'],
                    );
                  } else {
                    if (index == snapshot.data.documents.length - 1 &&
                        isChat == 0) {
                      return Container(
                        height: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/bird.jpeg',
                                fit: BoxFit.fill,
                              ),
                              width: 200,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '아직 채팅방이 없습니다!\n채팅방을 이용하여 거래를 진행하여보세요~!!',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                })
            : Container();
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget ChatRoomsTile(BuildContext context, List users, String chatRoomId,
      String message, String date, String sendBy, bool unread) {
    String friendName;
    bool isMyPost = false;
    if (users[0] == widget.email) {
      friendName = users[1];
      isMyPost = true;
    } else {
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
                      chatRoomName: isMyPost
                          ? chatRoomId
                          : chatRoomId.split(RegExp(r"_"))[1],
                    )));
        sendBy != friendName
            // ignore: unnecessary_statements
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  isMyPost ? chatRoomId : chatRoomId.split(RegExp(r"_"))[1],
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
                    maxLines: 1,
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
