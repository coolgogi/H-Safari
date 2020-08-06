import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:h_safari/views/post/post(writer).dart';
import 'package:h_safari/views/post/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class postUpdateDelete extends StatefulWidget {
  DocumentSnapshot tp;

  postUpdateDelete(DocumentSnapshot doc) {
    tp = doc;
  }

  @override
  _postUpdateDeleteState createState() => _postUpdateDeleteState(tp);
}

String _value; //radioButton에서 값을 저장하는 변수
String previous; //radioButton에서 이전에 눌렀던 값을 저장하는 변수

class _postUpdateDeleteState extends State<postUpdateDelete> {
  String currentUid;
  String tpUrl =
      "https://cdn1.iconfinder.com/data/icons/material-design-icons-light/24/plus-512.png";

  final _formkey = GlobalKey<FormState>();

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

  String fnName;
  String fnDes;
  String fnDate;
  String fnPrice;
  String fnImage;
  String fnUid;
  String fnHow;
  String fnCategory;
  String fnEmail;

  List<File> pictures = List<File>();
  List<String> picURL = List<String>();
  int picLength = 0;
  double picWidth = 0;

  _postUpdateDeleteState(DocumentSnapshot doc) {
    fnName = doc['name'];
    fnDes = doc['description'];
    var date = doc['datetime'].toDate(); //timestamp to datetime
    fnDate = DateFormat('yyyy-MM-dd').add_Hms().format(date); //datetime format
    fnPrice = doc['price'];
    fnImage = doc['imageUrl'];
    fnUid = doc['uid'];
    fnCategory = doc['category'];
    fnHow = doc['how'];

    fnEmail = doc['email'];
    _newNameCon.text = fnName;
    _newPriceCon.text = fnPrice;
    _newDescCon.text = fnDes;
    _category = fnCategory;
    _value = fnCategory;
    if(fnHow == '3'){
      _delivery = true ;
      _direct = true ;
    }else if(fnHow == '2'){
      _delivery = false ;
      _direct = true ;
    }else if(fnHow == '1'){
      _delivery = true ;
      _direct = false ;
    }else{
      _delivery = false ;
      _direct = false ;
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
            //화면 스크롤 가능하게
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 2,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.green),
                  centerTitle: true,
                  title: Text(
                    '게시물 작성',
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
                      child: Padding(
                          padding: const EdgeInsets.all(.0),
                          child: Form(
                              key: _formkey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '사진 업로드*',
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
                                                            child:
                                                                new Text("사진첩"),
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
                                                            child:
                                                                new Text("카메라"),
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
                                                                "Close"),
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
                                    //SizedBox(height: 10),

                                    //사진 업로드
                                    picLength != 0
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Flexible(
                                                  child: Container(
                                                    height: 130,
                                                    width: (picLength != 0)
                                                        ? (picWidth + 130) *
                                                            pictures.length
                                                        : picWidth,
                                                    child: (picLength > 0)
                                                        ? GridView.count(
                                                            shrinkWrap: true,
                                                            crossAxisCount:
                                                                pictures.length,
                                                            crossAxisSpacing:
                                                                10,
                                                            physics:
                                                                ScrollPhysics(),
                                                            children:
                                                                List.generate(
                                                                    pictures
                                                                        .length,
                                                                    (index) {
                                                              return Stack(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            image:
                                                                                DecorationImage(
                                                                      image: (_image !=
                                                                              null)
                                                                          ? FileImage(pictures[
                                                                              index])
                                                                          : NetworkImage(
                                                                              tpUrl),
                                                                      //fit: BoxFit.cover
                                                                    )),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .highlight_off),
                                                                      disabledColor:
                                                                          Colors
                                                                              .black,
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          pictures
                                                                              .removeAt(index);
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }))
                                                        : SizedBox(
                                                            width: 0,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: 0,
                                          ),

                                    SizedBox(height: 30),

                                    //게시글 제목 및 상품명을 적을 텍스트필드
                                    Text(
                                      "게시글 제목* ",
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
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green)),
                                          hintText: '상품명 및 제목 입력',
                                        ),
                                        validator: (value) {
                                          //아무것도 입력하지 않았을 때 뜨는 에러메세지.
                                          if (value.isEmpty) {
                                            return '제목을 입력해 주세요.';
                                          }
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    //가격 입력하는 텍스트 필드
                                    Text(
                                      "가격* ",
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
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green)),
                                          hintText: '가격 입력',
                                        ),
                                        validator: (value) {
                                          //아무것도 입력하지 않았을 때 뜨는 에러메세지.
                                          if (value.isEmpty) {
                                            return '제목을 입력해 주세요.';
                                          }
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    //이제 카테고리에서 선택한 값을 게시글(post)에도 그대로 적용할 수 있도록 하는게 관건이네요.
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "카테고리* ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 50),
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
                                                          fontSize: 15
                                                      ),
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
                                                                child: Text('취소'),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  _value = previous; //취소를 누르면 선택된 value 값을 전부 null로 만들어 모든 버튼이 unselect 된다.
                                                                },
                                                              ),
                                                              FlatButton(
                                                                child: Text('확인'),
                                                                onPressed: () {
                                                                  if (_value != null) {
                                                                    Navigator.pop(context, _value);
                                                                    setState(() {
                                                                      //확인 버튼을 눌렀을 때만 값이 바뀌도록
                                                                      _category = _value;
                                                                      previous = _value;
                                                                    });
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                            content: Container(
                                                              width: double.maxFinite,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
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
                                      height: 30,
                                    ),

                                    //택배거래와 직접거래 중 판매자가 직접 선택할 수 있는 버튼
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
                                      height: 30,
                                    ),

                                    //상품 설명을 적을 텍스트필드
                                    Container(
                                      child: TextField(
                                        controller: _newDescCon,
                                        maxLines: 10,
                                        //max 10줄이라고 돼있는데 그 이상도 적어지네요...?
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

                                    //확인하고 게시글을 등록하는 버튼
                                    //모든 글을 다 적었는지는 확인하는 부분은 아직 미구현
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              fnCategory = _category;
                                              fnHow = checkHow().toString();

                                              updateDoc(
                                                  widget.tp.documentID,
                                                  _newNameCon.text,
                                                  _newPriceCon.text,
                                                  _newDescCon.text,
                                                  fnCategory,
                                                  fnHow);
                                              showDocument(widget.tp.documentID);
                                              _newNameCon.clear();
                                              _newDescCon.clear();
                                              _newPriceCon.clear();
                                              _profileImageURL = "";
                                              _newCategoryCon.clear();
                                              _newHowCon.clear();
                                              pictures.clear();
                                              picURL.clear();
//                                          myapp._currentIndex = 1;
//                                          showDocument(document.documentID);
                                            } else {
                                              //경고 메세지 부탁
                                            }
                                          },
                                          child: Text('업데이트', style: TextStyle(fontSize: 15, color: Colors.white)),
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
                                            deleteDoc(widget.tp.documentID);
                                          },
                                          child: Text('삭제',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ]))))),
            )),
      ),
    );
  }

  void updateDoc(String docID, String name, String price, String description,String category, String how) {
    Firestore.instance.collection('post').document(docID).updateData({
      "name": name,
      "price": price,
      "description": description,
      "category" : category,
      "how" : how,
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance.collection('post').document(docID).delete();
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
    setState(() {});
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPost(doc, doc.documentID)));
  }

  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
      pictures.add(_image);
      picLength++;
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
  //카테고리 이름을 저장하는 리스트 배열
  List<String> drop = [
    '의류',
    '서적',
    '음식',
    '생필품',
    '가구/전자제품',
    '뷰티/잡화',
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

