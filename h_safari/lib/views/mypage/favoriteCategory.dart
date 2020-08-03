//YH

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/widget/widget.dart';

class FavoriteCategory extends StatefulWidget {
  DocumentSnapshot tp;
  FavoriteCategory(DocumentSnapshot doc){
    tp = doc;
  }
  @override
  _FavoriteCategoryState createState() => _FavoriteCategoryState(tp);
}

class _FavoriteCategoryState extends State<FavoriteCategory> {

  DocumentSnapshot tp;
  String userEmail;
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

  _FavoriteCategoryState(DocumentSnapshot doc){
    tp = doc;
    userEmail = tp['user'];
    button[0] = tp['의류'];
    button[1] = tp['서적'];
    button[2] = tp['음식'];
    button[3] = tp['생필품'];
    button[4] = tp['가구전자제품'];
    button[5] = tp['뷰티잡화'];
    button[6] = tp['양도'];
    button[7] = tp['기타'];
  }


  //카테고리 이름들을 저장하는 배열
  List<String> categoryName = [
    '의류',
    '서적',
    '음식',
    '생필품',
    '가구/전자제품',
    '뷰티/잡화',
    '양도',
    '기타',
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, '선호 카테고리'),
      body:
      Column(
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
                                Text(categoryName[index]),
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
                );//column
              })
          ),//GridView
          SizedBox(height: 20,), //카테고리와 버튼 사이 공간
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme( //모든 카테고리 선택 후 확인 버튼
                height: 40,
                child: OutlineButton(
                  child: Text('취소', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              ButtonTheme( //모든 카테고리 선택 후 확인 버튼
                height: 40,
                child: OutlineButton(
                  child: Text('확인', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    updateFavorite();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),//ButtonTheme
        ],
      ),
    );
  }

  void updateFavorite() {
    String colName = "users";
    Firestore.instance.collection(colName).document(userEmail).updateData({
      '의류' : button[0],
      '서적' : button[1],
      '음식' : button[2],
      '생필품' : button[3],
      "가구전자제품" : button[4],
      '뷰티잡화' : button[5],
      '양도' : button[6],
      '기타' : button[7],
    });
  }
}
