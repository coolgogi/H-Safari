import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class asking extends StatefulWidget {
  @override
  _askingState createState() => _askingState();
}

class _askingState extends State<asking> {
  List<String> attachments = [];
  bool isHTML = false;

  final _subjectController = TextEditingController(
    text: null,
  );

  final _bodyController = TextEditingController(
    text: null,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      recipients: ['handongsafari@gmail.com'],
      body: _bodyController.text,
      subject: _subjectController.text,
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  var _blankFocusnode = new FocusNode(); //키보드 없애는 용

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocusnode);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.green),
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
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
            centerTitle: true,
            title: Text(
              '문의하기',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: send,
                icon: Icon(
                  Icons.send,
                  color: Colors.green,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '제목',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _bodyController,
                      maxLines: 10,
                      maxLength: 1000,
                      decoration: InputDecoration(
                          labelText: '문의내용', border: OutlineInputBorder()),
                    ),
                  ),
                  ...attachments.map(
                    (item) => Text(
                      item,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.green,
            icon: Icon(Icons.camera),
            label: Text('사진 첨부'),
            onPressed: _openImagePicker,
          ),
        ),
      ),
    );
  }

  void _openImagePicker() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      attachments.add(pick.path);
    });
  }
}
