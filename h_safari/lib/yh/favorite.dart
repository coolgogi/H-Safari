import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/home.dart';
import 'package:h_safari/pangil/bottombar.dart';

class FavoriteCategory extends StatefulWidget {
  @override
  _FavoriteCategoryState createState() => _FavoriteCategoryState();
}

class _FavoriteCategoryState extends State<FavoriteCategory> {
  bool _button = false;

  //카테고리 이름들을 저장하는 배열
  List<String> Category = [
    '의류',
    '서적',
    '음식',
    '생필품',
    '가구/전자제품',
    '뷰티/잡화',
    '양도',
    '기타',
  ];

  List<int> buttonColor = new List<int>();

  @override
  Widget build(BuildContext context) { //선호 카테고리를 고르는 창.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('선호 카테고리'),
      ),
      body: Column(
        children: <Widget>[
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: (1.7), //각 버튼의 세로 길이
            children: List.generate(8, (index) { //총 8개의 리스트를 만든다.
              return Center(
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min, //버튼들을 센터로 맞추는건데 이상하게 center와 이게 두개 다 있어야만 센터로 정렬이 되네요.
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 180, //각 버튼의 가로 길이
                      child: RaisedButton( //
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, //아이콘들과 텍스트를 가운데로 정렬
                          children: <Widget>[
                            Icon(Icons.favorite),
                            SizedBox(height: 10,),
                            Text(Category[index]),
                          ],
                        ),
                        color: _button ? Colors.white : Colors.blue,
                        onPressed: () {
                          //아직 아무것도 없지만 아마 여기서 선택한 값을 가져가서 My 선호에서 띄우는거겠죠...?
                          setState(() {
                            _button = !_button;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 20,),

          ButtonTheme(
            height: 40,
            child: OutlineButton(
              child: Text('확인', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GI_MyApp()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
