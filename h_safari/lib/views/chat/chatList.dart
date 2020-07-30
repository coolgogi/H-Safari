import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:h_safari/views/post/post.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'chatRoom.dart';
import 'package:h_safari/widget/widget.dart';
class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Stream chatRooms;
  String uid;
  String email;
  FirebaseProvider fp;

  Widget getChatList() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();

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
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(email, ""),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }



  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this.getUserInfogetChats();
    });
  }

  getUserInfogetChats() async {
//    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    email = currentUser.email;
    DatabaseMethods().getUserChats(email).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${email}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, '채팅 리스트'),
      body: Container(
        color: Colors.white,
        child: getChatList(),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

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
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(style: BorderStyle.solid, color: Colors.black26),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
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
                      userName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
//                        chat.unread
//                            ? Container(
//                          margin: const EdgeInsets.only(left: 8),
//                          width: 7,
//                          height: 7,
//                          decoration: BoxDecoration(
//                            shape: BoxShape.circle,
//                            color: Colors.amber,
//                          ),
//                        )
//                            : Container(
//                          child: null,
//                        ),
                  ],
                ),
                Text(
                  '시간입니당',
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
                '',
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
    );
  }
}
