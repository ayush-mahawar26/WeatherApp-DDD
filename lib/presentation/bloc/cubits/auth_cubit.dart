import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ddd/application/usecases/auth_usecase.dart';
import 'package:weather_ddd/presentation/bloc/states/auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthUseCase authUseCase;
  AuthCubit({required this.authUseCase}) : super(AuthInitialState());

  void signUpUser(String email, String pass) async {
    emit(AuthLoadingState());
    try {
      User? user = await authUseCase.signUpUser(email, pass);
      if (user != null) {
        emit(AuthDoneState(user: user));
      } else {
        emit(AuthErrorState(err: "User is null"));
      }
    } catch (e) {
      emit(AuthErrorState(err: e.toString()));
    }
  }

  void signInUser(String email, String pass) async {
    emit(AuthLoadingState());
    try {
      User? user = await authUseCase.signInUser(email, pass);
      if (user != null) {
        emit(AuthDoneState(user: user));
      } else {
        emit(AuthErrorState(err: "User is null"));
      }
    } catch (e) {
      emit(AuthErrorState(err: e.toString()));
    }
  }

  void signOut() async {
    authUseCase.signout();
  }
}
