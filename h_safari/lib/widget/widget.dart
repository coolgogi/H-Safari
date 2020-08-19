import 'package:flutter/material.dart';
import 'package:h_safari/views/home/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 뒤로가기 기능이 있는 page들을 위한 appBar 생성
Widget appBar(BuildContext context, String title) {
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

final String fnName = "name";
final String fnDescription = "description";
final String fnDatetime = "datetime";
final String fnImageUrl = 'imageUrl';
final String fnPrice = 'price';
final String fnCategory = 'category';
final String fnHow = 'how'; //거래유형
final String fnEmail = 'email';
final String fnClose = 'close';
final String checkClose = "마감";

// home, search 의 게시글 UI
Widget postTile(BuildContext context, DocumentSnapshot document) {
  bool close = document[fnClose];
  return Container(
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12))),
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 사진
            listPhoto(context, document),
            SizedBox(
              width: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 20 * 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 게시물 제목
                  Text(
                    document[fnName],
                    style: TextStyle(
                      color: close ? Colors.grey : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // 게시물 가격
                  Text(
                    document[fnPrice] + '원',
                    style: TextStyle(
                        color: close ? Colors.grey : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  // 게시물 내용 (3줄까지만)
                  Text(
                    document[fnDescription],
                    style: TextStyle(
                      color: close ? Colors.grey : Colors.black,
                      fontSize: 12,
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
      width: MediaQuery.of(context).size.width / 10 * 3,
      height: MediaQuery.of(context).size.width / 10 * 3,
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
                          child: Image.asset('Logo/empty_Rabbit_green1_gloss.png.png'),
                        ),
                        Container(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/sample/close2.png')
                        )
                      ])
                    : Image.asset(
                    'Logo/empty_Rabbit_green1_gloss.png.png'
                    ))
  );
}
