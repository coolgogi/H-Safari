// 기본 import
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/views/post/post.dart';
// widget import

class Search extends StatefulWidget {

  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";
  final String fnImageUrl = 'imageUrl';
  final String fnPrice = 'price';
  final String fnCategory = 'category';
  final String fnHow = 'how'; //거래유형
  final String fnEmail = 'email';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);

  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;

//  List<postItem> postList;

//  List<String> titles;
//  List<String> Descriptions;


  bool _IsSearching;
  String _searchText = "";

  _SearchState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
  }


  var _blankFocusnode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: buildBar(context),
      body: Container(
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
                return GestureDetector(
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          children:
//                          _IsSearching ? _buildSearchList() :
                          snapshot.data.documents.map((DocumentSnapshot document) {
                            String title = document[fnName];
                            String postDes = document[fnDescription];
                            Timestamp ts = document[fnDatetime];
                            String dt = timestampToStrDateTime(ts);
                            String _profileImageURL = document[fnImageUrl];
                            String postCategory = document[fnCategory];

                            if(!_IsSearching) return Container();
                            else if (!title.contains(_searchQuery.text))
                              return Container();
                            else {
                              return Card(
                                elevation: 2,
                                child: InkWell(
                                  // Read Document
                                  onTap: () {
                                    showDocument(document.documentID);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 사진
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.green[200],
                                            ),
                                            width: MediaQuery.of(context).size.width / 10 * 3,
                                            height: MediaQuery.of(context).size.width / 10 * 3,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.network(
                                                _profileImageURL,
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width / 20 * 11,
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
                                                    color: Colors.black54, fontSize: 12),
                                              ),
                                              // 게시물 내용 (3줄까지만)
                                              Text(
                                                document[fnDescription],
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );//Card
                            } //else
                          }).toList(),
                        ),
                        onTap: () {
//                          FocusScope.of(context).requestFocus(_blankFocusnode);

                        }
                      );
            }
          },
        ),
      )

    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {

    Firestore.instance
        .collection('post')
        .document(documentID)
        .get()
        .then((doc) {
      print("showReadPostPage");
      showReadPostPage(doc, documentID);
    });
  }

//  문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc, String documentID) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Post(doc, documentID)));
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Container(
            height: 35,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _searchQuery,
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(_blankFocusnode);
                        },
                      )
                  ),
                )
            )
        )
    );
  }
}

