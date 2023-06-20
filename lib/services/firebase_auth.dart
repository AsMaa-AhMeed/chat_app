import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerUser({String? email, String? password}) async {
  UserCredential user = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email!, password: password!);
}

Future<void> signInUser({String? email, String? password}) async {
  UserCredential user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email!, password: password!);
}
