import 'user_model.dart';

class Message {
  final User sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: cat,
    time: '5:30 PM',
    text: 'Hey dude! Even dead I\'m the hero. Love you 3000 guys.',
    unread: true,
  ),
  Message(
    sender: captainAmerica,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: hulk,
    time: '1:30 PM',
    text: 'HULK SMASH!!',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: cat,
    time: '5:30 PM',
    text: '안녕하세요! 제가 올린 물품의 거래를 희망하신다 하셔서 연락드립니다~!',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: '네 안녕하세요!! 거래 희망합니다~!',
    unread: true,
  ),
  Message(
    sender: cat,
    time: '3:45 PM',
    text: '네! 정보는 게시글에 있는 그대로이고, 직거래와 택배 모두 가능한데 어떤게 편하신가요?',
    unread: true,
  ),
  Message(
    sender: cat,
    time: '3:15 PM',
    text: '아, 만약 택배면 택배비는 구매자님께서 부담하셔야합니다!',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: '네네! 택배로 할게요, 제가 지금 집에 와있어서요~!',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: '집 주소는 ~~~~입니다!',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: '그럼 택배비까지 합쳐서 물건값이랑 값이 보내드리겠습니다.',
    unread: true,
  ),
  Message(
    sender: cat,
    time: '2:00 PM',
    text: '네 알겠습니다! 구매해주셔서 감사합니다!!',
    unread: true,
  ),
];