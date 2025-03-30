import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(SignInFailure(errMessage: 'No user found for that email.'));
          break;
        case 'wrong-password':
          emit(SignInFailure(
              errMessage: 'Wrong password provided for that user.'));
          break;
        case 'invalid-email':
          emit(SignInFailure(
              errMessage: 'The email address is badly formatted.'));
          break;
        case 'invalid-credential':
          emit(SignInFailure(
              errMessage: 'Incorrect email or password. Please try again.'));
          break;
        default:
          emit(SignInFailure(
              errMessage:
                  e.message ?? 'Authentication failed. Please try again.'));
          break;
      }
    } catch (e) {
      emit(SignInFailure(
          errMessage:
              'Something went wrong. Please check your connection and try again.'));
    }
  }
}
