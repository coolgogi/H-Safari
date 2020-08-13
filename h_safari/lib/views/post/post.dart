import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  TextEditingController commentEditingController = new TextEditingController();
  Stream<QuerySnapshot> comments;
  Stream<QuerySnapshot> recomments;

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
  String userList;
  List<dynamic> fnUserList;
  String fnId;
  bool fnClose;

  String currentEmail;

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
    fnId = doc.documentID;
    fnUserList = doc['userList'];
    fnClose = doc['close'];
  }

  FirebaseProvider fp;
  bool favorite = false;
  bool checkDelivery = false;
  bool checkDirect = false;

  var _blankFocusnode = new FocusNode(); //키보드 없애는 용
  var _recommentFocusnode = FocusNode();

  bool isRecomment = false;
  var redocId;

  @override
  void initState() {
    DatabaseMethods().getComments(widget.tp.documentID).then((val) {
      setState(() {
        comments = val;
      });
    });
    super.initState();
  }

  CarouselSlider carouselSlider;
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    getHow();
    currentEmail = fp.getUser().email.toString();

    return GestureDetector(
      onTap: () {
        isRecomment = false;
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
        body: NestedScrollView(
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
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CarouselSlider(
                                height: 250,
                                initialPage: 0,
                                enlargeCenterPage: true,
                                autoPlay: false,
                                reverse: false,
                                enableInfiniteScroll: false,
//                                autoPlayInterval: Duration(seconds: 2),
//                                autoPlayAnimationDuration: Duration(milliseconds: 1000),
//                                pauseAutoPlayOnTouch: Duration(seconds: 2),
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                                items: fnImageList.map((imgUrl) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                          ),
                                          child: imgUrl != ''
                                              ? Image.network(
                                                  imgUrl,
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.asset(
                                                  'assets/sample/LOGO.jpg',
                                                  fit: BoxFit.fill,
                                                ));
                                    },
                                  );
                                }).toList(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    map<Widget>(fnImageList, (index, url) {
                                  return Container(
                                    width: 15.0,
                                    height: 15.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index
                                          ? Colors.redAccent
                                          : Colors.green,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
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
                                  fnClose ? '마감' : '구매신청',
                                  style: TextStyle(
                                      color:
                                          fnClose ? Colors.red : Colors.green),
                                ),
                                onPressed: () {
                                  fnClose ? null : purchaseApplication(context);
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
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '직접거래',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  checkDirect
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: checkDirect
                                      ? Colors.green
                                      : Colors.grey,
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
                        Text(
                          '댓글',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                commentWindow(),
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
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.075,
                    padding: EdgeInsets.fromLTRB(15, 8, 10, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            focusNode: _recommentFocusnode,
                            controller: commentEditingController,
                            decoration: InputDecoration(
                              hintText: '댓글 달기',
                              fillColor: Colors.grey[200],
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 60,
                          child: FlatButton(
                            shape: OutlineInputBorder(),
                            child: Text(
                              '등록', //아이콘으로 바꾸기
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              isRecomment
                                  ? addReComment(redocId)
                                  : addComment();
                              isRecomment = false;
                              FocusManager.instance.primaryFocus.unfocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
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

  void purchaseApplication(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('신청 알림을 보내시겠습니까?'),
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
                  //users에 저장
                  Map<String, dynamic> purchaseApplication = {
                    "postName": fnName,
                    "type": "구매신청",
                    "sendBy": currentEmail,
                    "time": new DateFormat('yyyy-MM-dd')
                        .add_Hms()
                        .format(DateTime.now()),
                    "postID": widget.tp.documentID,
                    "unread": true,
                  };
                  Map<String, dynamic> userList = {
                    "sendBy": currentEmail,
                    "time": new DateFormat('yyyy-MM-dd')
                        .add_Hms()
                        .format(DateTime.now()),
                    "postID": widget.tp.documentID,
                  };
                  // post에 저장
                  DatabaseMethods()
                      .sendNotification(fnEmail, purchaseApplication);
                  DatabaseMethods().addWant(
                      fnUserList, currentEmail, widget.tp.documentID, userList);
                  Navigator.pop(context, '확인');
                  Buy(context);
                },
              )
            ],
          );
        });
  }

  void addComment() {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    if (commentEditingController.text.isNotEmpty) {
      Map<String, dynamic> commentMap = {
        "sendBy": currentUser.email,
        "comment": commentEditingController.text,
        'date': new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
      };
      Map<String, dynamic> commentNotification = {
        "postName": fnName,
        "type": "댓글",
        "sendBy": currentUser.email,
        "time": new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
        "postID": widget.tp.documentID,
        "unread": true,
      };
      DatabaseMethods().addComment(widget.tp.documentID, commentMap);
      DatabaseMethods().sendNotification(fnEmail, commentNotification);
      setState(() {
        commentEditingController.text = "";
      });
    }
  }

  void addReComment(redocId) {
    print('실행된다');
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser currentUser = fp.getUser();
    if (commentEditingController.text.isNotEmpty) {
      Map<String, dynamic> recommentMap = {
        "sendBy": currentUser.email,
        "recomment": commentEditingController.text,
        'date': new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
      };
      Map<String, dynamic> recommentNotification = {
        "postName": fnName,
        "type": "댓글",
        "sendBy": currentUser.email,
        "time": new DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
        "postID": widget.tp.documentID,
        "unread": true,
      };
      DatabaseMethods()
          .addReComment(widget.tp.documentID, redocId, recommentMap);
      DatabaseMethods().sendNotification(fnEmail, recommentNotification);
      setState(() {
        commentEditingController.text = "";
      });
    }
  }

  Widget commentWindow() {
    return StreamBuilder(
      stream: comments,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                children:
                    snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                  return commentTile(
                    document['sendBy'],
                    document['comment'],
                    document['date'],
                    document.documentID
                  );
                }).toList(),
              )
            : Container();
      },
    );
  }




  Widget commentTile(String name, String comment, String date, String documentID) {

    recomments = Firestore.instance.collection("post").document(documentID).collection("recomments").snapshots();
    print("==============");
    print(recomments);
    print(documentID);
    print("==============");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          Text(comment),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(color: Colors.black38, fontSize: 12),
              ),
              SizedBox(
                height: 20,
                width: 80,
                child: FlatButton(
                  child: Text(
                    '답글 달기',
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    isRecomment = true;
                    redocId = documentID;
                    FocusScope.of(context).requestFocus(_recommentFocusnode);
                  },
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: recomments,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                children:
                snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                  return recommentTile(
                    document['sendBy'],
                    document['recomment'],
                    document['date'],
                  );
                }).toList(),
              )
                  : Container();
            },
          ),
          Divider(
            color: Colors.black45,
          )
        ],
      ),
    );
  }

  Widget recommentTile(String name, String comment, String date) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          Text(comment),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(color: Colors.black38, fontSize: 12),
              ),
              SizedBox(
                height: 20,
                width: 80,

              )
            ],
          ),
          Divider(
            color: Colors.black45,
          )
        ],
      ),
    );
  }

  void ShowListnum(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '현재 대기번호',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
        });
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
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context, '확인');
                },
              )
            ],
          );
        });
  }
}

//안씀
//getChatRoomId(String a, String b) {
//  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//    return "$b\_$a";
//  } else {
//    return "$a\_$b";
//  }
//}
