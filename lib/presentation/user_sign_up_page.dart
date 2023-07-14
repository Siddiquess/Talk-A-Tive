import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talk_a_tive/presentation/user_login_page.dart';
import '../core/app_colors.dart';
import '../core/sizes.dart';
import 'components/login_button_widget.dart';
import 'components/login_text_form_widget.dart';

class UserSignupPage extends StatelessWidget {
  UserSignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade600,
                        child: CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: const AssetImage("assets/no_user.jpg"),
                        ),
                      ),
                      const Positioned(
                        bottom: 7,
                        right: 1,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.black,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: AppColors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      LoginTextFieldWidget(
                        controller: nameController,
                        icons: Icons.person,
                        labelText: "username",
                      ),
                      LoginTextFieldWidget(
                        controller: emailController,
                        icons: Icons.email,
                        labelText: "email",
                      ),
                      LoginTextFieldWidget(
                        controller: passwordController,
                        icons: Icons.lock,
                        labelText: "password",
                      ),
                      AppSizes.height30,
                      LoginButton(
                        text: "Sign up",
                        onPressed: () {},
                      ),
                      AppSizes.height20,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 15),
                                ),
                                TextSpan(
                                  text: 'Login',
                                  style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UserLoginPage(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSizes.height30
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
