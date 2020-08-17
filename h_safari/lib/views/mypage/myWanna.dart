import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/views/post/post.dart';

class myWanna extends StatefulWidget {


  String userEmail;
  myWanna(String tp){
    userEmail = tp;
  }

  @override
  _myWannaState createState() => _myWannaState(userEmail);
}

class _myWannaState extends State<myWanna> {

  String userEmail;
  DocumentSnapshot userDoc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String colName = "post";
  String fnClose = "close";
  String fnEmail = "email";
  String fnWaitingList = "waitingUserList";

  _myWannaState(String email){
    userEmail = email;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myPostAppBar(context, '거래신청한 게시글', '판매중', '마감'),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  allMyFavoriteList(userEmail),
                  //전체글
                ], //widget
              ), //column
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  allMyClosedFavoriteList(userEmail), //마이 카테고리
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allMyFavoriteList(String email) {
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
                    bool close = document[fnClose];

                    if(close){
                      return Container();
                    }else if(document[fnWaitingList].contains(userEmail)){
                      return InkWell(
                        // Read Document
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

  Widget allMyClosedFavoriteList(String email) {
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
                    bool close = document[fnClose];

                    if (!close) {
                      return Container();
                    }else if(document[fnWaitingList].contains(userEmail)){
                      return InkWell(
                        // Read Document
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

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Post(doc, false)));
//            userEmail == doc['email'] ? Post(doc, true) : Post(doc, false)));
  }
}
