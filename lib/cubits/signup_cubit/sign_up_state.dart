part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

// ignore: must_be_immutable
class SignUpFailure extends SignUpState {
  String errMessage;
  SignUpFailure({required this.errMessage});
}
