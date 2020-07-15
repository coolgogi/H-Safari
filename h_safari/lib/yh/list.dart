import 'package:flutter/material.dart';
import 'post.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('H-Safari'),
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }
}
