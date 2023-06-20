import 'package:chat_app_2/helper/show_snack_bar.dart';
import 'package:chat_app_2/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/components.dart';
import '../services/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  static String id = '/signUpRoute';

  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Lottie.network(
                          'https://assets5.lottiefiles.com/packages/lf20_zw0djhar.json',
                          height: 250),
                      Text('SIGN UP',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.blue)),
                      const SizedBox(height: 14),
                      CustomTextFormField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(height: 14),
                      CustomTextFormField(
                        hintText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (data) {
                          password = data;
                        },
                      ),
                      const SizedBox(height: 14),
                      CustomTextButton(
                        data: 'Sign up',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await registerUser(
                                  email: email, password: password);
                              Navigator.pushNamed(context, ChatScreen.id);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnackBar(context,
                                    'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(context, 'Email already in use.');
                              }
                            } catch (e) {
                              showSnackBar(context, 'There was an error!.');
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?  '),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.blue)),
                          ),
                        ],
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
