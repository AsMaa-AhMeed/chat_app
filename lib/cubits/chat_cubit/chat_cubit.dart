import 'package:bloc/bloc.dart';
import 'package:chat_app_2/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  List<MessageModel> messageList = [];
  void sendMessage({required String message, required String email}) {
    messages
        .add({'message': message, 'createdAt': DateTime.now(), 'id': email});
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messageList: messageList));
    });
  }
}
