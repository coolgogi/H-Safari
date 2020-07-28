import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';

class categoryView extends StatefulWidget {
  final String select;
  categoryView({this.select});

  @override
  _categoryViewState createState() => _categoryViewState(select : select);
}

class _categoryViewState extends State<categoryView> {
  final String select;
  _categoryViewState({this.select});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('$select'),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                }
            ),
          ],
        ),
      ),
    );
  }
}
