import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/main/home.dart';
import 'package:h_safari/helpers/bottombar.dart';


//Page 부분
class FavoriteCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('선호 카테고리'),
      ),
      body: Column(
        children: <Widget>[

          SelectCategory(), //카테고리를 선택하는 statefullWidget class

          SizedBox(height: 20,), //카테고리와 버튼 사이 공간

          ButtonTheme( //모든 카테고리 선택 후 확인 버튼r
            height: 40,
            child: OutlineButton(
              child: Text('확인', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ),
        ],
      ),
    );
  }
}


//내부 구현 클래스
class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  //카테고리 이름들을 저장하는 배열
  List<String> CategoryName = [
    '의류',
    '서적',
    '음식',
    '생필품',
    '가구/전자제품',
    '뷰티/잡화',
    '양도',
    '기타',
  ];

  //각 카테고리별 선택용 bool 변수를 저장하는 리스트
  List<bool> button = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  //버튼의 색상을 지정해줄 변수 리스트
  List<int> buttonColor = new List<int>();

  @override
  Widget build(BuildContext context) { //선호 카테고리를 고르는 창.
    return Column(
      children: <Widget>[
        GridView.count( //gridview를 사용해 가로 4줄, 세로 2줄의 버튼을 만든다.
            shrinkWrap: true,
            crossAxisCount: 2, //세로줄
            childAspectRatio: (1.7), //각 버튼의 세로 길이
            children: List.generate(8, (index) { //8개의 리스트를 만든다.
              return Column(
                children: <Widget>[
                  ButtonBar(
                    mainAxisSize: MainAxisSize.min, //버튼들을 센터로 맞추는건데 이상하게 center와 이게 두개 다 있어야만 센터로 정렬이 되네요.
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 180, //각 버튼의 가로 길이
                        height: 100,
                        child: RaisedButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, //아이콘들과 텍스트를 가운데로 정렬
                            children: <Widget>[
                              Icon(Icons.favorite),
                              SizedBox(height: 10,),
                              Text(CategoryName[index]),
                            ],
                          ),
                          color: button[index] ? Colors.blue : Colors.white,
                          onPressed: () {
                            //아마 여기서 선택한 값을 가져가서 My 선호에서 띄우는거겠죠...?
                            setState(() {
                              button[index] = !button[index];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            })
        ),
      ],
      );
    //);
  }
}

