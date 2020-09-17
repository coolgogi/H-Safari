import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_functions/cloud_functions.dart';

class DatabaseMethods {
  final HttpsCallable sendFCM = CloudFunctions.instance
      .getHttpsCallable(functionName: 'sendFCM') // 호출할 Cloud Functions 의 함수명
        ..timeout = const Duration(seconds: 30); // 타임아웃 설정(옵션)

  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserData(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("user", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  // Future<bool> addChatRoom(chatRoom, chatRoomId) {
  void addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<dynamic> getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('date', descending: true)
        .snapshots();
  }

  deleteChatRoom(String docID) {
    FirebaseFirestore.instance.collection('chatRoom').doc(docID).delete();
  }

  // Future<void> addMessage(String chatRoomId, chatMessageData) {
  void addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getComments(String docId) async {
    return FirebaseFirestore.instance
        .collection("post")
        .doc(docId)
        .collection("comments")
        .orderBy('date')
        .snapshots();
  }

  getReComments(String docId, String redocId) async {
    print(redocId);
    return FirebaseFirestore.instance
        .collection("post")
        .doc(docId)
        .collection("comments")
        .doc(redocId)
        .collection("recomments")
        .orderBy('date')
        .snapshots();
  }

  // Future<void> addComment(String docId, commentData) {
  void addComment(String docId, commentData) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(docId)
        .collection("comments")
        .add(commentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // Future<void> addReComment(String docId, String redocId, commentData) {
  void addReComment(String docId, String redocId, commentData) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(docId)
        .collection("comments")
        .doc(redocId)
        .collection("recomments")
        .add(commentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteComment(String docID, String codocId) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(docID)
        .collection('comments')
        .doc(codocId)
        .delete();
  }

  deleteReComment(String docID, String codocId, String recodocId) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(docID)
        .collection('comments')
        .doc(codocId)
        .collection('recomments')
        .doc(recodocId)
        .delete();
  }

  Future<dynamic> getUserChats(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .orderBy('lastDate', descending: true)
        .snapshots();
  }

  getUserAlarms(String name) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(name)
        .collection("notification")
        .orderBy('time', descending: true)
        .snapshots();
  }

  getWaitingList(String documentID) async {
    return FirebaseFirestore.instance
        .collection("post")
        .doc(documentID)
        .collection("userList")
        .orderBy('time', descending: true)
        .snapshots();
  }

  updateLast(String chatRoomId, String message, String date, String sendBy,
      bool unread) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .update({
      'lastMessage': message,
      'lastDate': date,
      'lastSendBy': sendBy,
      'unread': true,
    });
  }

  updateUnreadMessagy(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .update({
      'unread': false,
    });
  }

  updateUnreadAlram(String myEmail, String documentID) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(myEmail)
        .collection("notification")
        .doc(documentID)
        .update({
      'unread': false,
    });
  }

  closePost(String docId) {
    return FirebaseFirestore.instance.collection("post").doc(docId).update({
      'close': true,
    });
  }

  void sendNotification(String userId, commentNotification) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("notification")
        .add(commentNotification)
        .catchError((e) {
      print(e.toString());
    });
    sendMessage(userId, commentNotification["type"]);
  }

  updateUnreadNotification(String myEmail, how) {
    return FirebaseFirestore.instance.collection("users").doc(myEmail).update({
      'unreadNotification': how,
    });
  }

  addWant(String email, String docId, userList) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(docId)
        .collection("userList")
        .add(userList)
        .catchError((e) {
      print(e.toString());
    });
  }

  updatePostDoc(String docID, String name, String price, String description,
      String imageList, String category, String how) {
    List<String> splitString = imageList.split('우주최강CRA');

    FirebaseFirestore.instance.collection('post').doc(docID).update({
      "name": name,
      "description": description,
      "price": price,
      "imageUrl": splitString[0],
      "imageList": splitString,
      "category": category,
      "how": how,
    });
  }

  deletePostDoc(BuildContext context, String docID) {
    FirebaseFirestore.instance.collection('post').doc(docID).delete();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void sendMessage(String userEmail, String type) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .get()
        .then((doc) {
      sendSampleFCM(doc.get("token"), type);
    });
  }

  void sendSampleFCM(String token, String type) async {
    // final HttpsCallableResult result = await sendFCM.call(
    await sendFCM.call(
      <String, dynamic>{"token": token, "title": type, "body": "알림을 확인하세요!"},
    );
  }
}
