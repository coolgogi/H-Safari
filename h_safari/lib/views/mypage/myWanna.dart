import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/views/post/post.dart';

// ignore: must_be_immutable
class MyWanna extends StatefulWidget {
  String userEmail;

  MyWanna(String tp) {
    userEmail = tp;
  }

  @override
  _MyWannaState createState() => _MyWannaState();
}

class _MyWannaState extends State<MyWanna> {
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
                  allMyFavoriteList(widget.userEmail),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  allMyClosedFavoriteList(widget.userEmail),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
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
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    bool close = document.get("close");

                    if (close) {
                      return Container();
                    } else if (document
                        .get("waitingUserList")
                        .contains(widget.userEmail)) {
                      return InkWell(
                        onTap: () {
                          showReadPostPage(document);
                        },
                        child: postTile(context, document),
                      );
                    } else {
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

  Widget allMyClosedFavoriteList(String email) {
    return Expanded(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
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
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    bool close = document.get("close");

                    if (!close) {
                      return Container();
                    } else if (document
                        .get("waitingUserList")
                        .contains(widget.userEmail)) {
                      return InkWell(
                          onTap: () {
                            showReadPostPage(document);
                          },
                          child: postTile(context, document));
                    } else {
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
        context, MaterialPageRoute(builder: (context) => Post(doc, false)));
  }
}
