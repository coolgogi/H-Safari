import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyWrite extends StatefulWidget {
  @override
  _MyWriteState createState() => _MyWriteState();
}

bool _delivery = false; //택배버튼
bool _direct = false; //직거래 버튼

class _MyWriteState extends State<MyWrite> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _newNameCon = TextEditingController();  //제목저장
  TextEditingController _newDescCon = TextEditingController();  //설명저장
  //이미지 저장
  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
  }

  // 컬렉션명
  final String colName = "FirstDemo";

  // 필드명
  final String fnName = "name";
  final String fnDescription = "description";
  final String fnDatetime = "datetime";
  final String fnImageUrl = "imageUrl";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('게시글 작성'),
        ),
        body: SingleChildScrollView( //화면 스크롤 가능하게
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
                                  Row( //사진 업로드 텍스트와 아이콘 한줄로 정렬
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                        (_image != null) ? FileImage(_image) : NetworkImage(""),
                                        radius: 30,
                                      ),
                                      Text('사진 업로드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                      IconButton(
                                        icon: Icon(Icons.photo_camera),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                title: new Text("사진 업로드 방식"),
                                                content: new Text("사진 업로드 방식을 선택하세요."),
                                                actions: <Widget>[
                                                  // usually buttons at the bottom of the dialog
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        child: new Text("사진첩"),
                                                        onPressed: () {
                                                          _uploadImageToStorage(ImageSource.gallery);
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("카메라"),
                                                        onPressed: () {
                                                          _uploadImageToStorage(ImageSource.camera);
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("Close"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ]
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          //사진 업로드(여러 장 올릴 수 있게)
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 30,),

                                  //게시글 제목 및 상품명을 적을 텍스트필드
                                  Text("게시글 제목* ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                                  SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30,
                                    child: TextFormField(
                                      controller: _newNameCon,
                                      decoration: InputDecoration(
                                        hintText: '상품명 및 제목 입력',
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  //가격 입력하는 텍스트 필드
                                  Text("가격* ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                                  SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30,
                                    child: TextFormField(

                                      decoration: InputDecoration(
                                        hintText: '가격 입력',
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  //카테고리를 선택하는 드롭다운버튼(함수를 따로 만들어 여기서는 함수 call만 할 수 있도록)
                                  //해결완료!!
                                  //다만 이제 카테고리에서 선택한 값을 게시글(post)에도 그대로 적용할 수 있도록 하는게 관건이네요.
                                  Text("카테고리* ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                                  SizedBox(height: 10),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      height: 30,
                                      child: FlatButton(
                                        child: Text('카테고리 선택'),
                                       onPressed: () {
                                         DropButton(context);
                                       }
                                      )
                                      //Text('임시방편'),
                                  ),

                                  SizedBox(height: 30,),

                                  //택배거래와 직접거래 중 판매자가 직접 선택할 수 있는 버튼
                                  Row(
                                    children: [
                                      Text('택배', style: TextStyle(fontSize: 15),),
                                      Checkbox(
                                        key: null,
                                        value: _delivery,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _delivery = value;
                                          });
                                        },
                                      ),
                                      Text('직접거래', style: TextStyle(fontSize: 15),),
                                      Checkbox(
                                        key: null,
                                        value: _direct,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _direct = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 30,),

                                  //상품 설명을 적을 텍스트필드
                                  Container(
                                    child: TextField(
                                      controller: _newDescCon,
                                      maxLines: 10, //max 10줄이라고 돼있는데 그 이상도 적어지네요...?
                                      decoration: InputDecoration(
                                        hintText: "상품의 상세한 정보를 적어주세요.",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  //확인하고 게시글을 등록하는 버튼
                                  //모든 글을 다 적었는지는 확인하는 부분은 아직 미구현
                                  Center(
                                    child: RaisedButton(
                                      onPressed: () { //화면 전환을 위해 바로 게시글로 이동하게 했습니다.
//                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                                        if (_newDescCon.text.isNotEmpty &&
                                            _newNameCon.text.isNotEmpty) {
                                          createDoc(_newNameCon.text, _newDescCon.text, _profileImageURL);
                                        }
                                        _newNameCon.clear();
                                        _newDescCon.clear();
                                        _profileImageURL = '';
                                      },

                                      child: Text('게시글 등록', style: TextStyle(fontSize: 15),),
                                    ),
                                  ),
                                ]
                            )
                        )
                    )
                )
            )
        )
    );
  }
  void createDoc(String name, String description, String imageURL) async {
    Firestore.instance.collection(colName).add({
      fnName: name,
      fnDescription: description,
      fnDatetime: Timestamp.now(),
      fnImageUrl : imageURL,
    });

  }
  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
    });

    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
//    StorageReference storageReference =
//    _firebaseStorage.ref().child("profile/${_user.uid}");
    // 프로필 사진을 업로드할 경로와 파일명을 정의. uid를 이용하지말고 documentId를 이용하기 위해 찾아보는중
    // 그래서 지금 uid + Timestamp를 쓰는
    StorageReference storageReference =
    _firebaseStorage.ref().child("profile/${_user.uid}${Timestamp.now()}");

    // 파일 업로드
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);

    // 파일 업로드 완료까지 대기
    await storageUploadTask.onComplete;

    // 업로드한 사진의 URL 획득 //필요?
    String downloadURL = await storageReference.getDownloadURL();

    // 업로드된 사진의 URL을 페이지에 반영 //필요??
    setState(() {
      _profileImageURL = downloadURL;
    });
  }
}


//기존 dopdownButton에서 alertDialog list로 수정!
void DropButton(BuildContext context)async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuilderContext) {
        return DropCat();
      }
  );
}

class DropCat extends StatefulWidget {
  @override
  _DropCatState createState() {
    return _DropCatState();
  }
}

class _DropCatState extends State<DropCat> {
  String _value;
  int _select;

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
    return AlertDialog(
      title: Text('카테고리'),
      actions: <Widget>[
        FlatButton(
          child: Text('취소'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('확인'),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _value = _value;
            });
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      title: Text(drop[index]),
                      value: index,
                      groupValue: _select,
                      onChanged: (value) {
                        setState(() {
                          _select = index;
                        });
                      }
                  );
                },
              )
//          onChanged: (String value) {
//            setState(() {
//              _value = value;
//            });
//          },
//          hint: Text('카테고리'),
//          value: _value,
//        ),
            ],
          ),
        ),
      ),
    );
  }
}

bool checkDelivery() {
  return _delivery;
}

bool checkDirect() {
  return _direct;
}