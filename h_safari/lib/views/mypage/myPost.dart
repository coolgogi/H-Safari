import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/views/post/post.dart';


class myPost extends StatefulWidget {

  String userEmail;

  myPost(String tp){
    userEmail = tp;
  }
  @override
  _myPostState createState() => _myPostState();
}

class _myPostState extends State<myPost> {

//  String userEmail;
//  DocumentSnapshot userDoc;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  String colName = "post";
//  String fnClose = "close";
//  String fnEmail = "email";

//  _myPostState(String email){
//    userEmail = email;
//  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myPostAppBar(context, '내가 쓴 게시글', '판매중', '마감'),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  allMyPostList(widget.userEmail),
                  //전체글
                ], //widget
              ), //column
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  allMyClosedPostList(widget.userEmail), //마이 카테고리
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allMyPostList(String email) {
    return Expanded(
      child: Container(
//        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("post")
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
                    bool close = document["close"];

                    if(close){
                      return Container();
                    }else if(document["email"] == widget.userEmail){
                      return InkWell(
                        onTap: () {
                          showReadPostPage(document);
                        },
                        child: postTile(context, document),
                      );
                    }else{
                      return Container();
                    }
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  } //postList

  Widget allMyClosedPostList(String email) {
//    int tempInt = 0;
    return Expanded(
      child: Container(
//        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("post")
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
                    bool close = document["close"];

                    if (!close) {
                      return Container();
                    } else if(document["email"] == widget.userEmail) {
                      return InkWell(
                          onTap: () {
                            showReadPostPage(document);
                          },
                          child: postTile(context, document)
                      );
                    } else{
                      return Container();
                    }
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  void showReadPostPage(DocumentSnapshot doc) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Post(doc, true)));
  }
}

