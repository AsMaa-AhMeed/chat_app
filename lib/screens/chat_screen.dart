import 'package:chat_app_2/components/chat_buble.dart';
import 'package:chat_app_2/components/chat_buble_for_friend.dart';
import 'package:chat_app_2/components/components.dart';
import 'package:chat_app_2/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
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
                    
                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBuble(
                                  message: messageList[index],
                                )
                              : ChatForFriendBuble(message: messageList[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                          controller: controller,
                          onFieldSubmitted: (data) {
                            messages.add({
                              'message': data,
                              'createdAt': DateTime.now(),
                              'id': email
                            });
                            controller.clear();
                            _scrollController.animateTo(
                              //   _controller.position.maxScrollExtent,
                              0,
                              curve: Curves.easeIn,
                              duration: const Duration(microseconds: 500),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: ColorManager.lightBlue,
                              ),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: ColorManager.lightBlue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: ColorManager.lightBlue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: ColorManager.lightBlue)),
                          )),
                    )
                  ],
                ));
          } else {
            return const Scaffold(
                body: SafeArea(child: Center(child: Text('Loading ...'))));
          }
        });
  }
}
