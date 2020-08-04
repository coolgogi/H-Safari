import 'package:flutter/material.dart';
import 'package:h_safari/views/chat/chatRoom.dart';
import 'package:h_safari/views/post/write.dart';
import '../main/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chat/database.dart';
import 'package:intl/intl.dart';
import 'package:h_safari/widget/widget.dart';

class MyPost extends StatefulWidget {
  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내꺼 게시글 임시'),
      ),
    );
  }
}
