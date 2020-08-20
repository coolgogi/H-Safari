import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:custom_switch/custom_switch.dart';

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
            Transform.scale(
              scale: 0.65,
              child: CustomSwitch(
                activeColor: Colors.green,
                value: status,
                onChanged: (value) {
                  setState(() {
                    status = value;
                    _isSwitchedNum = value;
                  });
                },
              ),
            ),
            Text('마감', style: TextStyle(fontSize: 14, color: Colors.black38)),
          ],
        ),
      ],
    );
  }
}
