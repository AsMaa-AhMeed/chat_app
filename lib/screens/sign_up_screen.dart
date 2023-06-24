import 'package:chat_app_2/cubits/signup_cubit/sign_up_cubit.dart';
import 'package:chat_app_2/helper/show_snack_bar.dart';
import 'package:chat_app_2/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/components.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  String? email;
  String? password;
  bool isLoading = false;
  static String id = '/signUpRoute';
  GlobalKey<FormState> formKey = GlobalKey();

  SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        } else if (state is SignUpFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                          const SizedBox(height: 60),
                          Lottie.network(
                              'https://assets5.lottiefiles.com/packages/lf20_zw0djhar.json',
                              height: 250),
                          const SizedBox(height: 40),
                          Text('SIGN UP',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.blue)),
                          const SizedBox(height: 14),
                          CustomTextFormField(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.person_outlined),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (data) {
                              email = data;
                            },
                          ),
                          const SizedBox(height: 14),
                          CustomTextFormField(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_rounded),
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_outlined),
                            obscureText: true,
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
                                BlocProvider.of<SignUpCubit>(context)
                                    .registerUser(
                                        email: email!, password: password!);
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
      },
    );
  }
}
