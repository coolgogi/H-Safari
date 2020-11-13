import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/services/database.dart';
import 'alarm.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String email;

  Home(String tp) {
    email = tp;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<String> categoryString = [
    "의류",
    "서적",
    "음식",
    "생활용품",
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
  bool wantToSeeFinished = false;

  QuerySnapshot userInfoSnapshot;
  DocumentSnapshot userDoc;
  bool unreadNotification = false;

  @override
  void initState() {
    super.initState();

    Firestore.instance
        .collection("users")
        .document(widget.email)
        .get()
        .then((doc) {
      setCategoryData(doc);
      unreadNotification = doc['unreadNotification'];
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
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
                        unreadNotification
                            ? Icons.notifications_active
                            : Icons.notifications,
                        color:
                            unreadNotification ? Colors.orange : Colors.green,
                        size: 25,
                      ),
                      onPressed: () {
                        DatabaseMethods()
                            .updateUnreadNotification(widget.email, false);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Alarm()));
                        setState(() {
                          unreadNotification = false;
                        });
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
                      Tab(text: 'Lost & Found'),
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
                      allPostList(widget.email),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      myPostList(widget.email),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  setCategoryData(DocumentSnapshot doc) {
    for (int i = 0; i < 8; i++) {
      categoryBool[i] = doc[categoryString[i]];
    }
    wantToSeeFinished = doc["마감"];
    setState(() {});
  }

  void showReadPostPage(DocumentSnapshot doc) {
    _scaffoldKey.currentState..hideCurrentSnackBar();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget.email == doc['email']
                ? Post(doc, true)
                : Post(doc, false)));
  }

  Widget allPostList(String email) {
    return Expanded(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("post")
              .orderBy("datetime", descending: true)
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
                    bool close = document['close'];
                    return (close && !wantToSeeFinished)
                        ? Container()
                        : InkWell(
                            onTap: () {
                              showReadPostPage(document);
                            },
                            child: postTile(context, document),
                          );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget myPostList(String email) {
    int tempInt = 0;
    return Expanded(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("post")
              .orderBy("datetime", descending: true)
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
                    bool close = document['close'];

                    if (document['category'] == "의류")
                      tempInt = 0;
                    else if (document['category'] == "서적")
                      tempInt = 1;
                    else if (document['category'] == "음식")
                      tempInt = 2;
                    else if (document['category'] == "생활용품")
                      tempInt = 3;
                    else if (document['category'] == "가구전자제품")
                      tempInt = 4;
                    else if (document['category'] == "뷰티잡화")
                      tempInt = 5;
                    else if (document['category'] == "양도")
                      tempInt = 6;
                    else if (document['category'] == "기타") tempInt = 7;

                    if (!categoryBool[tempInt]) {
                      return Container();
                    } else if ((close == true) &&
                        (wantToSeeFinished == false)) {
                      return Container();
                    } else {
                      return InkWell(
                          onTap: () {
                            showReadPostPage(document);
                          },
                          child: postTile(context, document));
                    }
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
