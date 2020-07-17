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
  name: 'Nick Fury',
  image: 'assets/images/nick-fury.jpg',
);

// USERS
final User cat = User(
  id: 1,
  name: '야옹이',
  image: 'http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg',
);
final User captainAmerica = User(
  id: 2,
  name: 'Captain America',
  image: 'assets/images/captain-america.jpg',
);
final User hulk = User(
  id: 3,
  name: 'Hulk',
  image: 'assets/images/hulk.jpg',
);