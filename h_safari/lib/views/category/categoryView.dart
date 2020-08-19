// 기본 import
import 'package:flutter/material.dart';

// widget import
import 'package:h_safari/widget/widget.dart';

//
import 'package:h_safari/models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/post.dart';
import 'dart:io';

class categoryView extends StatefulWidget {
  final String select;

  categoryView({this.select});

  @override
  _categoryViewState createState() => _categoryViewState(select: select);
}

class _categoryViewState extends State<categoryView> {
  final String select;

  _categoryViewState({this.select});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email;
  FirebaseProvider fp;

  File _image;
  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";
  final String fnImageUrl = 'imageUrl';
  final String fnPrice = 'price';
  final String fnCategory = 'category';
  final String fnHow = 'how'; //거래유형
  final String fnEmail = 'email';

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    email = fp.getUser().email.toString();

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarSelect(context, select),
      body: categoryPostList(email, select),
    );
  }

  Widget categoryPostList(String email, String select) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('post')
            .orderBy(fnDatetime, descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
//                  postCategory.replaceAll("/", "");

                  if (!(postCategory == select))
                    return Container();
                  else {
                    return InkWell(
                      // Read Document
                      onTap: () {
                        showReadPostPage(document);
                      },
                      child: postTile(context, document)
                    );
                  } //Card
                }).toList(),
              );
          }
        },
      ),
    );
  } //postList

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc) {
    _scaffoldKey.currentState..hideCurrentSnackBar();
    Navigator.push(context, MaterialPageRoute(builder: (context) => email == doc['email'] ? Post(doc, true) : Post(doc, false)));
  }
}
