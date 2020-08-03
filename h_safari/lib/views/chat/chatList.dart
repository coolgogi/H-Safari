import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/firebase_provider.dart';
import 'database.dart';
import 'chatRoom.dart';
import 'package:h_safari/widget/widget.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Stream<QuerySnapshot> chatRooms;

  String email;
  FirebaseProvider fp;

  Widget getChatList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    friendName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(email, ""),
                    message: snapshot.data.documents[index].data['lastMessage'],
                    date: snapshot.data.documents[index].data['lastDate']
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
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                    sendBy: snapshot.data.documents[index].data["lastSendBy"],
                    unread: snapshot.data.documents[index].data["lastSendBy"] ==
                            email
                        ? false
                        : snapshot.data.documents[index].data['unread'],
                  );
                })
            : Container();
      },
    );
  }



  @override
  void initState() {
    DatabaseMethods().getUserChats(email).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
    super.initState();

    Future.delayed(Duration.zero, () {
      getUserInfoGetChats();
    });
  }

  getUserInfoGetChats() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    email = currentUser.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, '채팅 리스트'),
      body: getChatList(),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String friendName;
  final String chatRoomId;
  final String message;
  final String date;
  final String sendBy;
  final bool unread;

  ChatRoomsTile(
      {this.friendName,
      @required this.chatRoomId,
      @required this.message,
      this.date,
      this.unread, this.sendBy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(
                      chatRoomId: chatRoomId,
                    )));
        sendBy != friendName ? null: DatabaseMethods().updateUnread(chatRoomId);
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
                  friendName,
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
          ],
        ),
      ),
    );
  }
}
