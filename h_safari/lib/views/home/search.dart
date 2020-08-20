import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:custom_switch/custom_switch.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _isSwitchedNum = true;
  var status = true;
  FirebaseProvider fp;
  String currentEmail;

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
<<<<<<< HEAD
  List<String> _list;

  final ScrollController listScrollController = ScrollController();

  bool wantToSeeFinished = true; //마감된글 볼지말지
=======
>>>>>>> 051e8729cff94927b32c3315f97e60806b8c0fd0

  bool wantToSeeFinished = true;


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
    listScrollController.addListener(scrollListener);
    _IsSearching = false;
  }

  var _blankFocusnode = new FocusNode();
  String priceComma;

  scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GestureDetector(
      onPanUpdate: (details) {
        if(details.delta.dy < 0) FocusScope.of(context).requestFocus(_blankFocusnode);
        else if(details.delta.dy > 0) FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: Scaffold(
          key: key,
          appBar: buildBar(context),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('post')
                  .orderBy(fnDatetime, descending: true)
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    return ListView(
                      controller: listScrollController,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      children:
//                          _IsSearching ? _buildSearchList() :
                      snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        String title = document[fnName];
                        String postDes = document[fnDescription];
                        Timestamp ts = document[fnDatetime];
                        String dt = timestampToStrDateTime(ts);
                        String _profileImageURL = document[fnImageUrl];
                        String postCategory = document[fnCategory];
                        bool close = document[fnClose];
                        priceComma = document[fnPrice].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');

                        if (!_IsSearching)
                          return Container();
                        else if (!title.contains(_searchQuery.text))
                          return Container();
                        else {
                          return _isSwitchedNum == true ?
                          InkWell(
                            // Read Document
                            onTap: () {
                              showReadPostPage(document);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                      BorderSide(color: Colors.black12))),
                              padding:
                              const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // 사진
                                  listPhoto(context, document),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        20 *
                                        11,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 게시물 제목
                                        Text(
                                          document[fnName],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // 게시물 가격
                                        Text(
                                          '$priceComma원',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
                          )
                              : close == false && _isSwitchedNum == false ?
                          InkWell(
                            // Read Document
                            onTap: () {
                              showReadPostPage(document);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                      BorderSide(color: Colors.black12))),
                              padding:
                              const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // 사진
                                  listPhoto(context, document),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        20 *
                                        11,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 게시물 제목
                                        Text(
                                          document[fnName],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // 게시물 가격
                                        Text(
                                          document[fnPrice] + '원',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
                          )
                              : Container();
                        }
                      }).toList(),
                    );
                }
              },
            ),
          )),
    );
=======
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('post')
                .orderBy("datetime", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text("Loading...");
                default:
                  return GestureDetector(
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        children:
                        snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          String title = document["name"];
                          bool close = document['close'];
                          priceComma = document['price'].replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (match) => '${match[1]},');
                          if (!_IsSearching)
                            return Container();
                          else if (!title.contains(_searchQuery.text))
                            return Container();
                          else {
                            return _isSwitchedNum == true
                                ? InkWell(
                                    onTap: () {
                                      showReadPostPage(document);
                                    },
                                    child: postTile(context, document),
                                  )
                                : close == false && _isSwitchedNum == false
                                    ? InkWell(
                                        onTap: () {
                                          showReadPostPage(document);
                                        },
                                        child: postTile(context, document),
                                      )
                                    : Container();
                          }
                        }).toList(),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(_blankFocusnode);
                      });
              }
            },
          ),
        ));
>>>>>>> 051e8729cff94927b32c3315f97e60806b8c0fd0
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }

  void showReadPostPage(DocumentSnapshot doc) {
    fp = Provider.of<FirebaseProvider>(context);
    currentEmail = fp.getUser().email.toString();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => currentEmail == doc['email']
                ? Post(doc, true)
                : Post(doc, false)));
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
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
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: TextFormField(
            controller: _searchQuery,
            autofocus: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              border: InputBorder.none,
              hintText: "게시글을 검색해보세요!",
              hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.black45,
                ),
                onPressed: () {
                  _searchQuery.clear();
                },
              ),
            ),
          )),
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
            Text('마감', style : TextStyle(fontSize: 14, color : Colors.black38)),
          ],
        )
      ],
    );
  }
}