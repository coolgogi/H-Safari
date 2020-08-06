import 'package:flutter/material.dart';
import 'package:h_safari/views/chat/chatRoom.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/views/post/postUpdateDelete.dart';
import 'package:h_safari/views/post/write.dart';
import '../main/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/database.dart';
import 'package:intl/intl.dart';
import 'package:h_safari/widget/widget.dart';
import 'dart:math';

class MyPost extends StatefulWidget {
  DocumentSnapshot tp;
  String documentID;

  MyPost(DocumentSnapshot doc, String documentID) {
    tp = doc;
    this.documentID = documentID;
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
  List<dynamic> fnUserList;


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
    fnUserList = doc['userList'];
  }

  FirebaseProvider fp;
  bool favorite = false;

  bool checkDelivery = false;

  bool checkDirect = false;

  int comment = 0; //댓글 갯수 표시용 변수
  var _blankFocusnode = new FocusNode(); //키보드 없애는 용
  bool closed = false; //글 마감됐는지 아닌지 확인하는 변수 //문제가 글 하나가 아닌 내가 쓴 전체 글이 완료가 되어벌미

  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undPriceCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    getHow();
    Stream:

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
        body: NestedScrollView(
          //화면 스크롤 가능하게
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
                actions: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.assignment,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          ShowList(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.border_color, color: Colors.green),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => postUpdateDelete(widget.tp)));
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
                                  itemBuilder: (BuildContext context, int index) {
                                    return Transform.scale(
                                      scale: 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(fnImageList[index]),
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
                                  '구매완료',
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () {
                                  Close(context);
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
                            Text('$fnCategory', style: TextStyle(fontSize: 15, color: Colors.black54),),
                            Row(
                              //게시글 작성할때 선택한 부분만 뜨도록 수정 완료
                              children: [
                                Text('택배', style: TextStyle(fontSize: 15),),
                                Icon(checkDelivery ? Icons.check_box : Icons.check_box_outline_blank,
                                  color: checkDelivery ? Colors.green : Colors.grey,
                                ),
                                Text('      '),
                                Text('직접거래', style: TextStyle(fontSize: 15),),
                                Icon(checkDirect ? Icons.check_box : Icons.check_box_outline_blank,
                                  color: checkDelivery ? Colors.green : Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),

                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text('댓글 $comment', style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                commentWindow(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
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
                              borderSide: BorderSide(color: Colors.green)),
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

//  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
//    _undNameCon.text = fnName;
//    _undPriceCon.text = fnPrice;
//    _undDescCon.text = fnDes;
//    showDialog(
//      barrierDismissible: false,
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.all(Radius.circular(10.0))
//          ),
//          title: Text("Update/Delete Document"),
//          content: Container(
//            height: 200,
//            child: Column(
//              children: <Widget>[
//                TextField(
//                  decoration: InputDecoration(labelText: "Name"),
//                  controller: _undNameCon,
//                ),
//                TextField(
//                  decoration: InputDecoration(labelText: "Price"),
//                  controller: _undPriceCon,
//                ),
//                TextField(
//                  decoration: InputDecoration(labelText: "Description"),
//                  controller: _undDescCon,
//                )
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("Cancel"),
//              onPressed: () {
//                _undNameCon.clear();
//                _undDescCon.clear();
//                Navigator.pop(context);
//              },
//            ),
//            FlatButton(
//              child: Text("Update"),
//              onPressed: () {
//                if (_undNameCon.text.isNotEmpty &&
//                    _undDescCon.text.isNotEmpty) {
//                  updateDoc(doc.documentID, _undNameCon.text, _undPriceCon.text ,_undDescCon.text);
//                  fnName = _undNameCon.text;
//                  fnPrice = _undPriceCon.text;
//                  fnDes = _undDescCon.text;
//                }
//                Navigator.pop(context);
//              },
//            ),
//            FlatButton(
//              child: Text("Delete"),
//              onPressed: () {
//                deleteDoc(doc.documentID);
//                Navigator.pop(context);
//              },
//            )
//          ],
//        );
//      },
//    );
//  }
//
//  // 문서 갱신 (Update)
//  void updateDoc(String docID, String name, String price, String description) {
//    Firestore.instance.collection('post').document(docID).updateData({
//      "name": name,
//      "price": price,
//      "description": description,
//    });
//  }
//
//  // 문서 삭제 (Delete)
//  void deleteDoc(String docID) {
//    Firestore.instance.collection('post').document(docID).delete();
//  }

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
                  Map<String, dynamic> alertToUser = {
                    "postName": fnName,
                    "type": "구매신청",
                    "sendBy": "",
                    "time": new DateFormat('yyyy-MM-dd')
                        .add_Hms()
                        .format(DateTime.now()),
                  };
                  Navigator.pop(context, '확인');
                  CloseDialog(context);
                },
              )
            ],
          );
        });
  }

  void ShowList(BuildContext context) async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '현재 신청자',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: ListTile(
              title : Text(fnUserList[0]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context, '확인');
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
      DatabaseMethods().addComment(widget.documentID, commentMap);
      setState(() {
        commentEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getComments(widget.documentID).then((val) {
      setState(() {
        comments = val;
      });
    });
    super.initState();
  }

  Widget commentTile(String name, String comment, String date) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          Text(comment),
          Text(date, style: TextStyle(color: Colors.black38, fontSize: 12),),
          Divider(color: Colors.black,)
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

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  List<String> test = ['신청자1', '신청자2', '신청자3', '신청자4', '신청자5'];

  @override
  Widget build(BuildContext context) {
    // 이름 만드는 리스트
    var deco = ['귀여운', '잘생긴', '못생긴', '뚱뚱한', '착한', '한동대', '키가 큰', '키가 작은'];
    var animal = ['토끼', '강아지', '기린', '큰부리새', '김광일?', '코뿔소', '하마', '코끼리', '표범'];

    // 랜덤 변수 지정
    final _random = new Random();

    // 이름 값을 저장하는 리스트. (DB랑 연결되면 DB에 저장이 될 예정)
    List<String> names = [];

    for (int j = 1; j <= 10; j++) {
      // decoWord : 꾸미는 단어 랜덤으로 뽑기
      var decoWord = deco[_random.nextInt(deco.length)];
      // animal : 동물 단어 랜덤으로 뽑기
      var animalWord = animal[_random.nextInt(animal.length)];
      // userWord : 유저별 랜덤이름
      var userWord = decoWord + ' ' + animalWord;

      // userWord를 리스트 names에 삽입. (DB랑 연결되면 DB에 추가할 예정)
      names.add(userWord);
    }
    return GestureDetector(
      child: ListView.builder(
          // shrinkWrap : (무슨 역할인지,, 모르겠어요)
          shrinkWrap: true,

          // itemCount : userName이 저장된 리스트 names의 길이만큼 다이어로그에 보여준다.
          itemCount: names.length,

          // itemBuilder : userName이 보여지는 공간
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              // padding : padding을 아래 10px 지정
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                // ListTile의 스타일 지정
                decoration: BoxDecoration(

                    // 모서리 둥근 정도
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // 배경색
                    color: Colors.green[200]),
                height: 55,
                width: double.maxFinite,
                child: //Text('$test[index]'),
                    ListTile(
                        title: Text('[' +
                            (index + 1).toString() +
                            '] ' +
                            names[index])),
              ),
            );
          }),
    );
  }
}
