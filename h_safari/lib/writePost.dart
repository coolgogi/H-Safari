import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final _formkey = GlobalKey<FormState>();
  String drop = '카테고리';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('게시글 작성'),
      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('사진 업로드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            //사진 업로드
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),

                    Text("게시글 제목* ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '제목 입력',
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),
                    
                    Text("상품명* ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '상품명 입력',
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),

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

                    Text("카테고리* ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 30,
                      child: DropdownButton<String>(
                        value: drop,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (String newValue) {
                          setState(() {
                            drop = newValue;
                          });
                        },
//                        items: [
//                          DropdownMenuItem(
//                            value: '1',
//                            child: Text('의류'),
//                          ),
//                          DropdownMenuItem(
//                            value: '2',
//                            child: Text('서적'),
//                          )
//                        ]
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
