import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_functions/cloud_functions.dart';

class DatabaseMethods {

  final HttpsCallable sendFCM = CloudFunctions.instance
      .getHttpsCallable(functionName: 'sendFCM') // 호출할 Cloud Functions 의 함수명
    ..timeout = const Duration(seconds: 30); // 타임아웃 설정(옵션)



  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserData(String email) async {
    return Firestore.instance
        .collection("users")
        .where("user", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<dynamic> getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('date', descending: true)
        .snapshots();
  }

  deleteChatRoom(String docID) {
    Firestore.instance.collection('chatRoom').document(docID).delete();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getComments(String docId) async {
    return Firestore.instance
        .collection("post")
        .document(docId)
        .collection("comments")
        .orderBy('date')
        .snapshots();
  }

  getReComments(String docId, String redocId) async {
    print(redocId);
    return Firestore.instance
        .collection("post")
        .document(docId)
        .collection("comments")
        .document(redocId)
        .collection("recomments")
        .orderBy('date')
        .snapshots();
  }

  Future<void> addComment(String docId, commentData) {
    Firestore.instance
        .collection("post")
        .document(docId)
        .collection("comments")
        .add(commentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addReComment(String docId, String redocId, commentData) {
    Firestore.instance
        .collection("post")
        .document(docId)
        .collection("comments")
        .document(redocId)
        .collection("recomments")
        .add(commentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteComment(String docID, String codocId) {
    Firestore.instance
        .collection('post')
        .document(docID)
        .collection('comments')
        .document(codocId)
        .delete();
  }

  deleteReComment(String docID, String codocId, String recodocId) {
    Firestore.instance
        .collection('post')
        .document(docID)
        .collection('comments')
        .document(codocId)
        .collection('recomments')
        .document(recodocId)
        .delete();
  }

  Future<dynamic> getUserChats(String itIsMyName) async {
    return Firestore.instance
        .collection("chatRoom")
        .orderBy('lastDate', descending: true)
        .snapshots();
  }

  getUserAlarms(String name) async {
    return Firestore.instance
        .collection("users")
        .document(name)
        .collection("notification")
        .orderBy('time', descending: true)
        .snapshots();
  }

  getWaitingList(String documentID) async {
    return Firestore.instance
        .collection("post")
        .document(documentID)
        .collection("userList")
        .orderBy('time', descending: true)
        .snapshots();
  }

  updateLast(String chatRoomId, String message, String date, String sendBy,
      bool unread) {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .updateData({
      'lastMessage': message,
      'lastDate': date,
      'lastSendBy': sendBy,
      'unread': true,
    });
  }

  updateUnreadMessagy(String chatRoomId) {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .updateData({
      'unread': false,
    });
  }

  updateUnreadAlram(String myEmail, String documentID) {
    return Firestore.instance
        .collection("users")
        .document(myEmail)
        .collection("notification")
        .document(documentID)
        .updateData({
      'unread': false,
    });
  }

  closePost(String docId) {
    return Firestore.instance.collection("post").document(docId).updateData({
      'close': true,
    });
  }

  void sendNotification(String userId, commentNotification) {
    Firestore.instance
        .collection("users")
        .document(userId)
        .collection("notification")
        .add(commentNotification)
        .catchError((e) {
      print(e.toString());
    });
    sendMessage(userId);
  }

  addWant(String email, String docId, userList) {
    Firestore.instance
        .collection("post")
        .document(docId)
        .collection("userList")
        .add(userList)
        .catchError((e) {
      print(e.toString());
    });
  }

  updatePostDoc(String docID, String name, String price, String description,
      String category, String how) {
    Firestore.instance.collection('post').document(docID).updateData({
      "name": name,
      "price": price,
      "description": description,
      "category": category,
      "how": how,
    });
  }

  deletePostDoc(BuildContext context, String docID) {
    Firestore.instance.collection('post').document(docID).delete();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void sendMessage(String userEmail){
    Firestore.instance
        .collection("users")
        .document(userEmail)
        .get()
        .then((doc){
      sendSampleFCM(doc["token"]);
    });
  }

  void sendSampleFCM(String token) async {
    final HttpsCallableResult result = await sendFCM.call(
      <String, dynamic>{
        "token": token,
        "title": "구매신청입니다",
        "body": "누군가가 구매신청을 했습니다\n 알림을 확인하세요!"
      },
    );
  }


}
