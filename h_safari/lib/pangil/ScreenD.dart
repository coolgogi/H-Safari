import 'package:flutter/material.dart';
import 'category/category1.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  List<String> _category = [
    '여성 의류',
    '남성 의류',
    '패션 잡화',
    '뷰티/미용',
    '스포츠/레저',
    '디지털/가전',
    '도서/티켓',
    '생활/식품',
    '문구/가구',
    '한동나눔',
    '양도구해요/해요',
    '구인구직',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (2.5),
      children: List.generate(12, (index) {
        return Center(
            child: RawMaterialButton(
                child: Text(_category[index]),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => category1()));
                }));
      }),
    );
  }
}
