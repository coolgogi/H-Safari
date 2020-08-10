import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';

// 뒤로가기 기능이 있는 page들을 위한 appBar 생성
Widget appBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.green[100],
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
      style: TextStyle(color: Colors.black),
    ),
  );
}

// 뒤로가기 기능이 없고 로고가 들어갈 page들을 위한 appBar 생성
Widget appBarMain(String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.green[100],
    leading: Icon(
      Icons.cake,
      color: Colors.green,
    ),
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.black),
    ),
  );
}

// select되어 화면을 가져오는 페이지들을 위한 appBar 생성
Widget appBarSelect(BuildContext context, String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.green[100],
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
            style: TextStyle(color: Colors.black),
          )),
    ),
  );
}

// AppBar의 title (검색창)
Widget AppBarTitle (BuildContext context) {
    return  Row(
      children: <Widget>[
        InkWell(
          child: Container(
            width: 270,
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
                  width: 90,
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



//안쓰임
//Widget appBarSearch(BuildContext context) {
//  return AppBar(
//    elevation: 0.0,
//    backgroundColor: Colors.white,
//    leading: IconButton(
//      icon: Icon(
//        Icons.arrow_back_ios,
//        color: Colors.green,
//      ),
//      onPressed: () {
//        Navigator.pop(context);
//      },
//    ),
//    title: SearchBar(),
//
//
//  );
//}
//
//class SearchBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return  Container(
//      height: 35,
//      decoration: BoxDecoration(
//          color : Colors.green,
//          borderRadius: BorderRadius.all(Radius.circular(15))
//      ),
//
//      child: Padding(
//        padding: const EdgeInsets.only(left: 10),
//        child: TextFormField(
//          autofocus: true,
//          style: TextStyle(color: Colors.white),
//          cursorColor: Colors.white,
//          decoration: InputDecoration(
//              border: InputBorder.none,
//              hintText: 'Search your world',
//              hintStyle: TextStyle(color: Colors.white),
//              suffixIcon: IconButton(
//                icon: Icon(Icons.search, color: Colors.white),
//                onPressed: () {
//
//                },
//              )),
//        ),
//      ),
//    );
//  }
//}

//안쓰임
//// home.dart의 appBar UI
//class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {
//  @override
//  Size get preferredSize => const Size.fromHeight(100);
//
//  @override
//  Widget build(BuildContext context) {
//    return AppBar(
//      // AppBar 배경색
//      backgroundColor: Colors.white,
//
//      // AppBar의 leading (로고)
//      leading: AppBarIcon(),
//
//      // AppBar의 title (검색창)
//      title: AppBarTitle(),
//
//      // AppBar의 action (알람)
//      actions: <Widget>[AppBarIcon2(),],
//
//      // AppBar의 TabBar
//      bottom: TabBar(
//
//        // 선택되지 않은 탭바의 글자색
//        unselectedLabelColor: Colors.black45,
//
//        // 선택된 탭바의 글자색과 스타일
//        labelColor: Colors.green,
//        labelStyle: TextStyle(fontSize: 15, height: 1, fontWeight: FontWeight.bold),
//
//        // 선택된 indicator의 색
//        indicatorColor: Colors.green,
//
//        // 탭바 위젯
//        tabs: <Widget>[
//          Tab(text: '전체'),
//          Tab(text: 'My관심사'),
//        ],
//      ),
//    );
//  }
//}

//얘네는 합침
//// AppBar의 leading (로고)
//class AppBarIcon extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Icon(
//      Icons.cake,
//      color: Colors.green,
//    );
//  }
//}
//// AppBar의 action (알람)
//class AppBarIcon2 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      children: <Widget>[
//
//        IconButton(
//          icon: Icon(
//            Icons.notifications,
//            color: Colors.green,
//          ),
//          onPressed: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => Alarm()));
//          },
//        ),
//      ],
//    );
//  }
//}



