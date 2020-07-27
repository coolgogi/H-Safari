class User {
  final int id;
  final String name;
  final String image;

  User({
    this.id,
    this.name,
    this.image,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'yejin',
);

// USERS
final User cat = User(
  id: 1,
  name: '야옹이',
  image: 'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg',
);
final User dog = User(
  id: 2,
  name: '댕댕',
  image: 'https://t1.daumcdn.net/cfile/tistory/216E644056F1226F34',
);
final User pig = User(
  id: 3,
  name: '미니피그',
  image: 'https://i.pinimg.com/474x/a9/49/c8/a949c849550c61a7f9837ddbf9e2d842.jpg',
);