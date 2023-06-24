part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

// ignore: must_be_immutable
class LoginFailure extends LoginState {
  String errMessage;
  LoginFailure({required this.errMessage});
}
