import 'package:flutter/material.dart';

import '../consts.dart';
import '../model/massages.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(37),
            topRight: Radius.circular(37),
            bottomRight: Radius.circular(37),
            bottomLeft: Radius.circular(0),
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFrind extends StatelessWidget {
  ChatBubleForFrind({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(37),
            topRight: Radius.circular(37),
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(37),
          ),
        ),
      ),
    );
  }
}
