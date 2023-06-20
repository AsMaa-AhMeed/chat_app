import 'package:chat_app_2/helper/show_snack_bar.dart';
import 'package:chat_app_2/screens/screens.dart';
import 'package:chat_app_2/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/components.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/loginRoute';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Lottie.network(
                          'https://assets8.lottiefiles.com/private_files/lf30_iraugwwv.json',
                          height: 300),
                      Text('LOGIN',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.blue)),
                      const SizedBox(height: 14),
                      CustomTextFormField(
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),
                      CustomTextFormField(
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 14),
                      CustomTextButton(
                        data: 'Login',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await signInUser(
                                  email: email, password: password);
                              Navigator.pushNamed(context, ChatScreen.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnackBar(
                                    context, 'No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                showSnackBar(context, 'Wrong password.');
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
                          const Text('Don\'t have an account?  '),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, SignupScreen.id);
                            },
                            child: Text('Register',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.blue)),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
