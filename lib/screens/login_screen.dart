import 'package:chat_app_2/cubits/Login_cubit/login_cubit.dart';
import 'package:chat_app_2/helper/show_snack_bar.dart';
import 'package:chat_app_2/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/components.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  String? email;
  String? password;
  bool isLoading = false;
  static String id = '/loginRoute';
  GlobalKey<FormState> formKey = GlobalKey();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
           isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
           isLoading = false;
        }
      },
      builder: (context, state) =>  ModalProgressHUD(
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
                              BlocProvider.of<LoginCubit>(context).signInUser(
                                  email: email!, password: password!);
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
      ),
    );
  }
}
