import 'package:flutter/material.dart';
import 'package:h_safari/views/home/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 뒤로가기 기능이 있는 page들을 위한 appBar 생성
Widget appBar(BuildContext context, String title) {
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
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

// 뒤로가기 기능이 없고 로고가 들어갈 page들을 위한 appBar 생성
Widget appBarMain(String title) {
  return AppBar(
    brightness: Brightness.light,
    elevation: 0.0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

// select되어 화면을 가져오는 페이지들을 위한 appBar 생성
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
      padding: const EdgeInsets.only(right: 40.0),
      child: Center(
          child: Text(
        '$title',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      )),
    ),
  );
}

// AppBar의 title (검색창)
Widget AppBarTitle(BuildContext context) {
  return Row(
    children: <Widget>[
      Container(
        width: 70,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
          child: Image.asset('Logo/h-safari_homeicon.png.png'),
        ),
      ),
      SizedBox(
        width: 8,
      ),
      Expanded(
        child: InkWell(
          child: Container(
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    '게시글을 검색해보세요!',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black38),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  },
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Search()));
          },
        ),
      ),
    ],
  );
}

// 뒤로가기 기능이 있는 page들을 위한 appBar 생성
Widget myPostAppBar(
    BuildContext context, String title, String title1, String title2) {
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
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    bottom: TabBar(
      unselectedLabelColor: Colors.black38,
      labelColor: Colors.green,
      labelStyle:
          TextStyle(fontSize: 15, height: 1, fontWeight: FontWeight.bold),
      indicatorColor: Colors.green,
      indicatorWeight: 2.5,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
      tabs: <Widget>[
        Tab(text: '$title1'),
        Tab(text: '$title2'),
      ],
    ),
  );
}

String priceComma;

// home, search 의 게시글 UI
Widget postTile(BuildContext context, DocumentSnapshot document) {
  bool close = document['close'];
  priceComma = document['price'].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
  return Container(
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12))),
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            listPhoto(context, document),
            SizedBox(
              width: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 20 * 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    document["name"],
                    style: TextStyle(
                      color: close ? Colors.grey : Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$priceComma원',
                    style: TextStyle(
                        color: close ? Colors.grey : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    document["description"],
                    style: TextStyle(
                      color: close ? Colors.grey : Colors.black,
                      fontSize: 11,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// home, search 다트에서 보여지는 게시물의 UI 사진
Widget listPhoto(BuildContext context, DocumentSnapshot document) {
  String fnImageUrl = 'imageUrl';
  String fnClose = 'close';
  String _profileImageURL = document[fnImageUrl];
  return Container(
      width: MediaQuery.of(context).size.width / 10 * 2.5,
      height: MediaQuery.of(context).size.width / 10 * 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: (_profileImageURL != "")
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: document[fnClose]
                  ? Stack(children: <Widget>[
                      Container(
                        width: 250,
                        height: 250,
                        child: Image.network(
                          _profileImageURL,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/sample/close2.png'))
                    ])
                  : Image.network(
                      _profileImageURL,
                      fit: BoxFit.fill,
                    ))
          : ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: document[fnClose]
                  ? Stack(children: <Widget>[
                      Container(
                        width: 250,
                        height: 250,
                        child: Image.asset(
                            'Logo/empty_Rabbit_green1_gloss.png.png'),
                      ),
                      Container(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/sample/close2.png'))
                    ])
                  : Image.asset('Logo/empty_Rabbit_green1_gloss.png.png')));
}
