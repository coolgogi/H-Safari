import 'dart:ui';

import 'package:flutter/material.dart';

import 'categoryView.dart';

class MyCategory extends StatefulWidget {
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  Widget appBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.green[100],
      leading: Icon(
        Icons.cake,
        color: Colors.green,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Center(
            child: Text(
              '$title',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('카테고리'),
      body: categoryBox(),
    );
  }
}

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
