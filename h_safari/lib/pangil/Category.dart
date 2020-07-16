import 'package:flutter/material.dart';
import 'category/category1.dart';
import 'category/category2.dart';
import 'category/category3.dart';
import 'category/category4.dart';
import 'category/category5.dart';
import 'category/category6.dart';
import 'category/category7.dart';
import 'category/category8.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
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

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.grade),
                  SizedBox(
                    width: 10,
                  ),
                  RawMaterialButton(
                      fillColor: Colors.blue,
                      child: Text(_category[index], style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => _categorypage[index]));
                      }),
                ],
              ));
        }),
      ),
    );
  }
}