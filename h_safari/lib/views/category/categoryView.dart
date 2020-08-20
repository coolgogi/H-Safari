// 기본 import
import 'package:flutter/material.dart';

// widget import
import 'package:h_safari/widget/widget.dart';

//
import 'package:h_safari/helpers/firebase_provider.dart';
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
  final String fnClose = 'close';
  var _isSwitchedNum = true;


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
                  bool close = document[fnClose];

                  if (!(postCategory == select))
                    return Container();
                  else {
                    return _isSwitchedNum == true ?
                    InkWell(
                      // Read Document
                        onTap: () {
                          showReadPostPage(document);
                        },
                        child: postTile(context, document)
                    )
                        :  close == false && _isSwitchedNum == false ?
                    InkWell(
                      // Read Document
                        onTap: () {
                          showReadPostPage(document);
                        },
                        child: postTile(context, document)
                    )
                        :Container();
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

  Widget appBarSelect(BuildContext context, String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.green,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            )),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top : 10, bottom: 10, right: 10),
          child: Switch(
            //value : _isSwitchedNum[num]의 기본값 저장 (true)
            value: _isSwitchedNum,

            // onChanged : 눌렀을 경우 value값을 가져와 _isSwitchedNum[num]에 지정하여 값을 변경
            onChanged: (value) {
              setState(() {
                _isSwitchedNum= value;


              });
              Firestore.instance.collection("users").document(fp.getUser().email).updateData({
                "마감" : _isSwitchedNum,
              });
            },

            // activeTrackColor : Switch 라인색
            activeTrackColor: Colors.lightGreenAccent[100],

            // activeColor : Switch 버튼색
            activeColor: Colors.green[400],
          ),
        )
      ],

    );
  }
}