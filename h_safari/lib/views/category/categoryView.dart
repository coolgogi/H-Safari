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
  Widget appBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.green[100],
      leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.green,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search, color : Colors.green),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
            }
        ),
      ],
      title: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Center(
            child: Text(
              '$title',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('$select'),
    );
  }
}
