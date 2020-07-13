import 'package:flutter/material.dart';
import 'Alarm.dart';

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
      drawer: Drawer(
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
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'Computer',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'Clothes',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'Food',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'Quick',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'Book',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'gifticon',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outline_blank,
                color: Colors.teal,
              ),
              title: Text(
                'CarFul',
                style: TextStyle(
                    fontSize: 15.0, backgroundColor: Colors.greenAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: TabBarView(
        // map과 toList 함수를 연결해서 화면 리스트 전달
        children: choices.map((Choice choice) {
          // 문자열과 아이콘을 모두 포함하는 위젯 객체 생성
          // 이전 코드에서는 Text 위젯 하나만 사용했었다. 코드가 많아 클래스로 분리.
          return ChoiceCard(
            // 생성자에서 {}를 사용했기 때문에 text와 icon 매개변수 이름 사용 필수
            text: choice.text,
            icon: choice.icon, // 이전 코드와 다른 부분
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
