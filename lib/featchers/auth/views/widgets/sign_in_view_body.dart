// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:eyego_task/core/utils/functions/custom_snack_bar.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/custom_text_form_field.dart';
import 'package:eyego_task/core/widgets/CustomButton.dart';
import 'package:eyego_task/featchers/auth/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:eyego_task/featchers/home/views/search_view.dart';
import 'package:eyego_task/featchers/auth/views/signUp_view.dart';

class SignInViewBody extends StatelessWidget {
  SignInViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          customSnackBar(context, 'Success.');
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SearchView()),
            );
          }
        } else if (state is SignInFailure) {
          customSnackBar(context, state.errMessage);
        }
      },
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall:
                state is SignInLoading, // يتم تحديث الحالة بناءً على Cubit
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Eyego Weather', style: Styles.textStyle35),
                        const SizedBox(height: 50),
                        const Text('SIGN IN', style: Styles.textStyle25),
                        const SizedBox(height: 30),
                        CustomTextFormField(
                          controller: _emailController,
                          icon: Icons.email,
                          labelText: 'Email',
                        ),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: _passwordController,
                          icon: Icons.lock,
                          labelText: 'Password',
                          isHide: true,
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          onPressed: () => _signIn(context),
                          textButton: 'SIGN IN',
                          width: double.infinity,
                          hight: 50,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpView()),
                          ),
                          child: const Text(
                            "Don't have an account?",
                            style: Styles.textStyle12UnderLine,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignInCubit>().signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }
}
