import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'database.dart';

class ChatRoom extends StatefulWidget {
  final String chatRoomId;

  ChatRoom({this.chatRoomId});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String currentUid;
  String currentEmail;
  FirebaseProvider fp;

//  void _prepareService(String email, String uid) async {
//    final FirebaseUser user = await FirebaseAuth.getCurrentUser();
//    current_uid = user.getUid();
//    current_email = user.getEmail();
//  }

  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].data["message"],
                    sendByMe: currentUser.email ==
                        snapshot.data.documents[index].data["sendBy"],
                    time: snapshot.data.documents[index].data["time"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": currentUser.email,
        "message": messageEditingController.text,
        'time': new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      decoration: InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 25,
                      color: Colors.green,
                      onPressed: () {
                        addMessage();
                      }, //전송 -> 데이타 등록
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final int time;

  MessageTile({@required this.message, @required this.sendByMe, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        sendByMe
            ? Padding(
                padding: const EdgeInsets.only(right: 3, bottom: 5),
                child: Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              )
            : Container(),
        Container(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 7),
            decoration: BoxDecoration(
              color: sendByMe ? Colors.lightGreen[100] : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 1, blurRadius: 1),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: sendByMe ? Radius.circular(23) : Radius.circular(0),
                bottomRight:
                    sendByMe ? Radius.circular(0) : Radius.circular(23),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        sendByMe
            ? Container()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                child: Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ),
      ],
    );
  }

  _sendMessageBox() {
    // 메세지 입력 박스
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
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}
