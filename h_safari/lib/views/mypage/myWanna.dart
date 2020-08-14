import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class myWanna extends StatefulWidget {
  @override
  _myWannaState createState() => _myWannaState();
}

class _myWannaState extends State<myWanna> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myPostAppBar(context, '거래신청한 게시글', '판매중', '마감'),
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
