import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/yh/post.dart';

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

bool _delivery = false; //택배버튼
bool _direct = false; //직거래 버튼

class _SecondState extends State<Second> {
  final _formkey = GlobalKey<FormState>();

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
                                      Text('사진 업로드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                      IconButton(
                                        icon: Icon(Icons.photo_camera),
                                        onPressed: () {
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
                                      child: DropdownCat(),
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
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
}

class DropdownCat extends StatefulWidget {
  @override
  _DropdownCatState createState() {
    return _DropdownCatState();
  }
}

class _DropdownCatState extends State<DropdownCat> {
  String _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
              child: Text('의류'),
              value: 'one',
            ),
            DropdownMenuItem<String>(
              child: Text('서적'),
              value: 'two',
            ),
            DropdownMenuItem<String>(
              child: Text('전자기기'),
              value: 'three',
            ),
            DropdownMenuItem<String>(
              child: Text('음식'),
              value: 'four',
            ),
          ],
          onChanged: (String value) {
            setState(() {
              _value = value;
            });
          },
          hint: Text('카테고리'),
          value: _value,
        ),
      ],
    );
  }
}

bool checkDelivery() {
  return _delivery;
}

bool checkDirect() {
  return _direct;
}