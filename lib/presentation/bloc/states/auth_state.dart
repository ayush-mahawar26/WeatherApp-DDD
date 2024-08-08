import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthDoneState extends AuthStates {
  User user;
  AuthDoneState({required this.user});
}

class AuthErrorState extends AuthStates {
  String err;
  AuthErrorState({required this.err});
}
