import 'package:flutter/material.dart';
import 'category/category1.dart';
import 'category/category2.dart';
import 'category/category3.dart';
import 'category/category4.dart';
import 'category/category5.dart';
import 'category/category6.dart';
import 'category/category7.dart';
import 'category/category8.dart';

class MyCategory extends StatefulWidget {
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  List<String> _category = [
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
  final List<Widget> _categoryicon = [
    Icon(Icons.wc),
    Icon(Icons.book),
    Icon(Icons.fastfood),
    Icon(Icons.content_cut),
    Icon(Icons.video_call),
    Icon(Icons.toys),
    Icon(Icons.home),
    Icon(Icons.add_shopping_cart)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        leading: new Icon(Icons.cake),
        title: Text('카테고리'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (2.5),
        children: List.generate(8, (index) {
          return Center(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft : const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10)
                    ),
                    color: Colors.grey[400]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _categoryicon[index],
                      SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                          fillColor: Colors.lightBlueAccent[200],
                          child: Text(_category[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => _categorypage[index]));
                          }),
                    ],
                  ),

                ),
              ));
        }),
      ),
    );
  }
}