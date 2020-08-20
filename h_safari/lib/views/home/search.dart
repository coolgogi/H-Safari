import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/helpers/firebase_provider.dart';
import 'package:h_safari/views/post/post.dart';
import 'package:h_safari/widget/widget.dart';
import 'package:provider/provider.dart';

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
  final String fnClose = 'close';
  var _isSwitchedNum = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FirebaseProvider fp;
  String currentEmail;

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;

  bool wantToSeeFinished = true; //마감된글 볼지말지

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
  String priceComma;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return GestureDetector(
                      child: ListView(
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
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(_blankFocusnode);
                      });
              }
            },
          ),
        ));
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }

//  문서 읽기 (Read)
  void showReadPostPage(DocumentSnapshot doc) {
    fp = Provider.of<FirebaseProvider>(context);
    currentEmail = fp.getUser().email.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => currentEmail == doc['email'] ? Post(doc, true) : Post(doc, false)));
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