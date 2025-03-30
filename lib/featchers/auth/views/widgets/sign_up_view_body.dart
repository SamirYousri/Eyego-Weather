import 'package:eyego_task/core/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:eyego_task/core/utils/functions/custom_snack_bar.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/custom_text_form_field.dart';
import 'package:eyego_task/featchers/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:eyego_task/featchers/auth/views/signIn_view.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          customSnackBar(context, 'Account created successfully.');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInView()),
          );
        } else if (state is SignUpFailure) {
          customSnackBar(context, state.errMessage);
        }
      },
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SignUpLoading,
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
                        const Text('SIGN UP', style: Styles.textStyle25),
                        const SizedBox(height: 30),
                        CustomTextFormField(
                          icon: Icons.person,
                          labelText: 'Full Name',
                        ),
                        const SizedBox(height: 15),
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
                          onPressed: () => _signUp(context),
                          textButton: 'SIGN UP',
                          width: double.infinity,
                          hight: 50,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInView()),
                          ),
                          child: const Text(
                            'Have an account?',
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

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Hide keyboard
      context.read<SignUpCubit>().signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }
}
