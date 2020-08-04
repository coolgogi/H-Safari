import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/post/post(writer).dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/views/chat/database.dart';

class Home extends StatefulWidget {
  String email;

  Home(String tp) {
    email = tp;
  }

  @override
  _HomeState createState() => _HomeState(email);
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  String email;

  FirebaseProvider fp;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String colName = "post";

  // 필드명
  File _image;
  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";
  final String fnImageUrl = 'imageUrl';
  final String fnPrice = 'price';
  final String fnCategory = 'category';
  final String fnHow = 'how'; //거래유형
  final String fnEmail = 'email';
  final List<String> categoryString = [
    "의류",
    "서적",
    "음식",
    "생필품",
    "가구전자제품",
    "뷰티잡화",
    "양도",
    "기타"
  ];
  List<bool> categoryBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  TextEditingController _newNameCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();
  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();

  QuerySnapshot userInfoSnapshot;
  DocumentSnapshot userDoc;
  String userEmail;
  int _counter = 0;

  _HomeState(String tp) {
    email = tp;
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("users")
        .document(userEmail)
        .get()
        .then((doc) {
      userDoc = doc;
    });
    Future.delayed(Duration.zero, () {
      getUserData(userEmail);
    });
  }

  @override
  bool get wantKeepAlive => true;

  getUserData(String passedEmail) {
    Firestore.instance
        .collection("users")
        .document(passedEmail)
        .get()
        .then((doc) {
      setCategoryData(doc);
    });
  }

  setCategoryData(DocumentSnapshot doc) {
    for (int i = 0; i < 8; i++) {
      categoryBool[i] = doc[categoryString[i]];
    }
    ;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp
        .getUser()
        .email
        .toString();

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          //appBar: MyAppBar(),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  backgroundColor: Colors.white,
                  leading: AppBarIcon(),
                  title: AppBarTitle(),
                  actions: <Widget>[AppBarIcon2(),],
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black45,
                    labelColor: Colors.green,
                    labelStyle: TextStyle(
                        fontSize: 15, height: 1, fontWeight: FontWeight.bold),
                    indicatorColor: Colors.green,
                    tabs: <Widget>[
                      Tab(text: '전체'),
                      Tab(text: 'My관심사'),
                    ],
                  ),
                )
              ];
            },

            body: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      //https://pub.dev/packages/carousel_slider 이 사이트로 배너 넣는 방법도 있음
                      allPostList(userEmail),
                      //전체글
                    ], //widget
                  ), //column
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      myPostList(userEmail, userDoc), //마이 카테고리
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  } //build

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection(colName)
        .document(documentID)
        .get()
        .then((doc) {
      showReadPostPage(doc, documentID);
    });
  }

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc, String documentID) {
    _scaffoldKey.currentState..hideCurrentSnackBar();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>

            userEmail == doc['email'] ? MyPost(doc, documentID) : Post(
                doc, documentID)));
  }


  // 문서 갱신 (Update)
  void updateDoc(String docID, String name, String description) {
    Firestore.instance.collection(colName).document(docID).updateData({
      fnName: name,
      fnDescription: description,
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance.collection(colName).document(docID).delete();
  }

  //dialog
  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc, String currentEmail) {
    if (doc[fnEmail] != currentEmail) return;

    _undNameCon.text = doc[fnName];
    _undDescCon.text = doc[fnDescription];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update/Delete Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  controller: _undNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: _undDescCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _undNameCon.clear();
                _undDescCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: () {
                if (_undNameCon.text.isNotEmpty &&
                    _undDescCon.text.isNotEmpty) {
                  updateDoc(doc.documentID, _undNameCon.text, _undDescCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                deleteDoc(doc.documentID);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }

  Widget allPostList(String email) {
    return Expanded(
      child: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(colName)
              .orderBy(fnDatetime, descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading...");
              default:
                return ListView(
                  children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    Timestamp ts = document[fnDatetime];
                    String dt = timestampToStrDateTime(ts);
                    String _profileImageURL = document[fnImageUrl];
                    String postCategory = document[fnCategory];

                    return Card(
                      elevation: 2,
                      child: InkWell(
                        // Read Document
                        onTap: () {
                          showDocument(document.documentID);
                        },
                        // Update or Delete Document
                        onLongPress: () {
                          showUpdateOrDeleteDocDialog(document, email);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // 사진
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green[200],
                                  ),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width /
                                      10 *
                                      3,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width /
                                      10 *
                                      3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      _profileImageURL,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 20 * 11,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 게시물 제목
                                    Text(
                                      document[fnName],
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // 게시물 가격
                                    Text(
                                      document[fnPrice] + '원',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12),
                                    ),
                                    // 게시물 내용 (3줄까지만)
                                    Text(
                                      document[fnDescription],
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ); //Card
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  } //postList

  Widget myPostList(String email, DocumentSnapshot userDoc) {
    int tempInt = 0;
    return Expanded(
      child: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(colName)
              .orderBy(fnDatetime, descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading...");
              default:
                return ListView(

                  children: snapshot.data.documents.map((
                      DocumentSnapshot document) {
                    Timestamp ts = document[fnDatetime];
                    String dt = timestampToStrDateTime(ts);
                    String _profileImageURL = document[fnImageUrl];
                    String postCategory = document[fnCategory];

                    if (document[fnCategory] == "의류")
                      tempInt = 0;
                    else if (document[fnCategory] == "서적")
                      tempInt = 1;
                    else if (document[fnCategory] == "음식")
                      tempInt = 2;
                    else if (document[fnCategory] == "생필품")
                      tempInt = 3;
                    else if (document[fnCategory] == "가구전자제품")
                      tempInt = 4;
                    else if (document[fnCategory] == "뷰티잡화")
                      tempInt = 5;
                    else if (document[fnCategory] == "양도")
                      tempInt = 6;
                    else if (document[fnCategory] == "기타") tempInt = 7;

                    if (!categoryBool[tempInt]) {
                      return Container();
                    } else {
                      return Card(
                        elevation: 2,
                        child: InkWell(
                          // Read Document
                          onTap: () {
                            showDocument(document.documentID);
                          },
                          // Update or Delete Document
                          onLongPress: () {
                            showUpdateOrDeleteDocDialog(document, email);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // 사진
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width /
                                      10 *
                                      3,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width /
                                      10 *
                                      3,
                                  color: Colors.green[200],
                                  child: Image.network(
                                    _profileImageURL,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width /
                                      20 *
                                      11,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // 게시물 제목
                                      Text(
                                        document[fnName],
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // 게시물 가격
                                      Text(
                                        document[fnPrice] + '원',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                      // 게시물 내용 (3줄까지만)
                                      Text(
                                        document[fnDescription],
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ); //Card
                    } //else
                  }).toList(),
                );
            } //
          },
        ),
      ),
    );
  } //postList
}
