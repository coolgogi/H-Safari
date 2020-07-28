import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/main/home.dart';
import 'package:h_safari/helpers/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  _FavoriteCategoryState(DocumentSnapshot doc){
    tp = doc;
  }
  List<bool> button = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  _SelectCategoryState(DocumentSnapshot doc){
    tp = doc;
    String a = doc['의류'].toString();
    print("의류 : $a");
    button[0] = doc['의류'];
    button[1] = doc['서적'];
    button[2] = doc['음식'];
    button[3] = doc['생필품'];
    button[4] = doc['가구/전자제품'];
    button[5] = doc['뷰티/잡화'];
    button[6] = doc['양도'];
    button[7] = doc['기타'];
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('선호 카테고리'),
      ),
      body:
//      Column(
//        children: <Widget>[

//          SelectCategory(tp), //카테고리를 선택하는 statefullWidget class
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
                    SizedBox(height: 20,), //카테고리와 버튼 사이 공간
                    ButtonTheme( //모든 카테고리 선택 후 확인 버튼
                      height: 40,
                      child: OutlineButton(
                        child: Text('확인', style: TextStyle(color: Colors.black),),
                        onPressed: () {
        //                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        updateFavorite(tp);
                        },
                      ),
                    ),
                  ],
                );//column
              })
          ),
        ],
      ),
//      ),
    );
  }

  void updateFavorite(DocumentSnapshot doc) {
    Firestore.instance.collection("users").document(doc['user']).updateData({
      '의류' : button[0],
      '서적' : button[1],
      '음식' : button[2],
      '생필품' : button[3],
      '가구/전자제품' : button[4],
      '뷰티/잡화' : button[5],
      '양도' : button[6],
      '기타' : button[7],
    });
  }
}

//Page 부분
//class FavoriteCategory extends StatelessWidget {
//
//
//  @override
//
//
//}


//내부 구현 클래스
//class SelectCategory extends StatefulWidget {
//
//  DocumentSnapshot tp;
//
//  SelectCategory(DocumentSnapshot doc){
//    tp = doc;
//  }
//  @override
//  _SelectCategoryState createState() => _SelectCategoryState(tp);
//}
//
//class _SelectCategoryState extends State<SelectCategory> {
//
//  DocumentSnapshot tp;
//
//
//
//  //각 카테고리별 선택용 bool 변수를 저장하는 리스트
//
//
//  //버튼의 색상을 지정해줄 변수 리스트
//  List<int> buttonColor = new List<int>();
//
//  @override
//  Widget build(BuildContext context) { //선호 카테고리를 고르는 창.
//    return
//    //);
//  }
//
//}
//
