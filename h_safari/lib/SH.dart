//누가 : 수현
//언제 : 2020-07-13
//main을 하나로 쓰면 충돌이 많이 나서 각자 main을 만들어주기로 했음, 여러분들 페이지를 합친걸
//다른걸 만들면 지저분해질까봐 여기에 두고 확인하기로 했습니다.

import 'package:flutter/material.dart';

import 'SH/chat_main.dart';
import 'SH/views/chatrooms.dart';


class sh_main extends StatefulWidget {
  @override
  _sh_mainState createState() => _sh_mainState();
}

class _sh_mainState extends State<sh_main> {
  @override
  Widget build(BuildContext context) {
    return ChatRoom();
  }
}
