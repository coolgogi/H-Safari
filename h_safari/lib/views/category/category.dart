import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';
import 'categoryView.dart';

class MyCategory extends StatefulWidget {
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  final List<String> _category = [
    '의류',
    '서적',
    '음식',
    '생활용품',
    '가구전자제품',
    '뷰티잡화',
    '양도',
    '기타'
  ];

  final List<String> _categoryImage = [
    'Logo/categoryImage/m_1_clothes.png',
    'Logo/categoryImage/m_2_book.png',
    'Logo/categoryImage/m_3_food.png',
    'Logo/categoryImage/m_4_daily.png',
    'Logo/categoryImage/2nd_m_5_furniture2.png',
    'Logo/categoryImage/m_6_beauty.png',
    'Logo/categoryImage/m_7_housetrans.png',
    'Logo/categoryImage/2nd_m_8_other2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain('카테고리'),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          GridView.count(
            padding: EdgeInsets.fromLTRB(40, 30, 40, 40),
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: (1.7),
            children: List.generate(8, (index) {
              return InkWell(
                  child: Container(
                    child: Image.asset(
                      _categoryImage[index],
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Logo/categoryImage/m_1_clothes.png'),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          //offset: Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CategoryView(select: _category[index])));
                  });
            }),
          ),
        ],
      ),
    );
  }
}
