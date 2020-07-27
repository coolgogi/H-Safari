import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/firebase_provider.dart';

import 'package:provider/provider.dart';

import 'database.dart';
import 'chatRoom.dart';


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
                chatRoomId: snapshot.data.documents[index].data["chatRoomId"],
              );
            })
            : Container();
      },
    );
  }

  Widget appBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.cake,
        color: Colors.green,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Center(
            child: Text(
              '$title',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
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
      appBar: appBar('채팅 리스트'),
      body: Container(
        color: Colors.white,
        child: getChatList(),
      ),
//      body: ListView.builder(
//        itemCount: chats.length, //여기에 저장된 방의 갯수를 불러와야함
//        itemBuilder: (BuildContext context, int index) {
//          final Message chat = chats[index];
//          return GestureDetector(
//            onTap: () => Navigator.push(
//                context, MaterialPageRoute(builder: (_) => ChatRoom(user: chat.sender))),
//            child: Container(
//              padding: EdgeInsets.symmetric(
//                horizontal: 20,
//                vertical: 15,
//              ),
//              child: Row(
//                //프로필이미지랑 또다른 Container을 위젯으로 가짐
//                children: <Widget>[
//                  Container(
//                    decoration:
//                    BoxDecoration(shape: BoxShape.circle, boxShadow: [
//                      BoxShadow(
//                        color: Colors.grey,
//                        spreadRadius: 1,
//                        blurRadius: 7,
//                      )
//                    ]),
//                    child: CircleAvatar(
//                      radius: 35,
//                      backgroundImage: NetworkImage(chat.sender.image),
//                    ),
//                  ),
//                  Container(
//                    width: MediaQuery.of(context).size.width * 0.7,
//                    padding: EdgeInsets.only(
//                      left: 20,
//                    ),
//                    child: Column(
//                      //1: 닉네임, 시간   2: 마지막 메세지
//                      children: <Widget>[
//                        Row(
//                          //column의 첫번째로 닉네임, 시간을 가짐
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Row(
//                              //닉네임 옆에 안읽은 메세지가 있을 때 뜨는 동그라미 추가
//                              children: <Widget>[
//                                Text(
//                                  chat.sender.name,
//                                  style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                  ),
//                                ),
//                                chat.unread
//                                    ? Container(
//                                  margin: const EdgeInsets.only(left: 8),
//                                  width: 7,
//                                  height: 7,
//                                  decoration: BoxDecoration(
//                                    shape: BoxShape.circle,
//                                    color: Colors.amber,
//                                  ),
//                                )
//                                    : Container(
//                                  child: null,
//                                ),
//                              ],
//                            ),
//                            Text(
//                              chat.time,
//                              style: TextStyle(
//                                fontSize: 10.5,
//                                fontWeight: FontWeight.w400,
//                                color: Colors.grey,
//                              ),
//                            )
//                          ],
//                        ),
//                        SizedBox(
//                          height: 5,
//                        ),
//                        Container(
//                          alignment: Alignment.topLeft,
//                          child: Text(
//                            chat.text,
//                            style: TextStyle(
//                              fontSize: 13,
//                              color: Colors.black54,
//                            ),
//                            overflow: TextOverflow.ellipsis,
//                            //글 수가 오버플로시 ...으로 표시
//                            maxLines: 2, //최대 글자줄수는 2줄
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          );
//        },
//      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatRoom(
              chatRoomId: chatRoomId,
            )
        ));
      },
      child: Container(
        decoration: BoxDecoration(border: Border(
          bottom: BorderSide(style: BorderStyle.solid, color: Colors.black26),
        ),),
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
                '마지막 메세지입미당 두줄까지 됩니다아ㅏ아ㅏㅏ아ㅏ아ㅏ아ㅏ아ㅏ아ㅏㅏ아앙아ㅏ아아아아아아아아ㅏ아아아아아아ㅏ아아아아아ㅏ아아아아아앙아ㅏㅏㅏ',
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
//    Container(
//        color: Colors.black26,
//        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//        child: Row(
//          children: [
//            Container(
//              height: 30,
//              width: 30,
//              decoration: BoxDecoration(
//                  color: Colors.black,
//                  borderRadius: BorderRadius.circular(30)),
//              child: Text(userName.substring(0, 1),
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 16,
//                      fontFamily: 'OverpassRegular',
//                      fontWeight: FontWeight.w300)),
//            ),
//            SizedBox(
//              width: 12,
//            ),
//            Text(userName,
//                textAlign: TextAlign.start,
//                style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 16,
//                    fontFamily: 'OverpassRegular',
//                    fontWeight: FontWeight.w300))
//          ],
//        ),
//      ),
    );
  }
}
