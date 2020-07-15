import 'package:flutter/material.dart';

class ModifyProfile extends StatefulWidget {
  @override
  _ModifyProfileState createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 프로필 수정'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg')),
              ),
              RawMaterialButton( //누르면 자기 엘범으로 이어지게 설정해야함
                child: Text(
                  '프로필 사진 바꾸기',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                ),
                //onPressed: 사진업로드하는 함수짜기,
              ),
              Container(
                  padding: EdgeInsets.only(top: 50),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '닉네임 바꾸기',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '바꾸실 닉네임을 입력해주세요.',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('취소'),
                      onPressed: (){},
                      //onPressed: 업로드된 사진을 삭제하고 원래 사진으로 유지, 닉네임은 그냥 취소,
                    ),
                    RaisedButton(
                      child: Text('저장'),
                      onPressed: (){},
                      //onPressed: 업로드된 사진으로 원래 사진을 대체, 닉네임칸에 있는 문구를 저장하고 닉네임을 변경,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}