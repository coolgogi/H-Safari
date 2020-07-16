import 'package:flutter/material.dart';
import 'package:h_safari/pangil/ScreenA.dart';

class FavoriteCategory extends StatefulWidget {
  @override
  _FavoriteCategoryState createState() => _FavoriteCategoryState();
}

class _FavoriteCategoryState extends State<FavoriteCategory> {
  @override
  Widget build(BuildContext context) { //선호 카테고리를 고르는 창.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('선호 카테고리'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonBar(
            mainAxisSize: MainAxisSize.min, //버튼들을 센터로 맞추는건데 이상하게 center와 이게 두개 다 있어야만 센터로 정렬이 되네요.
            children: <Widget>[
              ButtonTheme(
                minWidth: 180, //각 버튼의 가로, 세로 길이
                height: 120,
                child: Column( //일단 버튼들을 전부 outlineButton을 사용해 만들었는데 아이콘은 같이 안써지는 것 같아 나중에 수정할 필요가 있습니다.
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.favorite),
                              SizedBox(height: 10,),
                              Text('의류'),
                            ],
                          ),
                          onPressed: () {
                          },
                        ),
                        OutlineButton(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.favorite),
                              SizedBox(height: 10,),
                              Text('뷰티, 잡화'),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('음식'),
                          onPressed: () {},
                        ),
                        OutlineButton(
                          child: Text('생필품'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('가구/전자제품'),
                          onPressed: () {},
                        ),
                        OutlineButton(
                          child: Text('서적'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('양도'),
                          onPressed: () {},
                        ),
                        OutlineButton(
                          child: Text('기타'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),

              Row( //카테고리를 모두 선택한 후 누르는 확인 버튼.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 100,
                    height: 50,
                    child: RaisedButton(
                      child: Text('확인', style: TextStyle(color: Colors.white),),
                      onPressed: () { //누르면 바로 홈 화면으로 이동하도록.
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
