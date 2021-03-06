import 'dart:ui';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:h_safari/services/database.dart';
import 'package:h_safari/views/post/post.dart';

// ignore: must_be_immutable
class PostUpdateDelete extends StatefulWidget {
  DocumentSnapshot tp;

  PostUpdateDelete(DocumentSnapshot doc) {
    tp = doc;
  }

  @override
  _PostUpdateDeleteState createState() => _PostUpdateDeleteState(tp);
}

String _value;
String previous;

class _PostUpdateDeleteState extends State<PostUpdateDelete> {
  String currentUid;
  String tpUrl =
      "https://cdn1.iconfinder.com/data/icons/material-design-icons-light/24/plus-512.png";

  final formKey = GlobalKey<FormState>();

  bool _delivery = false;
  bool _direct = false;
  String _category = '카테고리 미정';

  TextEditingController _newNameCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();
  TextEditingController _newPriceCon = TextEditingController();
  TextEditingController _newCategoryCon = TextEditingController();
  TextEditingController _newHowCon = TextEditingController();

  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  firebase_storage.FirebaseStorage _firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  String _profileImageURL = "";

  var _blankFocusnode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() {
    _user = _firebaseAuth.currentUser;
  }

  List<File> pictures;
  List<String> picURL;
  List<dynamic> tempList;

  _PostUpdateDeleteState(DocumentSnapshot doc) {
    // ignore: deprecated_member_use
    pictures = List<File>();
    // ignore: deprecated_member_use
    picURL = List<String>();
    _newNameCon.text = doc['name'];
    _newDescCon.text = doc['description'];
    _newPriceCon.text = doc['price'];
    _newHowCon.text = doc['how'];
    _newCategoryCon.text = doc['category'];
    tempList = doc['imageList'];

    for (int i = 0; i < tempList.length; i++) {
      String tp = tempList[i].toString();
      if (tp != "") picURL.add(tp);
    }

    _category = _newCategoryCon.text;
    _value = _newCategoryCon.text;
    if (_newHowCon.text == '3') {
      _delivery = true;
      _direct = true;
    } else if (_newHowCon.text == '2') {
      _delivery = false;
      _direct = true;
    } else if (_newHowCon.text == '1') {
      _delivery = true;
      _direct = false;
    } else {
      _delivery = false;
      _direct = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusnode);
        },
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  brightness: Brightness.light,
                  elevation: 2,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.green),
                  centerTitle: true,
                  title: Text(
                    '게시물 수정 및 삭제',
                    style: TextStyle(color: Colors.green),
                  ),
                  floating: true,
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '사진 업로드',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RawMaterialButton(
                                      child: Text(
                                        '추가',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: new Text("사진 업로드"),
                                              content: new Text("방식을 선택하세요"),
                                              actions: <Widget>[
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        child: new Text(
                                                          "사진첩",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                        onPressed: () {
                                                          _uploadImageToStorage(
                                                              ImageSource
                                                                  .gallery);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("카메라",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green)),
                                                        onPressed: () {
                                                          _uploadImageToStorage(
                                                              ImageSource
                                                                  .camera);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("취소",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ]),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                picURL.length != 0
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                                height: 110,
                                                width: (100.0) * picURL.length,
                                                child: GridView.count(
                                                    shrinkWrap: true,
                                                    crossAxisSpacing: 10,
                                                    crossAxisCount:
                                                        picURL.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    children: List.generate(
                                                        picURL.length, (index) {
                                                      return Stack(
                                                        children: <Widget>[
                                                          Container(
                                                            child:
                                                                Image.network(
                                                              picURL[index],
                                                            ),
                                                            alignment: Alignment
                                                                .topCenter,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: IconButton(
                                                              icon: Icon(Icons
                                                                  .highlight_off),
                                                              disabledColor:
                                                                  Colors.black,
                                                              onPressed: () {
                                                                setState(() {
                                                                  picURL
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }))),
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '대표 이미지',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ))
                                          ],
                                        ),
                                      )
                                    : Container(),
                                SizedBox(height: 20),
                                Text(
                                  "게시글 제목",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        hintText: '상품명 및 제목 입력',
                                      ),
                                      validator: (val) {
                                        return val.isEmpty ? '필수항목입니다!' : null;
                                      }),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "가격",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                        hintText: '가격 입력',
                                      ),
                                      validator: (val) {
                                        return val.isEmpty ? '필수항목입니다!' : null;
                                      }),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "카테고리",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 40),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: 30,
                                        child: FlatButton(
                                            shape: OutlineInputBorder(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _category,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Icon(Icons.arrow_drop_down),
                                              ],
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('카테고리'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text('취소'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            _value = previous;
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text('확인'),
                                                          onPressed: () {
                                                            if (_value !=
                                                                null) {
                                                              Navigator.pop(
                                                                  context,
                                                                  _value);
                                                              setState(() {
                                                                _category =
                                                                    _value;
                                                                previous =
                                                                    _value;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                      content: Container(
                                                        width: double.maxFinite,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            ListCat(),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            })),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '택배',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Checkbox(
                                      key: null,
                                      value: _delivery,
                                      activeColor: Colors.green,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _delivery = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      '직접거래',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Checkbox(
                                      key: null,
                                      value: _direct,
                                      activeColor: Colors.green,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _direct = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '상세정보',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: TextFormField(
                                      controller: _newDescCon,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        hintText: "상품의 상세한 정보를 적어주세요.",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green)),
                                      ),
                                      validator: (val) {
                                        return val.isEmpty ? '필수항목입니다!' : null;
                                      }),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.green,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                            color: Colors.green,
                                          )),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('취소',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                    ),
                                    RaisedButton(
                                      color: Colors.green,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                            color: Colors.green,
                                          )),
                                      onPressed: () {
                                        if (_newDescCon.text.isNotEmpty &&
                                            _newNameCon.text.isNotEmpty &&
                                            _newPriceCon.text.isNotEmpty) {
                                          _newCategoryCon.text = _category;
                                          _newHowCon.text =
                                              checkHow().toString();
                                          DatabaseMethods().updatePostDoc(
                                              widget.tp.id,
                                              _newNameCon.text,
                                              _newPriceCon.text,
                                              _newDescCon.text,
                                              picURL.join("우주최강CRA"),
                                              _newCategoryCon.text,
                                              _newHowCon.text);
                                          showDocument("post", widget.tp.id);
                                          _newNameCon.clear();
                                          _newDescCon.clear();
                                          _newPriceCon.clear();
                                          _profileImageURL = "";
                                          _newCategoryCon.clear();
                                          _newHowCon.clear();
                                          pictures.clear();
                                          picURL.clear();
                                        } else {
                                          checkAll();
                                        }
                                      },
                                      child: Text('업데이트',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                    ),
                                    RaisedButton(
                                      color: Colors.green,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                            color: Colors.green,
                                          )),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              {
                                                return AlertDialog(
                                                  content:
                                                      Text('게시글을 삭제하시겠습니까?'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        '취소',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, '취소');
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        '확인',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      onPressed: () {
                                                        DatabaseMethods()
                                                            .deletePostDoc(
                                                                context,
                                                                widget.tp.id);
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                );
                                              }
                                            });
                                      },
                                      child: Text('삭제',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ])))),
            )),
      ),
    );
  }

  checkAll() {
    if (formKey.currentState.validate()) {}
  }

  showDocument(String colName, String documentID) {
    FirebaseFirestore.instance
        .collection(colName)
        .doc(documentID)
        .get()
        .then((doc) {
      showReadPostPage(doc);
    });
  }

  void showReadPostPage(DocumentSnapshot doc) {
    setState(() {});
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Post(doc, true)));
  }

  void _uploadImageToStorage(ImageSource source) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);
    if (image == null) return;
    setState(() {
      _image = image;
      pictures.add(_image);
    });

    // firebase_storage.FirebaseStorage storageReference =
    //     _firebaseStorage.ref().child("post/${_user.uid}${Timestamp.now()}")
    //         as firebase_storage.FirebaseStorage;

    firebase_storage.UploadTask storageUploadTask =
        firebase_storage.FirebaseStorage.instance.ref().putFile(_image);
    await storageUploadTask.whenComplete(() => null);
    String downloadURL = await FirebaseStorage.instance.ref().getDownloadURL();
    setState(() {
      _profileImageURL = downloadURL;
      picURL.add(_profileImageURL);
      print("profileImageUrl : \n$_profileImageURL");
      print("picURL : \n$picURL");
    });
  }

  int checkHow() {
    if ((_delivery == false) && (_direct == false))
      return 0;
    else if ((_delivery == true) && (_direct == false))
      return 1;
    else if ((_delivery == false) && (_direct == true))
      return 2;
    else
      return 3;
  }
}

class ListCat extends StatefulWidget {
  @override
  _ListCatState createState() => _ListCatState();
}

class _ListCatState extends State<ListCat> {
  List<String> drop = [
    '의류',
    '서적',
    '음식',
    '생활용품',
    '가구전자제품',
    '뷰티잡화',
    '양도',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return RadioListTile<String>(
          title: Text(drop[index]),
          activeColor: Colors.green,
          value: drop[index],
          groupValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        );
      },
    );
  }
}
