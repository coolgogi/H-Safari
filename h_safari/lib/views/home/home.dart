import 'package:extended_list/extended_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/services/database.dart';
import 'alarm.dart';
import 'package:loadmore/loadmore.dart';

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
    false,
    false,
    false,
  ];
  bool wantToSeeFinished = false;

  QuerySnapshot userInfoSnapshot;
  QuerySnapshot snapshotOfDocs;
  DocumentSnapshot userDoc;
  bool unreadNotification = false;
  int count = 0;
  int num = 15;
  int max = 16;
  List<int> list = [];
  int numOfIndex = 0;

  @override
  void initState() {
    super.initState();

    load();
    ReadDocs();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .get()
        .then((doc) {
      setCategoryData(doc);
      unreadNotification = doc['unreadNotification'];
    });
  }

  // ignore: non_constant_identifier_names
  void ReadDocs() async {
    snapshotOfDocs = await FirebaseFirestore.instance
        .collection("post")
        .orderBy("datetime", descending: true)
        .get();

    max = snapshotOfDocs.size;
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
                    onTap: refresh,
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
                      loadMoreList(snapshotOfDocs),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      LostNFound(snapshotOfDocs),
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
    // ignore: deprecated_member_use
    _scaffoldKey.currentState..hideCurrentSnackBar();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget.email == doc['email']
                ? Post(doc, true)
                : Post(doc, false)));
  }

  void load() {
    print("load");
    setState(() {
      List<int> start = List.generate(num, (v) => v);
      List<int> end;
      end = start.sublist(num - 15, num);
      if (num >= max) {
        end = start.sublist(num - 15, max - 1);
      } else {
        num += 15;
      }
      list.addAll(end);
      count = list.length;
      print("data count = ${list.length}");
      print("count = {$count}");
    });
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    list.clear();
    num = 15;
    load();
  }

  void refresh(int a) {
    _refresh();
  }

  Widget loadMoreList(QuerySnapshot snapshotOfDocs) {
    try {
      return Expanded(
          child: Container(
              child: RefreshIndicator(
        child: LoadMore(
          isFinish: count >= snapshotOfDocs.size - 1,
          onLoadMore: _loadMore,
          child: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) =>
                (snapshotOfDocs.docs[index]['close'] && !wantToSeeFinished)
                    ? Container()
                    : InkWell(
                        onTap: () {
                          showReadPostPage(snapshotOfDocs.docs[index]);
                        },
                        child: postTile(context, snapshotOfDocs.docs[index]),
                      ),
          ),
          whenEmptyLoad: false,
          delegate: DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
        ),
        onRefresh: _refresh,
      )));
    } catch (e) {
      return Container(child: Text("Loading..."));
    }
  }

  Widget LostNFound(QuerySnapshot snapshotOfDocs) {
    try {
      return Expanded(
          child: Container(
              child: RefreshIndicator(
        child: LoadMore(
          isFinish: count >= snapshotOfDocs.size - 1,
          onLoadMore: _loadMore,
          child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) =>
                  // (!snapshotOfDocs.docs[index]['close'] && wantToSeeFinished) &&
                  (snapshotOfDocs.docs[index]['category'] == 'Lost' ||
                          snapshotOfDocs.docs[index]['category'] == 'Found')
                      ? InkWell(
                          onTap: () {
                            showReadPostPage(snapshotOfDocs.docs[index]);
                          },
                          child: postTile(context, snapshotOfDocs.docs[index]),
                        )
                      : Container()),
          whenEmptyLoad: false,
          delegate: DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
        ),
        onRefresh: _refresh,
      )));
    } catch (e) {
      return Container(child: Text("Loading..."));
    }
  }
}
