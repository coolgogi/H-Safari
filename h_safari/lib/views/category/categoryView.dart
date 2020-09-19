import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/post.dart';

class CategoryView extends StatefulWidget {
  final String select;

  CategoryView({this.select});

  @override
  _CategoryViewState createState() => _CategoryViewState(select: select);
}

class _CategoryViewState extends State<CategoryView> {
  final String select;

  _CategoryViewState({this.select});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email;
  FirebaseProvider fp;
  var status = true;
  var _isSwitchedNum = true;
  var checkIndex = 1;

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
        // stream: FirebaseFirestore.instance
        stream: Firestore.instance
            .collection('post')
            .orderBy("datetime", descending: true)
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
                  String postCategory = document['category'];
                  bool close = document['close'];

                  if (!(postCategory == select))
                    return Container();
                  else {
                    return _isSwitchedNum == true
                        ? InkWell(
                            onTap: () {
                              showReadPostPage(document);
                            },
                            child: postTile(context, document))
                        : close == false && _isSwitchedNum == false
                            ? InkWell(
                                onTap: () {
                                  showReadPostPage(document);
                                },
                                child: postTile(context, document))
                            : Container();
                  }
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

  void showReadPostPage(DocumentSnapshot doc) {
    _scaffoldKey.currentState..hideCurrentSnackBar();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                email == doc['email'] ? Post(doc, true) : Post(doc, false)));
  }

  Widget appBarSelect(BuildContext context, String title) {
    return AppBar(
      brightness: Brightness.light,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 28,
              width: 60,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.black12)),
                  color: checkIndex == 1
                      ? Colors.green[400]
                      : checkIndex == -1
                          ? Colors.grey[250]
                          : null,
                  child: Text(
                    checkIndex == 1
                        ? '마감 On'
                        : checkIndex == -1
                            ? '마감 Off'
                            : null,
                    style: TextStyle(
                      fontSize: 11,
                      color: checkIndex == 1
                          ? Colors.white
                          : checkIndex == -1
                              ? Colors.black87
                              : null,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      checkIndex = checkIndex * -1;
                      _isSwitchedNum = checkIndex == 1 ? true : false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
