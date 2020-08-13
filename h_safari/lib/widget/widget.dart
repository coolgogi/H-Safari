import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';

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
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          )),
    ),
  );
}

// AppBar의 title (검색창)
Widget AppBarTitle (BuildContext context) {
    return  Row(
      children: <Widget>[
        Container(
          width: 70,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,6,0,0),
            child: Image.asset('Logo/h-safari_homeicon.png.png'),
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: InkWell(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color : Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      '게시글을 검색해보세요!',
                      style: TextStyle(
                          color : Colors.black54,
                          fontSize: 13),),
                  ),
                  IconButton(
                    icon : Icon(Icons.search, color: Colors.black38),
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
        ),
      ],
    );
  }