import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class myPost extends StatefulWidget {
  @override
  _myPostState createState() => _myPostState();
}

class _myPostState extends State<myPost> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myPostAppBar(context, '내가 쓴 게시글', '판매중', '마감'),
        body : TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
