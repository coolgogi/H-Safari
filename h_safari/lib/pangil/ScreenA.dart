import 'package:flutter/material.dart';
import 'Alarm.dart';
import 'package:h_safari/yh/post.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  int _counter = 0;

  @override
  bool get wantKeepAlive => true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: TextField(
          style: TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.start,
          decoration: InputDecoration(hintText: '검색'),
          onChanged: (String str) {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('shopping cart button is clicked');
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Alarm()));
            },
          ),
        ],
        bottom: TabBar(
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.text,
              icon: Icon(choice.icon), // 이전 코드와 다른 부분
            );
          }).toList(),
          isScrollable: true,
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'CATEGORY',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '여성 의류',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '남성 의류',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '패션 잡화',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '뷰티/미용',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '스포츠/레저',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '디지털/가전',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '도서/티켓',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '생활/식품',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '문구/가구',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '한동나',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '양도구해요/해요',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      subtitle: Center(
                        child: Text(
                          '구인구직',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body : TabBarView(
        // map과 toList 함수를 연결해서 화면 리스트 전달
        children: choices.map((Choice choice) {
          // 문자열과 아이콘을 모두 포함하는 위젯 객체 생성
          // 이전 코드에서는 Text 위젯 하나만 사용했었다. 코드가 많아 클래스로 분리.
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg", width: 100,),
                    title: Text(
                      '5,000원',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg", width: 100,),
                    title: Text(
                      '5,000원',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                    },
                  ),
                  ListTile(
                    leading: Image.network("https://futurekorea.co.kr/news/photo/201008/19819_12059_5636.jpg", width: 100,),
                    title: Text(
                      '5,000원',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('서적 팔아요~ 전부 5천원'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                    },
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),

//      Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//
//
//          ],
//        ),
//      ),
    );
  }
}

class Choice {
  Choice(this.text, this.icon);

  final String text;
  final IconData icon;

// 매개변수를 전달할 때 {}가 있다면 매개변수 이름을 생략할 수 없다.
// Choice({this.title, this.icon});
}

final choices = [
  Choice('PLANE', Icons.flight),
  Choice('CAR', Icons.directions_car),
  Choice('BIKE', Icons.directions_bike),
  Choice('BOAT', Icons.directions_boat),
  Choice('BUS', Icons.directions_bus),
  Choice('TRAIN', Icons.directions_railway),
  Choice('WALK', Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  // 매개변수 주변에 {}가 있기 때문에 text와 icon이라는 매개변수 이름을 함께 사용해야 한다.
  const ChoiceCard({Key key, this.text, this.icon}) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // 아이콘과 텍스트 양쪽에서 사용하기 위해 별도 변수로 처리
    final TextStyle textStyle = Theme.of(context).textTheme.display3;
    return Card(
      child: Column(
        children: <Widget>[
          // 아이콘이 위쪽, 문자열이 아래쪽.
          Icon(icon, size: 128.0, color: textStyle.color),
          Text(text, style: textStyle),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      color: Colors.green,
      margin: EdgeInsets.all(12),
    );
  }
}
