import 'package:flutter/material.dart';
import 'package:h_safari/views/category/categoryView.dart';
import 'package:h_safari/views/main/search.dart';
import 'package:h_safari/views/main/alarm.dart';

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
Widget appBarMain(BuildContext context, String title) {
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

Widget appBarSearch(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.green,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: SearchBar(),


  );
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 35,
      decoration: BoxDecoration(
          color : Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search your world',
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {

                },
              )),
        ),
      ),
    );
  }
}


// 카테고리 항목별 이름
final List<String> _category = [
  '의류',
  '서적',
  '음식',
  '생필품',
  '가구/전자제품',
  '뷰티/잡화',
  '양도',
  '기타'
];

// 카테고리 항목별 들어갈 이미지
final List<Widget> _categoryImage = [
  Image.asset('assets/sample/clothes.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/book.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/food.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/life.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/furniture.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/beauty.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/home.jpg', fit: BoxFit.fill,),
  Image.asset('assets/sample/etc.jpg', fit: BoxFit.fill,),
];


// 카테고리 항목 UI
class categoryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (1.7),
        children: List.generate(8, (index) {
          return Center(
              child: Container(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        child: _categoryImage[index],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(

                                  builder: (context) => categoryView(select : _category[index])));
                        }
                    )
                  ],
                ),
              ));
        }),
      ),
    );
  }
}

// 알림 UI
class alertTile extends StatelessWidget {
  final String type;
  final String sendBy;
  final String time;
  final String postName;

  alertTile({this.type, this.sendBy, this.time, this.postName});
  Color color = Colors.green[300]; // 기본 배경색

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: FlatButton(
            color: color, // 기본 배경색 : color
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.person, // 아이콘 종류
                      color: Colors.white, // 아이콘 색
                    ),// 아이콘
                    SizedBox(
                      width: 10,
                    ),// 아이콘과 글자들 사이의 박스 삽입

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 글자들을 왼쪽 정렬
                      children: <Widget>[
                        Text(
                          '$postName', // 게시물 제목
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), // 게시물 제목 스타일 지정
                        ),
                        Text(
                          '$type', // 알람 내용
                          style: TextStyle(fontSize: 10, color: Colors.black45), // 알림 내용 스타일 지정
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '$time', // 시간
                  style: TextStyle(fontSize: 10, color: Colors.black45), // 시간 스타일 지정
                )
              ],
            ),
            onPressed: () { // 클릭 시 변화림
//                Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                  ())); // 알림을 누를 시 알람이 가르키는 페이지로 이동
//                color = Colors.white; // 알림을 누를 시 읽음 표시를 위한 배경색 변화

            }
        ),
      ),
    );
  }
}

// home.dart의 appBar UI
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

// AppBar의 leading (로고)
class AppBarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.cake,
      color: Colors.green,
    );
  }
}
// AppBar의 action (알람)
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

// AppBar의 title (검색창)
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

