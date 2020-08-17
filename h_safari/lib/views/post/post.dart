import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:h_safari/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/postUpdateDelete.dart';
import 'package:h_safari/views/post/waiting.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Post extends StatefulWidget {
  DocumentSnapshot doc;
  bool isMine;

  Post(DocumentSnapshot document, bool me) {
    doc = document;
    isMine = me;
  }

  @override
  _PostState createState() => _PostState(doc);
}

class _PostState extends State<Post> {
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
  String fnCategory;
  String fnHow;
  String fnEmail;
  String userList;
  List<dynamic> fnCommentUserList;
  List<dynamic> fnWaitingUserList;
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
    fnCommentUserList = doc['commentUserList'];
    fnWaitingUserList = doc['waitingUserList'];
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
    DatabaseMethods().getComments(widget.doc.documentID).then((val) {
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
    currentEmail = fp.getUser().email.toString();
    getHow();
    return GestureDetector(
      onTap: () {
        isRecomment = false;
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
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
                      actions: widget.isMine
                          ? (fnClose
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
                                                  builder: (context) => Waiting(
                                                      fnId,
                                                      fnName,
                                                      fnWaitingUserList)));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.border_color,
                                            color: Colors.green),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      postUpdateDelete(
                                                          widget.doc)));
                                        },
                                      ),
                                    ],
                                  )
                                ])
                          : null,
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(10.0),
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
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: imgUrl != ''
                                                    ? fnClose
                                                        ? Stack(
                                                            children: <Widget>[
                                                              Container(
                                                                  width: 250,
                                                                  height: 250,
                                                                  child: Image
                                                                      .network(
                                                                    imgUrl,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                              Container(
                                                                  width: 250,
                                                                  height: 250,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/sample/close2.png',
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                            ],
                                                          )
                                                        : Container(
                                                            width: 250,
                                                            height: 250,
                                                            child:
                                                                Image.network(
                                                              imgUrl,
                                                              fit: BoxFit.fill,
                                                            ))
                                                    : fnClose
                                                        ? Stack(
                                                            children: <Widget>[
                                                              Container(
                                                                width: 250,
                                                                height: 250,
                                                                child:
                                                                    Image.asset(
//                                                                  'assets/sample/safarilogo.png',
                                                                  'Logo/empty_Rabbit_green1_gloss.png.png',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              Container(
                                                                  width: 250,
                                                                  height: 250,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/sample/close2.png',
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                            ],
                                                          )
                                                        : Image.asset(
                                                            'Logo/empty_Rabbit_green1_gloss.png.png',
                                                            fit: BoxFit.fill,
                                                          ));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: map<Widget>(fnImageList,
                                          (index, url) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '가격 : $fnPrice원',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ButtonTheme(
                                    height: 30,
                                    child: FlatButton(
                                      shape: OutlineInputBorder(),
                                      child: Text(
                                        fnClose
                                            ? '마감'
                                            : (widget.isMine ? '거래마감' : '구매신청'),
                                        style: TextStyle(
                                            color: fnClose
                                                ? Colors.red
                                                : Colors.green),
                                      ),
                                      onPressed: () {
                                        fnClose
                                            ? null
                                            : widget.isMine
                                                ? Close(context)
                                                : purchaseApplication(context);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: commentWindow(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                isRecomment
                    ? Container(
                        child: Text(
                          '대댓글 작성중..',
                        ),
                        alignment: Alignment.centerLeft,
                        height: 25,
                        padding: EdgeInsets.only(left: 20),
                        color: Colors.green[50],
                      )
                    : Container(),
                Container(
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
                            isRecomment ? addReComment(redocId) : addComment();
                            isRecomment = false;
                            FocusManager.instance.primaryFocus.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
    await showDialog(
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
                  if (fnWaitingUserList.contains(fp.getUser().email)) {
                    Navigator.pop(context, '확인');
                    already(context);
                  } else {
                    fnWaitingUserList.add(fp.getUser().email);
                    Firestore.instance
                        .collection('post')
                        .document(widget.doc.documentID)
                        .updateData({
                      "waitingUserList": fnWaitingUserList,
                    });
                    Map<String, dynamic> purchaseApplication = {
                      "postName": fnName,
                      "type": "구매신청",
                      "sendBy": currentEmail,
                      "time": new DateFormat('yyyy-MM-dd')
                          .add_Hms()
                          .format(DateTime.now()),
                      "postID": widget.doc.documentID,
                      "unread": true,
                    };
                    Map<String, dynamic> userList = {
                      "sendBy": currentEmail,
                      "time": new DateFormat('yyyy-MM-dd')
                          .add_Hms()
                          .format(DateTime.now()),
                      "postID": widget.doc.documentID,
                    };
                    // post에 저장
                    DatabaseMethods()
                        .sendNotification(fnEmail, purchaseApplication);
                    DatabaseMethods().updateUnreadNotification(fnEmail, false);
                    DatabaseMethods()
                        .addWant(currentEmail, widget.doc.documentID, userList);
                    Navigator.pop(context, '확인');
                    success(context);
                  }
                },
              )
            ],
          );
        });
  }

  void Close(BuildContext context) async {
    await showDialog(
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
                  DatabaseMethods().closePost(widget.doc.documentID);
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
    await showDialog(
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
        "postID": widget.doc.documentID,
        "unread": true,
      };
      if (fnCommentUserList.contains(fp.getUser().email)) {
      } else {
        fnCommentUserList.add(fp.getUser().email);
        Firestore.instance
            .collection('post')
            .document(widget.doc.documentID)
            .updateData({
          "commentUserList": fnCommentUserList,
        });
      }
      DatabaseMethods().addComment(widget.doc.documentID, commentMap);
      DatabaseMethods().updateUnreadNotification(fnEmail, true);
      for (int i = 0; i < fnCommentUserList.length; i++) {
        if (fnCommentUserList[i] != fp.getUser().email) {
          DatabaseMethods()
              .sendNotification(fnCommentUserList[i], commentNotification);
          DatabaseMethods()
              .updateUnreadNotification(fnCommentUserList[i], true);
        }
      }
      setState(() {
        commentEditingController.text = "";
      });
    }
  }

  void addReComment(redocId) {
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
        "postID": widget.doc.documentID,
        "unread": true,
      };
      if (fnCommentUserList.contains(fp.getUser().email)) {
      } else {
        fnCommentUserList.add(fp.getUser().email);
        Firestore.instance
            .collection('post')
            .document(widget.doc.documentID)
            .updateData({
          "commentUserList": fnCommentUserList,
        });
      }
      DatabaseMethods()
          .addReComment(widget.doc.documentID, redocId, recommentMap);
      for (int i = 0; i < fnCommentUserList.length; i++) {
        if (fnCommentUserList[i] != fp.getUser().email) {
          DatabaseMethods()
              .sendNotification(fnCommentUserList[i], recommentNotification);
          DatabaseMethods()
              .updateUnreadNotification(fnCommentUserList[i], true);
        }
      }
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
                children: snapshot.data.documents.map<Widget>(
                  (DocumentSnapshot document) {
                    return Column(
                      children: <Widget>[
                        commentTile(document['sendBy'], document['comment'],
                            document['date'], document.documentID),
                        SizedBox(
                          height: 5,
                        ),
                        StreamBuilder(
                          stream: Firestore.instance
                              .collection("post")
                              .document(widget.doc.documentID)
                              .collection("comments")
                              .document(document.documentID)
                              .collection("recomments")
                              .orderBy('date')
                              .snapshots(),
                          builder: (context, snapshots) {
                            String codocId = document.documentID;
                            return snapshots.hasData
                                ? ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    shrinkWrap: true,
                                    children: snapshots.data.documents
                                        .map<Widget>(
                                            (DocumentSnapshot document) {
                                      return recommentTile(
                                          document['sendBy'],
                                          document['recomment'],
                                          document['date'],
                                          codocId,
                                          document.documentID);
                                    }).toList(),
                                  )
                                : Container();
                          },
                        ),
                        Divider(
                          color: Colors.black45,
                        )
                      ],
                    );
                  },
                ).toList(),
              )
            : Container();
      },
    );
  }

  Widget text(String name) {
    if (name == currentEmail)
      return Text('나',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.green[700]));
    else if (name == fnEmail)
      return Text('글쓴이',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700]));
    else
      return Text('익명',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
  }

  Widget commentTile(
      String name, String comment, String date, String documentID) {
    var allTime = date.split(RegExp(r"-| |:"));
    var month = allTime[1];
    var day = allTime[2];
    var hour = allTime[3];
    var minute = allTime[4];
    var time = month + "/" + day + " " + hour + ":" + minute;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text(name),
              name == currentEmail
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 15, 0),
                      child: InkWell(
                        child: Icon(
                          Icons.delete_outline,
                          size: 16,
                          color: Colors.black45,
                        ),
                        onTap: () {
                          deleteComment(documentID);
                        },
                      ),
                    )
                  : Container()
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(comment),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                time,
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
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget recommentTile(String name, String comment, String date, String codocId,
      String documentID) {
    var allTime = date.split(RegExp(r"-| |:"));
    var month = allTime[1];
    var day = allTime[2];
    var hour = allTime[3];
    var minute = allTime[4];
    var time = month + "/" + day + " " + hour + ":" + minute;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.subdirectory_arrow_right, size: 20, color: Colors.black45),
        Expanded(
          child: Container(
            color: Colors.grey[200],
            margin: EdgeInsets.fromLTRB(5, 0, 0, 3),
            padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(name),
                    name == currentEmail
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 3, 6, 0),
                            child: InkWell(
                              child: Icon(
                                Icons.delete_outline,
                                size: 16,
                                color: Colors.black45,
                              ),
                              onTap: () {
                                deleteReComment(codocId, documentID);
                              },
                            ),
                          )
                        : Container()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 3),
                  child: Text(comment),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  deleteComment(String codocId) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          {
            return AlertDialog(
              content: Text('댓글을 삭제하시겠습니까?'),
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
                    DatabaseMethods()
                        .deleteComment(widget.doc.documentID, codocId);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
        });
  }

  deleteReComment(String codocId, String recodocId) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          {
            return AlertDialog(
              content: Text('댓글을 삭제하시겠습니까?'),
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
                    DatabaseMethods().deleteReComment(
                        widget.doc.documentID, codocId, recodocId);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
        });
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

  void success(BuildContext context) async {
    await showDialog(
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

  void already(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('이미 신청하신 상태입니다!'),
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
