import 'package:flutter/material.dart';
import 'package:h_safari/views/mypage/terms_of_use.dart';
import 'package:firebase_auth/firebase_auth.dart';

//from SH
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  FirebaseProvider fp ;

  String current_uid;
  String current_email ;

  @override
  void initState() {
    super.initState();
//    _prepareService();
  }



  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    FirebaseUser current_user = fp.getUser();
    current_email = current_user.email;
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.cake),
        title: Text('MyPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 20, 20),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('email',
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(
                      '$current_email',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                      height: 30,
                      child: RawMaterialButton(
                        child: Icon(
                          Icons.border_color,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('환경 설정'),
            ),
            ListTile(
              leading: Icon(Icons.filter_frames),
              title: Text('이용 약관'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Terms()));
              },
            ),
            ListTile(
                leading: Icon(Icons.accessibility),
                title: Text('로그아웃'),
                onTap: () {
                  fp.signOut();
                }),
          ],
        ),
      ),
    );
  }
}

