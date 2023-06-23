import 'package:chat_app_2/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatForFriendBuble extends StatelessWidget {
  final MessageModel message;
  const ChatForFriendBuble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // padding:
        //     const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
