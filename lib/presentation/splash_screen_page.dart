import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_a_tive/presentation/home_chat_list_page.dart';
import 'package:talk_a_tive/presentation/user_login_page.dart';

import '../core/global_keys.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AnimatedSplashScreen(
            splashIconSize: 300,
            splash: Padding(
              padding: const EdgeInsets.all(50.0),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/Talkative_logo.png",
                ),
              ),
            ),
            nextScreen: snapshot.data!,
          );
        },
      ),
    );
  }
}

Future<Widget> loginStatus() async {
  try {
    final status = await SharedPreferences.getInstance();
    final userLoggedIn = status.getBool(GlobalKeys.userLoginKey) ?? false;
    log("message $userLoggedIn");
    if (userLoggedIn == false) {
      return UserLoginPage();
    } else {
      return const HomePage();
    }
  } catch (e) {
    return UserLoginPage();
  }
}
