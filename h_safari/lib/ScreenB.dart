import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    // 버튼 로우 구성을 위한 컨테이너 위젯
    Widget buttonSection = Container(
      child: Row( // 로우를 자식으로 가짐
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 자식들이 여유 공간을 공편하게 나눠가짐
        children: <Widget>[ // 세개의 위젯들을 자식들로 가짐
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTH'),
          _buildButtonColumn(color, Icons.share, 'SHARE')
        ],
      ),
    );
    return MaterialApp(
        title: 'Flutter Layout Demo', // 앱의 타이틀
        theme: ThemeData(
          // 앱의 테마 설정
          primarySwatch: Colors.red, // 주요 테마 색상
        ),
        // 홈 설정. 홈은 메트리얼앱의 시작점
        home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter layout demo"),
          ),
          // 기존 body 삭제
          // body: Center(
          // child: Text("Hello World"),
          // ),
          // 새로운 body 선언
          body: Column(
            // 컬럼으로 교체
            // 자식들을 추가
            children: <Widget>[
              titleSection, // titleSection 컨테이너 추가
              buttonSection,
              textSection// buttonSection 컨테이너 추가
            ],
          ),
        ));
  }

  Widget titleSection = Container(
    // 컨테이너 내부 상하좌우에 32픽셀만큼의 패딩 삽입
    padding: const EdgeInsets.all(32),
    // 자식으로 로우를 추가
    child: Row(
      // 로우에 위젯들(Expanded, Icon, Text)을 자식들로 추가
      children: <Widget>[
        // 첫번째 자식
        Expanded(
          // 첫번째 자식의 자식으로 컬럼 추가
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 왼쪽정렬로 배치함
            // 컬럼의 자식들로 컨테이너와 텍스트를 추가
            children: <Widget>[
              // 컬럼의 첫번째 자식 컨테이너
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                // 컨테이너 내부 하단에 8픽셀만큼 패딩 삽입
                child: Text(
                  // 컨테이너의 자식으로 텍스트 삽입
                  "Oeschinen Lake Campground",
                  style: TextStyle(fontWeight: FontWeight.bold // 텍스트 강조 설정
                      ),
                ),
              ),
              // 컬럼의 두번째 자식으로 텍스트 삽입
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.grey[500] // 텍스트의 색상을 설정
                    ),
              )
            ],
          ),
        ),
        // 두번째 자식 아이콘
        Icon(
          Icons.star, // 별모양 아이콘 삽입
          color: Colors.red[500], // 빨간색으로 설정
        ),
        // 세번째 자식
        Text('43') // 텍스트 표시
      ],
    ),
  );
  // 버튼과 텍스트로 구성된 컬럼을 생성하여 반환하는 함수
  Column _buildButtonColumn(Color color,IconData icon, String label){
    // 컬럼을 생성하여 반환
    return Column(
      mainAxisSize: MainAxisSize.min, // 여유공간을 최소로 할당
      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
      // 컬럼의 자식들로 아이콘과 컨테이너를 등록
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),  // 컨테이너 상단에 8픽셀의 마진을 할당
          child: Text(  // 텍스트 할당
            label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color
            ),
          ),
        )
      ],
    );
  }
  // 텍스트로 구성된 컨테이너를 구현하는 위젯
  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true, // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
    ),
  );
}
