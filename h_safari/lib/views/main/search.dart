import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/helpers/bottombar.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _blankFocusnode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.cake,
            color: Colors.green,
          ),
            onPressed: () {
              Navigator.pop(context);
            },
      ),
        title: SearchBar(),


      );
    }
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar(),
        body : GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_blankFocusnode);
          }
        )
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 35,
        decoration: BoxDecoration(
        color : Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(15))
        ),

      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(

          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search your world',
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {

                },
              )),
        ),
      ),
    );
  }
}

