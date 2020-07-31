import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../helpers/bottombar.dart';

import 'package:h_safari/widget/widget.dart';




class asking extends StatefulWidget{
  @override
  _askingState createState() => _askingState();
}

bool _delivery = false; //택배버튼
bool _direct = false; //직거래 버튼
String _category = '카테고리 미정'; //카테고리 선택시 값이 변하도록 하기 위한 변수
String _value; //radioButton에서 값을 저장하는 변수
String previous; //radioButton에서 이전에 눌렀던 값을 저장하는 변수


class _askingState extends State<asking> {

  String currentUid;
  static String tpUrl = "https://cdn1.iconfinder.com/data/icons/material-design-icons-light/24/plus-512.png";

  final _formkey = GlobalKey<FormState>();

  TextEditingController _newNameCon = TextEditingController(); //제목저장
  TextEditingController _newDescCon = TextEditingController(); //설명저장
  TextEditingController _newPriceCon = TextEditingController(); //가격저장
  TextEditingController _newCategoryCon = TextEditingController(); //카테고리 저장
  TextEditingController _newHowCon = TextEditingController(); //거래유형 저장

  //이미지 저장
  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  var _blankFocusnode = new FocusNode(); //키보드 없애는 용

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
  }

  // 컬렉션명
  final String colName = "post";

  // 필드명
  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";
  final String fnPrice = "price";
  final String fnImageUrl = "imageUrl";
  final String fnCategory = "category";
  final String fnHow = 'how';
  final String fnUid = "uid";
  final String fnEmail = "email";

  List<String> pictures = List<String>();
  int picLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, '문의하기'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusnode);
        },
        child: SingleChildScrollView( //화면 스크롤 가능하게
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(.0),
                        child: Form(
                            key: _formkey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //게시글 제목 및 상품명을 적을 텍스트필드
                                  Text("이메일 주소 *", style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight
                                      .bold),),
                                  SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    child: TextFormField(
                                      controller: _newNameCon,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green)),
                                          hintText: '문의하는 분의 이메일'
                                      ),
//                                      validator: (value) { //아무것도 입력하지 않았을 때 뜨는 에러메세지.
//                                        if(value.isEmpty) {return '제목을 입력해 주세요.';}},
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  //가격 입력하는 텍스트 필드
                                  Text("제목 * ", style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight
                                      .bold),),
                                  SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _newPriceCon,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        hintText: '문의 제목',
                                      ),
//                                      validator: (value) { //아무것도 입력하지 않았을 때 뜨는 에러메세지.
//                                        if(value.isEmpty) {return '제목을 입력해 주세요.';}},
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  Text("문의 내용 * ", style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight
                                      .bold),),
                                  //상품 설명을 적을 텍스트필드
                                  SizedBox(height: 10),

                                  Container(
                                    child: TextField(
                                      controller: _newDescCon,
                                      maxLines: 10,
                                      //max 10줄이라고 돼있는데 그 이상도 적어지네요...?
                                      decoration: InputDecoration(
                                        hintText: "문의 내용을 적어주세요.",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  //확인하고 게시글을 등록하는 버튼
                                  //모든 글을 다 적었는지는 확인하는 부분은 아직 미구현
                                  Center(
                                    child: RaisedButton(
                                      color: Colors.green,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                          side: BorderSide(color: Colors.green,)
                                      ),
                                      onPressed: () { //화면 전환을 위해 바로 게시글로 이동하게 했습니다.
                                      },
                                      child: Text('제출', style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                    ),
                                  ),
                                ]
                            )
                        )
                    )
                )
            )
        ),
      ),
    );
  }
}