import 'package:eyego_task/core/utils/constant.dart';
import 'package:eyego_task/featchers/auth/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:eyego_task/featchers/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:eyego_task/featchers/auth/views/signIn_view.dart';
import 'package:eyego_task/featchers/home/manager/weather_cubit/weather_cubit.dart';
import 'package:eyego_task/featchers/home/service/weather_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(EyegoWeather());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class EyegoWeather extends StatelessWidget {
  const EyegoWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
        BlocProvider(
          create: (context) => WeatherCubit(WeatherService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
        ),
        home: const SignInView(),
      ),
    );
  }
}
