import 'package:flutter/material.dart';
import 'package:h_safari/views/chat/chatRoom.dart';
import 'package:h_safari/views/post/postUpdateDelete.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/services/database.dart';
import 'package:h_safari/views/post/waiting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MyPost extends StatefulWidget {
  DocumentSnapshot tp;

  MyPost(DocumentSnapshot doc) {
    tp = doc;
  }

  @override
  _MyPostState createState() => _MyPostState(tp);
}

class _MyPostState extends State<MyPost> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController commentEditingController = new TextEditingController();
  Stream<QuerySnapshot> comments;

  String fnName;
  String fnDes;
  String fnDate;
  String fnPrice;
  String fnImage;
  List<dynamic> fnImageList;
  String fnUid;
  String fnHow;

  String fnCategory;
  String fnEmail;
  bool fnDoing;
  bool fnClose;
  List<dynamic> fnUserList;

  String fnId;

  _MyPostState(DocumentSnapshot doc) {
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
    fnDoing = doc['doing'];
    fnClose = doc['close'];
    fnUserList = doc['userList'];
    fnId = doc.documentID;
  }

  @override
  void initState() {
    DatabaseMethods().getComments(widget.tp.documentID).then((val) {
      setState(() {
        comments = val;
      });
    });

    super.initState();
  }

  FirebaseProvider fp;
  bool favorite = false;

  bool checkDelivery = false;

  bool checkDirect = false;

  var _blankFocusnode = new FocusNode(); //키보드 없애는 용
  bool closed = false; //글 마감됐는지 아닌지 확인하는 변수 //문제가 글 하나가 아닌 내가 쓴 전체 글이 완료가 되어벌미

  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undPriceCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    getHow();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: NestedScrollView(//화면 스크롤 가능하게
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.green),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  '$fnName',
                  style: TextStyle(color: Colors.black),
                ),
                floating: true,
                actions: fnClose
                    ? null
                    : <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.assignment,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Waiting(fnId, fnName)));
                              },
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.border_color, color: Colors.green),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            postUpdateDelete(widget.tp)));
                              },
                            ),
                          ],
                        )
                      ],
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
                          child: Container(
                              //사진이 없을때는 우리 로고 올리는 것도 좋을듯요.
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  itemCount: fnImageList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Transform.scale(
                                      scale: 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image:
                                              NetworkImage(fnImageList[index]),
                                          fit: BoxFit.fitHeight,
                                          //fit: BoxFit.cover
                                        )),
                                      ),
                                    );
                                  })),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        //일단 틀만 잡는 거라서 전부 텍스트로 직접 입력했는데 연동하면 게시글 작성한 부분에서 가져와야 할듯 합니다.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '가격 : $fnPrice원',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            ButtonTheme(
                              height: 30,
                              child: FlatButton(
                                shape: OutlineInputBorder(),
                                child: Text(
                                  fnClose ? '마감' : '거래마감',
                                  style: TextStyle(
                                      color:
                                          fnClose ? Colors.red : Colors.green),
                                ),
                                onPressed: () {
                                  fnClose ? null : Close(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$fnName',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$fnDes',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '$fnDate',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '$fnCategory',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            Row(
                              //게시글 작성할때 선택한 부분만 뜨도록 수정 완료
                              children: [
                                Text(
                                  '택배',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  checkDelivery
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: checkDelivery
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 15,),
                                Text(
                                  '직접거래',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  checkDirect
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: checkDelivery
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(color: Colors.black,),

                        SizedBox(height: 10,),

                        Text('댓글', style: TextStyle(fontWeight: FontWeight.bold),),

                        SizedBox(height: 10,),
                      ],
                    )),
                commentWindow(),

                SizedBox(height: 10,),
              ],
            ),
          ),
        ),


        bottomNavigationBar: fnClose
            ? null
            : BottomAppBar(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: TextFormField(
                              controller: commentEditingController,
                              decoration: InputDecoration(
                                hintText: 'Comment',
                                contentPadding: EdgeInsets.all(7.0),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonTheme(
                          height: 30,
                          child: FlatButton(
                            shape: OutlineInputBorder(),
                            child: Text(
                              '댓글 등록',
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              addComment();
                              FocusManager.instance.primaryFocus.unfocus();
                            },
                          ),
                        ),
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

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatRoom(
                  chatRoomId: chatRoomId,
                )));
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

  void Close(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('판매 글을 마감하시겠습니까?'),
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
                  DatabaseMethods().closePost(widget.tp.documentID);
                  Navigator.pop(context, '취소');
                  fnClose = true;
                  setState(() {});
                },
              )
            ],
          );
        });
  }

  void CloseDialog(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('마감하였습니다.'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context, '확인');
                  closed = !closed;
                },
              )
            ],
          );
        });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addComment() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    if (commentEditingController.text.isNotEmpty) {
      Map<String, dynamic> commentMap = {
        "sendBy": currentUser.email,
        "comment": commentEditingController.text,
        'date': new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
      };
      DatabaseMethods().addComment(widget.tp.documentID, commentMap);
      setState(() {
        commentEditingController.text = "";
      });
    }
  }

  Widget commentTile(String name, String comment, String date) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          Text(comment),
          Text(
            date,
            style: TextStyle(color: Colors.black38, fontSize: 12),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  commentWindow() {
    return StreamBuilder(
      stream: comments,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return commentTile(
                      snapshot.data.documents[index].data["sendBy"],
                      snapshot.data.documents[index].data["comment"],
                      snapshot.data.documents[index].data["date"]);
                })
            : Container();
      },
    );
  }
}
