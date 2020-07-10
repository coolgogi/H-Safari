import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin  {

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
                  print('shopping cart button is clicked');
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),

          ],
        ),
      ),
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
