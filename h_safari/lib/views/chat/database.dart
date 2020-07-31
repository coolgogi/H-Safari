import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
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

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('date')
        .snapshots();
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

  getUserChats(String itIsMyName) async {
    return Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .orderBy('lastDate', descending: true)
        .snapshots();
  }

  getUserAlarms(String name) async {
    return Firestore.instance
        .collection("users")
        .document(name)
        .collection("alert")
        .snapshots();
  }

  updateLast(String chatRoomId, String message, String date, String sendBy, bool unread) {
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

  updateUnread(String chatRoomId) {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .updateData({
      'unread': false,
    });
  }
}
