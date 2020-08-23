import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_safari/widget/widget.dart';

class FavoriteCategory extends StatefulWidget {
  DocumentSnapshot tp;

  FavoriteCategory(DocumentSnapshot doc) {
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

  _FavoriteCategoryState(DocumentSnapshot doc) {
    tp = doc;
    userEmail = tp['user'];
    button[0] = tp['의류'];
    button[1] = tp['서적'];
    button[2] = tp['음식'];
    button[3] = tp['생활용품'];
    button[4] = tp['가구전자제품'];
    button[5] = tp['뷰티잡화'];
    button[6] = tp['양도'];
    button[7] = tp['기타'];
  }

  List<String> categoryImage = [
    'Logo/favoriteImage/f_1.png',
    'Logo/favoriteImage/f_2.png',
    'Logo/favoriteImage/f_3.png',
    'Logo/favoriteImage/f_4.png',
    'Logo/favoriteImage/f_5.png',
    'Logo/favoriteImage/f_6.png',
    'Logo/favoriteImage/f_7.png',
    'Logo/favoriteImage/f_8.png',
  ];

  List<String> categoryName = [
    '의류',
    '서적',
    '음식',
    '생활용품',
    '가구/전자',
    '뷰티/잡화',
    '양도',
    '기타',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, '선호 카테고리'),
      body: Column(
        children: <Widget>[
          GridView.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 25,
            padding: EdgeInsets.all(25),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: (1.7),
              children: List.generate(8, (index) {
                return ButtonTheme(
                          padding: EdgeInsets.all(0),
                          minWidth: 160,
                          height: 100,
                          child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(categoryName[index], style: TextStyle(fontSize: 15),),),
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                    categoryImage[index],
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.black12)
                            ),
                            color: button[index]
                                ? Colors.green[200]
                                : Colors.white,
                            onPressed: () {
                              setState(() {
                                button[index] = !button[index];
                              });
                            },
                          ),
                    );
              })),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                height: 40,
                child: OutlineButton(
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              ButtonTheme(
                height: 40,
                child: OutlineButton(
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    updateFavorite();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateFavorite() {
    String colName = "users";
    Firestore.instance.collection(colName).document(userEmail).updateData({
      '의류': button[0],
      '서적': button[1],
      '음식': button[2],
      '생활용품': button[3],
      "가구전자제품": button[4],
      '뷰티잡화': button[5],
      '양도': button[6],
      '기타': button[7],
    });
  }
}
