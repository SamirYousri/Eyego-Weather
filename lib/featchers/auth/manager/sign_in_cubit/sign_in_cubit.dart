// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> SignIn({required String email, required String password}) async {
    emit(SignInLoading());

    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailure(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SignInFailure(
            errMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(SignInFailure(errMessage: 'Something went wrong'));
    }
  }
}
