import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/models/firebase_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

import 'database.dart';

class ChatRoom extends StatefulWidget {

  final String chatRoomId;
  ChatRoom({this.chatRoomId});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  String current_uid;
  String current_email;
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
    FirebaseUser current_user = fp.getUser();
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: current_user.email ==
                    snapshot.data.documents[index].data["sendBy"],
              );
            })
            : Container();
      },
    );
  }

  addMessage() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser current_user = fp.getUser();
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": current_user.email,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

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
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              border: InputBorder.none),

                        )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            "assets/images/send.png",
                            height: 25,
                            width: 25,
                          )),
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

  Widget appBarMain(BuildContext context) {
    return AppBar(
      title: Image.asset(
        "assets/images/logo.png",
        height: 40,
      ),
      elevation: 0.0,
      centerTitle: false,
    );
  }

//  _chatDesign(Message message, bool isMe, bool isSameUser) {
//    if (isMe) { //내가 보내는 메세지 디자인
//      return Row(
//        mainAxisAlignment: MainAxisAlignment.end,
//        crossAxisAlignment: CrossAxisAlignment.end,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(right: 3, bottom: 5),
//            child: Text(
//              '5:27pm',
//              style: TextStyle(
//                fontSize: 12,
//                color: Colors.black45,
//              ),
//            ),
//          ),
//          Container(
//            child: Container(
//              constraints: BoxConstraints(
//                  maxWidth: MediaQuery.of(context).size.width * 0.60),
//              padding: EdgeInsets.all(10),
//              margin: EdgeInsets.only(bottom: 5),
//              decoration: BoxDecoration(
//                color: Colors.green,
//                borderRadius: BorderRadius.circular(15),
//              ),
//              child: Text(
//                message.text,
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//            ),
//          ),
//        ],
//      );
//    } else { //상대의 메세지 디자인
//      return Row(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          !isSameUser ?
//          Container(
//            margin: EdgeInsets.only(right: 5),
//            child: CircleAvatar(
//              radius: 20,
//              backgroundImage: NetworkImage(message.sender.image),
//            ),
//          ):
//          Container(
//            child: SizedBox(width: 45,),
//          ),
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              !isSameUser ?
//              Text(
//                message.sender.name,
//                style: TextStyle(
//                  height: 2,
//                  fontSize: 13,
//                ),
//              ):
//              Container(
//                child: null,
//              ),
//              Row(
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//                  Container(
//                    alignment: Alignment.topLeft,
//                    child: Container(
//                      constraints: BoxConstraints(
//                          maxWidth: MediaQuery.of(context).size.width * 0.60),
//                      padding: EdgeInsets.all(10),
//                      margin: EdgeInsets.only(bottom: 5),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.circular(15),
//                      ),
//                      child: Text(message.text),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(left: 3, bottom: 5),
//                    child: Text(
//                      '5:27pm',
//                      style: TextStyle(
//                        fontSize: 12,
//                        color: Colors.black45,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ],
//      );
//    }
//  }

//  _sendMessageBox() { // 메세지 입력 박스
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 5),
//      height: 60,
//      color: Colors.white,
//      child: Row(
//        children: <Widget>[
//          IconButton(
//            icon: Icon(Icons.photo),
//            iconSize: 25,
//            color: Colors.green,
//            onPressed: () {}, //사진 불러오기 (찍는 기능도 넣을지 고민)
//          ),
//          Expanded(
//            child: TextField(
//              decoration:
//              InputDecoration.collapsed(hintText: 'Send a message.'),
//              textCapitalization: TextCapitalization.sentences,
//            ),
//          ),
//          IconButton(
//            icon: Icon(Icons.send),
//            iconSize: 25,
//            color: Colors.green,
//            onPressed: () {}, //전송 -> 데이타 등록
//          ),
//        ],
//      ),
//    );
//  }

//  @override
//  Widget build(BuildContext context) {
//    int prevUserId;
//    return Scaffold(
//      backgroundColor: Colors.lime[100],
//      appBar: AppBar(
//        title: Text(widget.user.name),
//        backgroundColor: Colors.lightGreen,
//      ),
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: ListView.builder(
//              padding: EdgeInsets.all(10),
//              itemCount: messages.length,
//              itemBuilder: (BuildContext context, int index) {
//                final Message message = messages[index];
//                final bool isMe = message.sender.id == currentUser.id;
//                final bool isSameUser = prevUserId == message.sender.id; //같은 sender면 사진이랑 닉네임 한번만
//                prevUserId = message.sender.id;
//                return _chatDesign(message, isMe, isSameUser); //채팅 입력하는 함수
//              },
//            ),
//          ),
//          _sendMessageBox() // 메세지 입력 박스
//        ],
//      ),
//    );
//  }
}


class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
        sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}



TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}