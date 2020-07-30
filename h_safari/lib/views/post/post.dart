import 'package:flutter/material.dart';
import 'package:h_safari/views/chat/chatRoom.dart';
import 'package:h_safari/views/post/write.dart';
import '../main/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chat/database.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  DocumentSnapshot tp;

  Post(DocumentSnapshot doc) {
     tp = doc;
  }
  @override
  _PostState createState() => _PostState(tp);
}

class _PostState extends State<Post> {

  DatabaseMethods databaseMethods = new DatabaseMethods();

  String fnName;
  String fnDes;
  String fnDate;
  String fnPrice;
  String fnImage;
  String fnUid;
  String fnCategory;
  String fnHow ;
  String fnEmail;



  _PostState(DocumentSnapshot doc){
    fnName = doc['name'];
    fnDes = doc['description'];
    var date = doc['datetime'].toDate();//timestamp to datetime
    fnDate = DateFormat('yyyy-MM-dd').add_Hms().format(date);//datetime format
    fnPrice = doc['price'];
    fnImage = doc['imageUrl'];
    fnUid = doc['uid'];
    fnCategory = doc['category'];
    fnHow = doc['how'];
    fnEmail = doc['email'];
  }

  FirebaseProvider fp;
  bool favorite = false;

  bool checkDelivery = false ;
  bool checkDirect = false ;
  Widget appBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.green[100],
      leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.green,
        ),
        onTap: () {
          Navigator.pop(context);
        },
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
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    getHow();
    
    return Scaffold(
      appBar: appBar('$fnName'),
      bottomNavigationBar: BottomAppBar( //화면 하단에 찜하기, 구매 신청 버튼, 대기번호, 댓글 버튼을 넣는 앱바
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton( //찜 버튼. 누르면 아이콘은 바뀌지만 찜해놓은 게시글만 모아놓는건 미구현
              icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
              onPressed: () {
                setState(() {
                  favorite = !favorite;
                });},
            ),
            RawMaterialButton( //구매 신청 버튼. 사용자에게 어떻게 알림이 갈 것인지 구상해야 합니다.
              child: Text('구매 신청'),
              onPressed: () {
                sendAlarm(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RawMaterialButton( //내가 몇 번째로 구매 신청 버튼을 눌렀는지 확인하는 버튼. 메세지 창은 뜨지만 아직 내부(대기번호)는 미구현.
                  child: Text('대기번호'),
                  onPressed: () {
                    ShowListnum(context);
                  },
                ),
                RawMaterialButton( //누르면 게시글에 대한 댓글창을 띄우는 버튼(창은 이동하지만 댓글은 미구현)
                  //잠깐 메세지 버튼으로 쓸게요~~
                  child: Text('댓글 & 메세지'),
                  onPressed: () {
                      sendMessage(fnEmail);
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => Comment()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( //화면 스크롤 가능하게
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //이미지 넣는건 구현했지만 두 가지 더 구현해야해요.
                // 1. 연동시켜서 사용자가 올린 사진을 가져올 것,
                // 2. 사진 사이즈가 크면 화면 밖으로 나가지 않게 사이즈 조절
                // 3. 사진 여러 장 올리면 옆으로 밀어서 더 볼 수 있게
                //확인
                child: Center(child: Image.network(fnImage)),
              ),

              SizedBox(height: 30,),

              //일단 틀만 잡는 거라서 전부 텍스트로 직접 입력했는데 연동하면 게시글 작성한 부분에서 가져와야 할듯 합니다.
              Text('가격 : $fnPrice', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('설명\n$fnDes', style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Text('카테고리 : $fnCategory', style: TextStyle(fontSize: 15, color: Colors.black54),),
              SizedBox(height: 10,),

              SizedBox(height: 15,),

              Row( //게시글 작성할때 선택한 부분만 뜨도록 수정 완료
                children: [
                  Text('택배', style: TextStyle(fontSize: 15, color: Colors.black),),
                  Icon(checkDelivery ? Icons.check_box : Icons.check_box_outline_blank),
                  Text('      '),
                  Text('직접거래', style: TextStyle(fontSize: 15),),
                  Icon(checkDirect ? Icons.check_box : Icons.check_box_outline_blank),
                ],
              ),

              SizedBox(height: 30,),

              //게시글 작성에 있던 글 설명. 연동해서 가져오면 그대로 넣으면 될 것 같아요.
              Text('게시일 : $fnDate\n 연락처: 010-1234-1234'),
//              new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now())
            ],
          )
        ),
      ),
    );
  }
  void sendMessage(String email) async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String _user = user.email.toString();

    List<String> users = [_user, email];

    String chatRoomId = getChatRoomId(_user, email);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ChatRoom(
          chatRoomId: chatRoomId,
        )
    ));
  }

  void getHow(){
    int tp = int.parse(fnHow);
    if(tp == 3){
      checkDelivery = true ;
      checkDirect = true ;
    }else if(tp == 2){
      checkDelivery = false ;
      checkDirect = true ;
    }else if(tp == 1){
      checkDelivery = true ;
      checkDirect = false ;
    }
  }

  void sendAlarm(BuildContext context)async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('신청 알림을 보내시겠습니까?'),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Map<String, dynamic> alertToUser = {
                    "postName" : fnName,
                    "type" : "구매신청",
                    "sendBy" : "",
                    "time" : new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
                  };
                  sendAlert("구매신청", alertToUser);
                  Navigator.pop(context, '확인');
                  Buy(context);
                },
              )],
          );
        }
    );
  }

  void sendAlert(String type, alertToUser){
      Firestore.instance
          .collection("users")
          .document(fnEmail)
          .collection("alert")
          .add(alertToUser)
          .catchError((e){
            print(e.toString());
      });
  }
}

void ShowListnum(BuildContext context) async {
  String result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('현재 대기번호', style: TextStyle(fontWeight: FontWeight.bold),),
        content: Text('현재 나의 대기번호는 1번째 입니다.'),
        actions: <Widget>[
          FlatButton(
            child: Text('확인'),
            onPressed: (){
              Navigator.pop(context, '확인');
            },
          )
        ],
      );
    }
  );
}


void Buy(BuildContext context) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('판매자에게 신청 알림을 보냈습니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: (){
                Navigator.pop(context, '확인');
                },
            )],
        );
      }
  );
}



getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}