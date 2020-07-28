import 'package:flutter/material.dart';
import 'alarm.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/views/main/search.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  FirebaseProvider fp;

//from SH
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
                  Container(
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
                                return Card(
                                  elevation: 2,
                                  child: InkWell(
                                    // Read Document
                                    onTap: () {
                                      showDocument(document.documentID);
                                    },
                                    // Update or Delete Document
                                    onLongPress: () {
                                      showUpdateOrDeleteDocDialog(document);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    _profileImageURL),
                                                radius: 35,
                                              ),
                                              Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    document[fnName],
                                                    //dt.toString(),
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    document[fnPrice] + '원',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                    fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                  )
                  //from SH
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",
                      width: 100,
                    ),
                    title: Text(
                      '5,000원',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => Post())
//                      );
                    },
                  ),
                  //from SH
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
//      showReadDocSnackBar(doc);
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

  // 문서 Read 시, SnackBar -> 사용 x
  void showReadDocSnackBar(DocumentSnapshot doc) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepOrangeAccent,
          duration: Duration(seconds: 5),
          content: Text(
              "$fnName: ${doc[fnName]}\n$fnDescription: ${doc[fnDescription]}"
              "\n$fnDatetime: ${timestampToStrDateTime(doc[fnDatetime])}"),
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  }

  //사용중
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
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      // Read Document
                      onTap: () {
                        showDocument(document.documentID);
                      },
                      // Update or Delete Document
                      onLongPress: () {
//                        if(document[fnName] == )
                        showUpdateOrDeleteDocDialog(document);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      _profileImageURL),
                                  radius: 40,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.grey[600]),
                                ),
                                Text(
                                  document[fnName],
                                  //dt.toString(),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                document[fnDescription],
                                style: TextStyle(
                                    color: Colors.black54),
                              ),
                            )
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
  }
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



