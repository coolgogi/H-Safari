import 'package:flutter/cupertino.dart';
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
import 'package:h_safari/widget/widget.dart';
import 'write.dart';

class Post extends StatefulWidget {
  DocumentSnapshot tp;
  String documentID;

  Post(DocumentSnapshot doc, String documentID) {
    tp = doc;
    this.documentID = documentID;
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
  List<dynamic> fnImageList;
  String fnUid;
  String fnCategory;
  String fnHow;
  String fnEmail;


  _PostState(DocumentSnapshot doc) {
    fnName = doc['name'];
    fnDes = doc['description'];
    var date = doc['datetime'].toDate(); //timestamp to datetime
    fnDate = DateFormat('yyyy-MM-dd').add_Hms().format(date); //datetime format
    fnPrice = doc['price'];
    fnImage = doc['imageUrl'];
    fnImageList = doc['imageList'];
    fnUid = doc['uid'];
    fnCategory = doc['category'];
    fnHow = doc['how'];
    fnEmail = doc['email'];
  }

  FirebaseProvider fp;
  bool favorite = false;

  bool checkDelivery = false;

  bool checkDirect = false;

  int comment = 0; //댓글 갯수 표시용 변수
  var _blankFocusnode = new FocusNode(); //키보드 없애는 용

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    getHow();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar( //화면 하단에 찜하기, 구매 신청 버튼, 대기번호, 댓글 버튼을 넣는 앱바
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Comment',
                          contentPadding: EdgeInsets.all(7.0),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    height: 30,
                    child: FlatButton(
                      shape: OutlineInputBorder(),
                      child: Text('댓글 등록', style: TextStyle(color: Colors
                          .green),),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        body: NestedScrollView( //화면 스크롤 가능하게
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.green),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text('$fnName', style: TextStyle(color: Colors.black),),
                floating: true,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container( //사진이 없을때는 우리 로고 올리는 것도 좋을듯요.
                            height: 250,
                            width: MediaQuery.of(context).size.width * fnImageList.length.toDouble(),
                            child: GridView.count(
                                crossAxisCount: fnImageList.length,
                                crossAxisSpacing: 10,
                                children: List.generate(fnImageList.length, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(fnImageList[index]),
                                          //fit: BoxFit.fitHeight
                                        )
                                    ),
                                  );
                                })
                            )
                          ),
                        ),

                        Divider(color: Colors.black,),

                        //일단 틀만 잡는 거라서 전부 텍스트로 직접 입력했는데 연동하면 게시글 작성한 부분에서 가져와야 할듯 합니다.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('가격 : $fnPrice원', style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),),
                            ButtonTheme(
                              height: 30,
                              child: FlatButton(
                                shape: OutlineInputBorder(),
                                child: Text('구매신청',
                                  style: TextStyle(color: Colors.green),),
                                onPressed: () {
                                  sendAlarm(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black,),
                        SizedBox(height: 10,),

                        Text('$fnName', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text('$fnDes', style: TextStyle(fontSize: 15),),
                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('$fnDate', style: TextStyle(fontSize: 12),),
                          ],
                        ),

                        Divider(color: Colors.black,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$fnCategory', style: TextStyle(
                                fontSize: 15, color: Colors.black54),),

                            Row( //게시글 작성할때 선택한 부분만 뜨도록 수정 완료
                              children: [
                                Text('택배', style: TextStyle(fontSize: 15),),
                                Icon(checkDelivery ? Icons.check_box : Icons
                                    .check_box_outline_blank,
                                  color: checkDelivery ? Colors.green : Colors
                                      .grey,),
                                Text('      '),
                                Text('직접거래', style: TextStyle(fontSize: 15),),
                                Icon(checkDirect ? Icons.check_box : Icons
                                    .check_box_outline_blank,
                                  color: checkDelivery ? Colors.green : Colors
                                      .grey,),
                              ],
                            ),
                          ],
                        ),

                        Divider(color: Colors.black,),
                        SizedBox(height: 10,),

                        Text('댓굴 $comment',
                          style: TextStyle(fontWeight: FontWeight.bold),),
//              new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now())

                        Row( //임시 버튼
                          children: <Widget>[
                            RawMaterialButton( //내가 몇 번째로 구매 신청 버튼을 눌렀는지 확인하는 버튼. 메세지 창은 뜨지만 아직 내부(대기번호)는 미구현.
                              shape: OutlineInputBorder(),
                              child: Text('대기번호'),
                              onPressed: () {
                                ShowListnum(context);
                              },
                            ),
                            RawMaterialButton( //누르면 게시글에 대한 댓글창을 띄우는 버튼(창은 이동하지만 댓글은 미구현)
                              shape: OutlineInputBorder(),
                              //잠깐 메세지 버튼으로 쓸게요~~
                              child: Text('댓글 & 메세지'),
                              onPressed: () {
                                sendMessage(fnEmail);
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => Comment()));
                              },
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
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
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            ChatRoom(
              chatRoomId: chatRoomId,
            )
    ));
  }

  void getHow() {
    int tp = int.parse(fnHow);
    if (tp == 3) {
      checkDelivery = true;
      checkDirect = true;
    } else if (tp == 2) {
      checkDelivery = false;
      checkDirect = true;
    } else if (tp == 1) {
      checkDelivery = true;
      checkDirect = false;
    }
  }

  void sendAlarm(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('신청 알림을 보내시겠습니까?'),
            actions: <Widget>[
              FlatButton(
                child: Text('취소', style: TextStyle(color: Colors.green),),
                onPressed: () {
                  Navigator.pop(context, '취소');
                },
              ),

              FlatButton(
                child: Text('확인', style: TextStyle(color: Colors.green),),
                onPressed: () {
                  Map<String, dynamic> alertToUser = {
                    "postName" : fnName,
                    "type" : "구매신청",
                    "sendBy" : fnEmail,
                    "time" : new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
                    "postID" : widget.documentID,
                    "unread" : true,
                  };
                  sendAlert("구매신청", alertToUser);
                  Navigator.pop(context, '확인');
                  Buy(context);
                },
              )
            ],
          );
        }
    );
  }

  void sendAlert(String type, alertToUser) {
    Firestore.instance
        .collection("users")
        .document(fnEmail)
        .collection("alert")
        .add(alertToUser)
        .catchError((e) {
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
          title: Text(
            '현재 대기번호', style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text('현재 나의 대기번호는 1번째 입니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
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
              child: Text('확인', style: TextStyle(color: Colors.green),),
              onPressed: () {
                Navigator.pop(context, '확인');
              },
            )
          ],
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