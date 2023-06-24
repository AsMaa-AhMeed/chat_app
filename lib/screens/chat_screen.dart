import 'package:chat_app_2/components/chat_buble.dart';
import 'package:chat_app_2/components/chat_buble_for_friend.dart';
import 'package:chat_app_2/components/components.dart';
import 'package:chat_app_2/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app_2/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static String id = '/chatRoute';

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
//  List<MessageModel> messageList = [];
  String? message;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          //    automaticallyImplyLeading: false,
          backgroundColor: ColorManager.lightBlue,
          centerTitle: true,
          title: const Text('Chat App'),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  var messagesList =
                      BlocProvider.of<ChatCubit>(context).messageList;
                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatForFriendBuble(message: messagesList[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: data, email: "$email");
                    controller.clear();
                    _scrollController.animateTo(
                      //   _controller.position.maxScrollExtent,
                      0,
                      curve: Curves.easeIn,
                      duration: const Duration(microseconds: 500),
                    );
                  },
                  onChanged: (data) {
                    message = data;
                  },
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: ColorManager.lightBlue,
                      ),
                      onPressed: () {
                        BlocProvider.of<ChatCubit>(context)
                            .sendMessage(message: message!, email: "$email");
                        controller.clear();
                        _scrollController.animateTo(
                          //   _controller.position.maxScrollExtent,
                          0,
                          curve: Curves.easeIn,
                          duration: const Duration(microseconds: 500),
                        );
                      },
                    ),
                    border: buildBorder(),
                    enabledBorder: buildBorder(),
                    focusedBorder: buildBorder(),
                  )),
            )
          ],
        ));
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorManager.lightBlue));
  }
}
