import 'package:flutter/material.dart';
import 'dart:math';
import 'package:h_safari/widget/widget.dart';

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  List<String> test = ['신청자1', '신청자2', '신청자3', '신청자4', '신청자5'];

  @override
  Widget build(BuildContext context) {
    // 이름 만드는 리스트
    var deco = ['귀여운', '잘생긴', '못생긴', '뚱뚱한', '착한', '한동대', '키가 큰', '키가 작은'];
    var animal = ['토끼', '강아지', '기린', '큰부리새', '김광일?', '코뿔소', '하마', '코끼리', '표범'];

    // 랜덤 변수 지정
    final _random = new Random();

    // 이름 값을 저장하는 리스트. (DB랑 연결되면 DB에 저장이 될 예정)
    List<String> names = [];

    for (int j = 1; j <= 10; j++) {
      // decoWord : 꾸미는 단어 랜덤으로 뽑기
      var decoWord = deco[_random.nextInt(deco.length)];
      // animal : 동물 단어 랜덤으로 뽑기
      var animalWord = animal[_random.nextInt(animal.length)];
      // userWord : 유저별 랜덤이름
      var userWord = decoWord + ' ' + animalWord;

      // userWord를 리스트 names에 삽입. (DB랑 연결되면 DB에 추가할 예정)
      names.add(userWord);
    }
    return Scaffold(
        appBar: appBar(context, '대기신청자'),
        body: Center(
            child: GestureDetector(
          child: ListView.builder(
              // shrinkWrap : (무슨 역할인지,, 모르겠어요)
              shrinkWrap: true,

              // itemCount : userName이 저장된 리스트 names의 길이만큼 다이어로그에 보여준다.
              itemCount: names.length,

              // itemBuilder : userName이 보여지는 공간
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  // padding : padding을 아래 10px 지정
                  padding: const EdgeInsets.only(left: 40, right : 40, top: 20),
                  child: Container(
                    // ListTile의 스타일 지정
                    decoration: BoxDecoration(

                        // 모서리 둥근 정도
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // 배경색
                        color: Colors.green[200]),
                    height: 55,
                    width: double.maxFinite,
                    child: //Text('$test[index]'),
                        ListTile(
                            title: Text('[' +
                                (index + 1).toString() +
                                '] ' +
                                names[index])),
                  ),
                );
              }),
        )));
  }
}
