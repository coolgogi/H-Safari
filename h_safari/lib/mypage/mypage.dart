import 'package:flutter/material.dart';
import 'package:h_safari/mypage/setting.dart';
import 'package:h_safari/mypage/terms_of_use.dart';
import 'modifyprofile.dart';
//from SH
import '../firebase/firebase_provider.dart';
import 'package:provider/provider.dart';
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class MyPage extends StatelessWidget {

  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

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
                        padding: const EdgeInsets.fromLTRB(10,25,20,20),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg'),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('닉네임',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Text(
                          '야옹이',
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ModifyProfile()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.build),
                  title: Text('환경 설정'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Setting()));
                  },
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
                  }
                ),
              ],
            ),
        ),
        );
  }
}
