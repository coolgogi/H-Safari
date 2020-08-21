import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';

class ChatRoom extends StatefulWidget {
  final String chatRoomId;
  final String chatRoomName;

  ChatRoom({this.chatRoomId, this.chatRoomName});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  FirebaseProvider fp;
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  String previousDate;
  var _blankFocusnode = new FocusNode();

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
    return WillPopScope(
      onWillPop: () async {
        DatabaseMethods().updateUnreadMessagy(widget.chatRoomId);
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.green,
            ),
            onTap: () {
              DatabaseMethods().updateUnreadMessagy(widget.chatRoomId);
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Center(
                child: Text(
              widget.chatRoomName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_blankFocusnode);
          },
          child: Column(
            children: [
              Expanded(child: chatMessages()),
              sendMessageBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatMessages() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MessageTile(
                    context,
                    snapshot.data.documents[index].data["message"],
                    currentUser.email ==
                        snapshot.data.documents[index].data["sendBy"],
                    snapshot.data.documents[index].data["date"],
                    index == snapshot.data.documents.length - 1
                        ? previousDate = "0"
                        : previousDate =
                            ((snapshot.data.documents[index + 1].data["date"])
                                .split(RegExp(r" |:")))[0],
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
        'date': new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
      };
      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);
      DatabaseMethods().updateLast(
          widget.chatRoomId,
          messageEditingController.text,
          DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
          currentUser.email,
          true);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  Widget sendMessageBox() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: EdgeInsets.fromLTRB(15, 8, 5, 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: TextField(
            style: TextStyle(fontSize: 18),
            controller: messageEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(15, 23, 0, 0),
              fillColor: Colors.grey[200],
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )),
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.green,
            onPressed: () {
              addMessage();
            },
          ),
        ],
      ),
    );
  }

  Widget MessageTile(BuildContext context, String message, bool sendByMe,
      String date, String previousDate) {
    var allTime = date.split(RegExp(r" |:"));
    var todayDate = allTime[0];
    var hour = allTime[1];
    var minute = allTime[2];
    var m = '오전';
    var hourInt = int.parse(hour);
    if (hourInt > 12) {
      hourInt = hourInt - 12;
      m = '오후';
    }
    hour = hourInt.toString();
    var time = m + " " + hour + ":" + minute;
    return Column(
      children: <Widget>[
        previousDate != todayDate
            ? Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 20,
                child: Center(
                    child: Text(
                  todayDate,
                  style: TextStyle(fontSize: 12),
                )),
              )
            : Container(
                child: null,
              ),
        Row(
          mainAxisAlignment:
              sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            sendByMe
                ? Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 7),
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
                    bottomLeft:
                        sendByMe ? Radius.circular(23) : Radius.circular(0),
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
                    padding: const EdgeInsets.only(left: 3, bottom: 7),
                    child: Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
