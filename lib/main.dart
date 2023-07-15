import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_login/user_login_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_sign_up/user_sign_up_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/presentation/splash_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLoginBloc>(
          create: (context) => UserLoginBloc(),
        ),
        BlocProvider<UserSignUpBloc>(
          create: (context) => UserSignUpBloc(),
        ),
        BlocProvider<HomeChatListBloc>(
          create: (context) => HomeChatListBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Talk-A-Tive chat app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.primary),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            iconTheme: IconThemeData(color: AppColors.white),
            titleTextStyle: TextStyle(
              color: AppColors.black,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
            elevation: 0,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
