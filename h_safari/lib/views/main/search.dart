// 기본 import
import 'package:flutter/material.dart';

// widget import
import 'package:h_safari/widget/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _blankFocusnode = new FocusNode();

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBarSearch(context),
        body : GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_blankFocusnode);
          }
        )
      ),
    );
  }
}


