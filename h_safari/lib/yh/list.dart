import 'package:flutter/material.dart';
import 'post.dart';
import '../firebase/firebase_provider.dart';
import 'package:provider/provider.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

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
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RaisedButton(
                  color: Colors.indigo[300],
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    fp.signOut();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
