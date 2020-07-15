import 'package:flutter/material.dart';
import 'writePost.dart';
import 'login.dart';
import '../firebase/firebase_provider.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  FirebaseProvider fp;
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('게시글 제목'), //이 부분은 연동하면 작성자가 적은 게시글 이름으로 바뀌게 수정해야 해요.
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blueAccent,
        ),
        child: BottomNavigationBar( //화면 하단에 찜, 구매신청 등 넣으려는 바텀 앱바
          backgroundColor: Colors.blue,
          items: [
            BottomNavigationBarItem( //찜 버튼
              icon: IconButton(
                icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                onPressed: () { //버튼을 누르면 하트가 채워지는 찜 버튼
                  setState(() {
                    favorite = !favorite;
                  });},
              ),
              title: Container(),
            ),
            BottomNavigationBarItem( //누르면 판매자에게 암림이 가는 구매 신청 버튼(알림 미구현)
                icon: Container(),
                title: Text('구매 신청', style: TextStyle(color: Colors.white),),
            ),
            BottomNavigationBarItem( //본인이 몇 번재 대기자인지 보여주는 버튼(미구현)
                icon: Container(),
                title: Text('랭크?', style: TextStyle(color: Colors.white),)
            ),
            BottomNavigationBarItem( //현재 게시글에 달린 댓글 보는 버튼(미구현)
                icon: Container(),
                title: Text('댓글', style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( //화면 스크롤 가능하게
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //이미지 넣는건 구현했지만 두 가지 더 구현해야해요.
                // 1. 연동시켜서 사용자가 올린 사진을 가져올 것,
                // 2. 사진 사이즈가 크면 화면 밖으로 나가지 않게 사이즈 조절
                // 3. 사진 여러 장 올리면 옆으로 밀어서 더 볼 수 있게
                //확인
                child: Center(child: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg",)),
              ),

              SizedBox(height: 30,),

              //일단 틀만 잡는 거라서 전부 텍스트로 직접 입력했는데 연동하면 게시글 작성한 부분에서 가져와야 할듯 합니다.
              Text('5,000원', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('전공 서적 팝니다. 전부 5천원', style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Text('카테고리: 서적', style: TextStyle(fontSize: 15, color: Colors.black54),),
              SizedBox(height: 10,),

              Row( //일단은 체크박스 아이콘만 사용해서 전부 체크된 것처럼 보입니다.
                // 게시글 작성에서 체크한 부분만 체크박스 아이콘 뜨도록 구현해야 해요.
                children: [
                  Text('택배', style: TextStyle(fontSize: 15, color: Colors.black),),
                  Icon(Icons.check_box),
                  //Icon(Icons.check_box_outline_blank),
                  Text('직접거래', style: TextStyle(fontSize: 15),),
                  Icon(Icons.check_box),
                  //Icon(Icons.check_box_outline_blank),
                ],
              ),

              SizedBox(height: 30,),

              //게시글 작성에 있던 글 설명. 연동해서 가져오면 그대로 넣으면 될 것 같아요.
              Text('글 설명 장황하게~~~~~~~~~~~~~~~~~~~~~'),

            ],
          )
        ),
      ),
    );
  }
}
