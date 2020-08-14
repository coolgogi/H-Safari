import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/post/post(writer).dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/services/database.dart';
import 'alarm.dart';

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
  final String fnClose = 'close';

  final String checkClose = "마감";

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
  bool wantToSeeFinished = false; //마감된글 볼지말지

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
    wantToSeeFinished = doc[checkClose];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    userEmail = fp.getUser().email.toString();
//    bool _isSwitchedNum = true;

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          //appBar: MyAppBar(),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: true,
                  leading: null,
                  titleSpacing: 0,
                  title: AppBarTitle(context),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.green,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Alarm()));
                      },
                    ),
                    SizedBox(
                      width: 3,
                    ),
                  ],
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black38,
                    labelColor: Colors.green,
                    labelStyle: TextStyle(
                        fontSize: 15, height: 1, fontWeight: FontWeight.bold),
                    indicatorColor: Colors.green,
                    indicatorWeight: 2.5,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                    tabs: <Widget>[
                      Tab(text: '전체'),
                      Tab(text: 'My관심사'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      allPostList(userEmail),
                      //전체글
                    ], //widget
                  ), //column
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      myPostList(userEmail, userDoc), //마이 카테고리
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  } //build

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc) {
    _scaffoldKey.currentState..hideCurrentSnackBar();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                userEmail == doc['email'] ? MyPost(doc) : Post(doc)));
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
                    bool close = document[fnClose];

                    return (close && !wantToSeeFinished) ? Container()
                        :
                    InkWell(
                      // Read Document
                      onTap: () {
                         showReadPostPage(document);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // 사진
                                Container(
                                    width: MediaQuery.of(context).size.width /
                                        10 *
                                        3,
                                    height: MediaQuery.of(context).size.width /
                                        10 *
                                        3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: (_profileImageURL != "")
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            child: close
                                                ? Stack(children: <Widget>[
                                                    Container(
                                                      width: 250,
                                                      height: 250,
                                                      child: Image.network(
                                                        _profileImageURL,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                        width: 250,
                                                        height: 250,
                                                        child: Image.asset(
                                                            'assets/sample/close2.png'))
                                                  ])
                                                : Image.network(
                                                    _profileImageURL,
                                                    fit: BoxFit.fill,
                                                  ))
                                        : Stack(
                                            children: <Widget>[
                                              Image.asset(
                                                  'Logo/empty_Rabbit_green1_gloss.png.png'),
                                            ],
                                          )),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width /
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
                                          color: close
                                              ? Colors.grey
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // 게시물 가격
                                      Text(
                                        document[fnPrice] + '원',
                                        style: TextStyle(
                                            color: close
                                                ? Colors.grey
                                                : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // 게시물 내용 (3줄까지만)
                                      Text(
                                        document[fnDescription],
                                        style: TextStyle(
                                          color: close
                                              ? Colors.grey
                                              : Colors.black,
                                          fontSize: 12,
                                        ),
                                        maxLines: 3,
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
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    Timestamp ts = document[fnDatetime];
                    String dt = timestampToStrDateTime(ts);
                    String _profileImageURL = document[fnImageUrl];
                    String postCategory = document[fnCategory];
                    bool close = document[fnClose];

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
                    } else if ((close == true) &&
                        (wantToSeeFinished == false)) {
                      return Container();
                    } else {
                      return InkWell(
                        // Read Document
                        onTap: () {
                          showReadPostPage(document);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: <Widget>[
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  Container(
//                                      width: 70,
//                                      color: Colors.green,
//                                      child: Center(
//                                        child: Text(
//                                          close ? '마감' : '판매중',
//                                          style: TextStyle(
//                                              fontSize: 15
//                                          ),),
//                                      )
//                                  ),
//                                ],
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // 사진
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.green[100],
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          10 *
                                          3,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10 *
                                              3,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          child: close
                                              ? Stack(children: <Widget>[
                                                  Container(
                                                    width: 250,
                                                    height: 250,
                                                    child: Image.network(
                                                      _profileImageURL,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Container(
                                                      width: 250,
                                                      height: 250,
                                                      child: Image.asset(
                                                          'assets/sample/close2.png'))
                                                ])
                                              : Image.network(
                                                  _profileImageURL,
                                                  fit: BoxFit.fill,
                                                ))),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
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
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // 게시물 가격
                                        Text(
                                          document[fnPrice] + '원',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
                            ],
                          ),
                        ),
                      );
                    }
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  } //postList
}
