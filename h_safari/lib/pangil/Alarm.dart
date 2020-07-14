import 'package:flutter/material.dart';

import 'ScreenA.dart';
import 'package:flutter/cupertino.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alarm'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                background: Container(color : Colors.red),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction){
                  setState(() {
                    if (direction == DismissDirection.startToEnd) {
                      items.removeAt(index);
                    }
                  });
                },
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.person, color: Colors.lightBlueAccent,),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${items[index]}', style: TextStyle(fontSize: 20),),
                          Text('Send to me. my name is kim kwang il. I wanna see you!', style: TextStyle(fontSize: 10, color: Colors.black12),),
                        ],
                      )
                    ],
                  ),
                  ),
                key: Key(item),
              );
            }));
  }
}