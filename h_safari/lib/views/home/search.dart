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
  var _isSwitchedNum = true;
  var status = true;
  FirebaseProvider fp;
  String currentEmail;

  var checkIndex = 1;
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  final ScrollController listScrollController = ScrollController();

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

  scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
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
                        controller: listScrollController,
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
            SizedBox(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.only(right : 8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.black12)),
                  color : checkIndex == 1? Colors.green : checkIndex == -1? Colors.grey[250] : null,
                  child: Text(checkIndex == 1? '마감 On' : checkIndex == -1? '마감 Off': null,
                    style: TextStyle(fontSize : 14, color: checkIndex == 1? Colors.white : checkIndex == -1? Colors.black87 : null,),),
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
        )
      ],
    );
  }
}