import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> registerUser({required String email,required String password}) async {
    emit(SignUpLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(errMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {}
      emit(SignUpFailure(errMessage: 'email-already-in-use'));
    } catch (e) {
      emit(SignUpFailure(errMessage: "something went wrong"));
    }
  }
}
