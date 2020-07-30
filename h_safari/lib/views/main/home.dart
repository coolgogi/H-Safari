import 'package:flutter/material.dart';
import 'alarm.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/views/main/search.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:meta/meta.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {

  FirebaseProvider fp;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // 컬렉션명
  final String colName = "post";

  // 필드명
  File _image;
  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";
  final String fnImageUrl = 'imageUrl';
  final String fnPrice = 'price';
  final String fnCategory = 'category';
  final String fnHow = 'how'; //거래유형

  TextEditingController _newNameCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();
  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();

  int _counter = 0;

  @override
  bool get wantKeepAlive => true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    String userEmail = fp.getUser().email.toString();

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: MyAppBar(),
      body: TabBarView(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  //https://pub.dev/packages/carousel_slider 이 사이트로 배너 넣는 방법도 있음
//                    postList(userEmail),//전체글
                    postList(),
                ],//widget
              ),//column
            ),//padding
          ),//SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
//                  postList(userEmail),//마이 카테고리
                  postList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection(colName)
        .document(documentID)
        .get()
        .then((doc) {
      showReadPostPage(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateDoc(String docID, String name, String description) {
    Firestore.instance.collection(colName).document(docID).updateData({
      fnName: name,
      fnDescription: description,
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance.collection(colName).document(docID).delete();
  }

  //문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc) {
    _scaffoldKey.currentState..hideCurrentSnackBar();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post(doc)));
  }

  //dialog
  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
    _undNameCon.text = doc[fnName];
    _undDescCon.text = doc[fnDescription];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update/Delete Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  controller: _undNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: _undDescCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _undNameCon.clear();
                _undDescCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: () {
                if (_undNameCon.text.isNotEmpty &&
                    _undDescCon.text.isNotEmpty) {
                  updateDoc(doc.documentID, _undNameCon.text, _undDescCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                deleteDoc(doc.documentID);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }


//  Widget postList(String email, String msg){
  Widget postList(){
    return Container(
      height: 500,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(colName)
            .orderBy(fnDatetime, descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return Text("Error: ${snapshot.error}");
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text("Loading...");
            default:
              return ListView(
                children: snapshot.data.documents
                    .map((DocumentSnapshot document) {
                  Timestamp ts = document[fnDatetime];
                  String dt = timestampToStrDateTime(ts);
                  String _profileImageURL = document[fnImageUrl];
                  String postCategory = document[fnCategory];
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      // Read Document
                      onTap: () {
                        showDocument(document.documentID);
                      },
                      // Update or Delete Document
                      onLongPress: () {
//                        if(document[fnName] == email)
                        showUpdateOrDeleteDocDialog(document);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // 사진
                            Container(
                              width: MediaQuery.of(context).size.width/10 *3,
                              height: MediaQuery.of(context).size.width/10 *3,
                              color: Colors.green[200],
                              child: Image.network(_profileImageURL, fit: BoxFit.fill,),

                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/20 *11,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // 게시물 제목
                                  Text(
                                    document[fnName],
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // 게시물 가격
                                  Text(
                                    document[fnPrice] + '원',
                                    style: TextStyle(
                                        color: Colors.black54,
                                    fontSize: 12),
                                  ),
                                  // 게시물 내용 (3줄까지만)
                                  Text(
                                    document[fnDescription],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,),
                                      maxLines: 3,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }//postList
}


//
class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // AppBar 배경색
      backgroundColor: Colors.white,

      // AppBar의 leading (로고)
      leading: AppBarIcon(),

      // AppBar의 title (검색창)
      title: AppBarTitle(),

      // AppBar의 action (알람)
      actions: <Widget>[AppBarIcon2(),],

      // AppBar의 TabBar
      bottom: TabBar(

        // 선택되지 않은 탭바의 글자색
        unselectedLabelColor: Colors.black45,

        // 선택된 탭바의 글자색과 스타일
        labelColor: Colors.green,
        labelStyle: TextStyle(fontSize: 15, height: 1, fontWeight: FontWeight.bold),

        // 선택된 indicator의 색
        indicatorColor: Colors.green,

        // 탭바 위젯
        tabs: <Widget>[
          Tab(text: '전체'),
          Tab(text: 'My관심사'),
        ],
      ),
    );
  }
}


class AppBarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.cake,
      color: Colors.green,
    );
  }
}

class AppBarIcon2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        IconButton(
          icon: Icon(
            Icons.add_alert,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Alarm()));
          },
        ),
      ],
    );
  }
}



class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        InkWell(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color : Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                        'Search your word',
                        style: TextStyle(
                            color : Colors.white,
                            fontSize: 15),),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  IconButton(
                    icon : Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                    },
                  ),
                ],
              ),
            ),
          onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
          },
        ),
      ],
    );
  }
}



