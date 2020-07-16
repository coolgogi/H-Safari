import 'package:flutter/material.dart';
import 'Alarm.dart';
import 'package:h_safari/yh/post.dart';

import 'package:h_safari/pangil/MySearch.dart';

import 'category/category1.dart';
import 'category/category2.dart';
import 'category/category3.dart';
import 'category/category4.dart';
import 'category/category5.dart';
import 'category/category6.dart';
import 'category/category7.dart';
import 'category/category8.dart';
import 'category/category9.dart';
import 'category/category10.dart';
import 'category/category11.dart';
import 'category/category12.dart';

import '../firebase/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {


  FirebaseProvider fp;

//from SH
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String colName = "FirstDemo";

  // 필드명
  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";

  TextEditingController _newNameCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();
  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
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
      appBar: AppBar(
        title: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('찾고싶은 상품을 입력하세요', style: TextStyle(fontSize: 13)),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => mysearch()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => mysearch()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Alarm()));
            },
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.text,
              icon: Icon(
                choice.icon,
              ),
              // 이전 코드와 다른 부분
            );
          }).toList(),

        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'CATEGORY',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '여성 의류',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category1()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '남성 의류',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category2()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '패션 잡화',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category3()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '뷰티/미용',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category4()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '스포츠/레저',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category5()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '디지털/가전',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category6()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '도서/티켓',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category7()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '생활/식품',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category8()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '문구/가구',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category9()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '한동나눔',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category10()));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '양도구해요/해요',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category11()));
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '구인구직',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => category12()));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
//<<<<<<< HEAD
//      body:ListView(
//        children: <Widget>[
//
//        ],
//      ),
//      TabBarView(
//        // map과 toList 함수를 연결해서 화면 리스트 전달
//        children: choices.map((Choice choice) {
//          // 문자열과 아이콘을 모두 포함하는 위젯 객체 생성
//          // 이전 코드에서는 Text 위젯 하나만 사용했었다. 코드가 많아 클래스로 분리.
//          return SingleChildScrollView(
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                children: <Widget>[
//                  ListTile(
//                    leading: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg", width: 100,),
//                    title: Text(
//                      '5,000원',
//                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                    ),
//                    subtitle: Text('서적 팔아요~ 전부 5천원'),
//                    onTap: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
//                    },
//                  ),
//                  ListTile(
//                    leading: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg", width: 100,),
//                    title: Text(
//                      '5,000원',
//                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                    ),
//                    subtitle: Text('서적 팔아요~ 전부 5천원'),
//                    onTap: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
//                    },
//                  ),
//                  ListTile(
//                    leading: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg", width: 100,),
//                    title: Text(
//                      '5,000원',
//                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                    ),
//                    subtitle: Text('서적 팔아요~ 전부 5천원'),
//                    onTap: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
//                    },
//                  ),
//                  //from SH
//                  Container(
//                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                    child: RaisedButton(
//                      color: Colors.indigo[300],
//                      child: Text(
//                        "SIGN OUT",
//                        style: TextStyle(color: Colors.white),
//                      ),
//                      onPressed: () {
//                        fp.signOut();
//                      },
//                    ),
//                  ),
//                  ////////////////////////////////////////////////////////////////////
//                  ////////////////////////////////////////////////////////////////////
//
//                ],
//
//              ),
//            ),
//          );
//        }).toList(),
//      ),
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
//      Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//
//
//          ],
//        ),
//      ),

      body: TabBarView(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 500,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection(colName)
                          .orderBy(fnDatetime, descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text("Loading...");
                          default:
                            return ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                Timestamp ts = document[fnDatetime];
                                String dt = timestampToStrDateTime(ts);
                                return Card(
                                  elevation: 2,
                                  child: InkWell(
                                    // Read Document
                                    onTap: () {
                                      showDocument(document.documentID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Post()));
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
                                              Text(
                                                document[fnName],
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                dt.toString(),
                                                style:
                                                TextStyle(color: Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              document[fnDescription],
                                              style: TextStyle(color: Colors.black54),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post()));
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
  void createDoc(String name, String description) {
    Firestore.instance.collection(colName).add({
      fnName: name,
      fnDescription: description,
      fnDatetime: Timestamp.now(),
    });
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection(colName)
        .document(documentID)
        .get()
        .then((doc) {
//      showReadDocSnackBar(doc);
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
  // 문서 추가 (Create)
  void showCreateDocDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create New Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Name"),
                  controller: _newNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: _newDescCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _newNameCon.clear();
                _newDescCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Create"),
              onPressed: () {
                if (_newDescCon.text.isNotEmpty &&
                    _newNameCon.text.isNotEmpty) {
                  createDoc(_newNameCon.text, _newDescCon.text);
                }
                _newNameCon.clear();
                _newDescCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  // 문서 Read 시, SnackBar -> 대체 예정
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

  //
  void showReadPostPage(DocumentSnapshot doc) {
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
}

class Choice {
  Choice(
      this.text,
      this.icon,
      );

  final String text;
  final IconData icon;

// 매개변수를 전달할 때 {}가 있다면 매개변수 이름을 생략할 수 없다.
// Choice({this.title, this.icon});
}

final choices = [
  Choice('전체', Icons.account_balance),
  Choice('My선호', Icons.flight),

];

class ChoiceCard extends StatelessWidget {
  // 매개변수 주변에 {}가 있기 때문에 text와 icon이라는 매개변수 이름을 함께 사용해야 한다.
  const ChoiceCard({Key key, this.text, this.icon}) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // 아이콘과 텍스트 양쪽에서 사용하기 위해 별도 변수로 처리
    final TextStyle textStyle = Theme.of(context).textTheme.display3;
    return Card(
      child: Column(
        children: <Widget>[
          // 아이콘이 위쪽, 문자열이 아래쪽.
          Icon(icon, size: 128.0, color: textStyle.color),
          Text(text, style: textStyle),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      color: Colors.green,
      margin: EdgeInsets.all(12),
    );
  }
}