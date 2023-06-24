part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

// ignore: must_be_immutable
class ChatSuccess extends ChatState {
  List<MessageModel> messageList;

  ChatSuccess({required this.messageList});
}
