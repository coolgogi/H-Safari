import 'package:flutter/material.dart';

import 'category_model/category1.dart';
import 'category_model/category2.dart';
import 'category_model/category3.dart';
import 'category_model/category4.dart';
import 'category_model/category5.dart';
import 'category_model/category6.dart';
import 'category_model/category7.dart';
import 'category_model/category8.dart';

class MyCategory extends StatefulWidget {
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.cake, semanticLabel: 'cake',),
        title: Text('카테고리'),
      ),
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

final List<Widget> _categorypage = [
  category1(),
  category2(),
  category3(),
  category4(),
  category5(),
  category6(),
  category7(),
  category8(),
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

// ignore: missing_return

class categoryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (1.8),
      children: List.generate(8, (index) {
        return Center(
            child: Container(
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.grey[400],
                      elevation: 0.0,
                      //color: Colors.lightBlueAccent[200],
                      child: _categoryImage[index],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => _categorypage[index]));
                      }),
                ],
              ),
            ));
      }),
    );
  }
}
