import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:h_safari/views/post/post.dart';

class MyWrite extends StatefulWidget {
  @override
  _MyWriteState createState() => _MyWriteState();
}

String _value; //radioButton에서 값을 저장하는 변수
String previous; //radioButton에서 이전에 눌렀던 값을 저장하는 변수

class _MyWriteState extends State<MyWrite> {
  String currentUid;
  String tpUrl =
      "https://cdn1.iconfinder.com/data/icons/material-design-icons-light/24/plus-512.png";

  final formKey = GlobalKey<FormState>();

  bool _delivery = false; //택배버튼
  bool _direct = false; //직거래 버튼
  String _category = '카테고리 미정'; //카테고리 선택시 값이 변하도록 하기 위한 변수

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
  String _profileImageURL = ""; // 대표사진

  var _blankFocusNode = new FocusNode(); //키보드 없애는 용

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
  final String fnImageList = "imageList";
  final String fnCategory = "category";
  final String fnHow = 'how';
  final String fnUid = "uid";
  final String fnEmail = "email";
  final String fnCommentList = "commentUserList";
  final String fnWaitingList = "waitingUserList";
  final String fnClose = "close";

  List<File> pictures;
  List<String> picURL;

  _MyWriteState(){
    pictures = List<File>();
    picURL = List<String>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _value = null;
        previous = null;
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_blankFocusNode);
          },
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 2,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _value = null;
                        previous = null;
                        Navigator.pop(context);
                      },
                    ),
                    iconTheme: IconThemeData(color: Colors.green),
                    centerTitle: true,
                    title: Text(
                      '게시물 작성',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    floating: true,
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Container(
                        child: Padding(
                            padding: const EdgeInsets.all(.0),
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
                                                  // return object of type Dialog
                                                  return AlertDialog(
                                                    title: new Text("사진 업로드"),
                                                    content:
                                                    new Text("방식을 선택하세요."),
                                                    actions: <Widget>[
                                                      // usually buttons at the bottom of the dialog
                                                      Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: <Widget>[
                                                            new FlatButton(
                                                              child: new Text(
                                                                "사진첩",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                              onPressed: () {
                                                                _uploadImageToStorage(
                                                                    ImageSource
                                                                        .gallery);
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            new FlatButton(
                                                              child: new Text(
                                                                  "카메라",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green)),
                                                              onPressed: () {
                                                                _uploadImageToStorage(
                                                                    ImageSource
                                                                        .camera);
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            new FlatButton(
                                                              child: new Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
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
                                      pictures.length != 0
                                          ? Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          SingleChildScrollView(
                                            scrollDirection:
                                            Axis.horizontal,
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 110,
                                                  width: (100.0) *
                                                      pictures.length,
                                                  child: GridView.count(
                                                      shrinkWrap:
                                                      true,
                                                      crossAxisCount: pictures.length,
                                                      crossAxisSpacing:
                                                      10,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      children: List
                                                          .generate(
                                                          pictures
                                                              .length,
                                                              (index) {
                                                            return Stack(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                      image: DecorationImage(
                                                                        image: FileImage(pictures[index])
                                                                      )),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                  Alignment.topRight,
                                                                  child:
                                                                  IconButton(
                                                                    icon:
                                                                    Icon(Icons.highlight_off),
                                                                    disabledColor:
                                                                    Colors.black,
                                                                    onPressed:
                                                                        () {
                                                                      setState(() {
                                                                        pictures.removeAt(index);
                                                                        picURL.removeAt(index);
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }))
                                                ),
                                                Align(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      '대표 이미지',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .green),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
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
                                              hintText: '상품명 및 제목 입력',
                                            ),
                                            validator: (val){
                                              return val.isEmpty ? '필수항목입니다!' : null;
                                            }
                                        ),
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
                                              hintText: '가격 입력',
                                            ),
                                            validator: (val) {
                                              return val.isEmpty ? '필수항목입니다!' : null;
                                            }
                                        ),
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
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Icon(Icons.arrow_drop_down),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    //DropButton(context);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          //기존 dopdownButton에서 alertDialog list로 수정!
                                                          //원래는 따로 함수를 만들어서 call 하는 방식이었는데 값을 가져오는데 문제가 있어 직접 코드를 옮겼습니다.
                                                          return //DropCat();
                                                            AlertDialog(
                                                              title: Text('카테고리'),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text('취소',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .green)),
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    _value =
                                                                        previous; //취소를 누르면 선택된 value 값을 전부 null로 만들어 모든 버튼이 unselect 된다.
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text('확인',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .green)),
                                                                  onPressed: () {
                                                                    if (_value !=
                                                                        null) {
                                                                      Navigator.pop(
                                                                          context,
                                                                          _value);
                                                                      setState(() {
                                                                        //확인 버튼을 눌렀을 때만 값이 바뀌도록
                                                                        _category =
                                                                            _value;
                                                                        previous =
                                                                            _value;
                                                                      });
                                                                    }
                                                                  },
                                                                ),
//                                                              (copyIndex!=2) ? _value=null : _value=_value,
                                                              ],
                                                              content: Container(
                                                                height: MediaQuery.of(context).size.height*5/4,
                                                                width: double
                                                                    .maxFinite,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: <
                                                                      Widget>[
                                                                    ListCat(),
                                                                    //다이얼로그 안에서 radioButton을 불러오는 함수
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
                                          validator: (val){
                                            return val.isEmpty ? '필수항목입니다!' : null;
                                          },
                                          controller: _newDescCon,
                                          maxLines: 10,
                                          decoration: InputDecoration(
                                            hintText: "상품의 상세한 정보를 적어주세요.",
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: RaisedButton(
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
                                              createDoc(
                                                  _newNameCon.text,
                                                  _newDescCon.text,
                                                  _newPriceCon.text,
                                                  picURL.isEmpty ? "" : picURL[0],
                                                  picURL.join(
                                                      ',')); // "picURL[0],picURL[1],..."
                                              _newNameCon.clear();
                                              _newDescCon.clear();
                                              _newPriceCon.clear();
                                              _profileImageURL = "";
                                              _newCategoryCon.clear();
                                              _newHowCon.clear();
                                              pictures.clear();
                                              picURL.clear();
                                              _value = null;
                                              previous = null;
                                            } else {
                                              checkAll();
                                            }
                                          },
                                          child: Text('게시글 등록',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ]))))),
              )),
        ),
      ),
    );
  }

  checkAll() {
    if(formKey.currentState.validate()){}
  }

  void createDoc(String name, String description, String price, String imageURL,
      String picURL) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
    Firestore.instance.collection(colName).document();

    List<String> splitString = picURL.split(',');
    List<String> co = List();
    co.add(user.email);
    List<String> wa = List();

    documentReference.setData({
      fnName: name,
      fnDescription: description,
      fnDatetime: Timestamp.now(),
      fnPrice: price,
      fnImageUrl: imageURL, //대표사진
      fnImageList: splitString, //사진 리스트
      fnCategory: _category,
      fnHow: checkHow().toString(),
      fnUid: user.uid.toString(),
      fnEmail: user.email,
      fnCommentList: co,
      fnWaitingList: wa,
      fnClose: false,
    });
    Navigator.pop(context);
    showDocument(documentReference.documentID);
  }

  void showDocument(String documentID) {
    Firestore.instance
        .collection(colName)
        .document(documentID)
        .get()
        .then((doc) {
      showReadPostPage(doc);
    });
  }

  void showReadPostPage(DocumentSnapshot doc) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Post(doc, true)));
  }

  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
      pictures.add(_image);
    });

    StorageReference storageReference =
    _firebaseStorage.ref().child("profile/${_user.uid}${Timestamp.now()}");

    // 파일 업로드
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);

    // 파일 업로드 완료까지 대기
    await storageUploadTask.onComplete;

    // 업로드한 사진의 URL 획득 //필요? -> 필요합니당
    String downloadURL = await storageReference.getDownloadURL();

    // 업로드된 사진의 URL을 페이지에 반영 //필요?? -> 필요합니당
    setState(() {
      _profileImageURL = downloadURL;
      picURL.add(_profileImageURL);
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
  //카테고리 이름을 저장하는 리스트 배열
  List<String> drop = [
    '의류',
    '서적',
    '음식',
    '생필품',
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