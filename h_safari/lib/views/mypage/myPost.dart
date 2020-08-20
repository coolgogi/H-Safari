import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/views/post/post.dart';

class MyPost extends StatefulWidget {
  String userEmail;

  MyPost(String tp) {
    userEmail = tp;
  }

  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  allMyClosedPostList(widget.userEmail),
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
                    bool close = document["close"];

                    if (close) {
                      return Container();
                    } else if (document["email"] == widget.userEmail) {
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

  Widget allMyClosedPostList(String email) {
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
                    bool close = document["close"];

                    if (!close) {
                      return Container();
                    } else if (document["email"] == widget.userEmail) {
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
        context, MaterialPageRoute(builder: (context) => Post(doc, true)));
  }
}
