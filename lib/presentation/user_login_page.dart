import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_login/user_login_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/core/sizes.dart';
import 'package:talk_a_tive/presentation/home_page.dart';
import 'package:talk_a_tive/presentation/user_sign_up_page.dart';
import 'components/login_button_widget.dart';
import 'components/login_text_form_widget.dart';

class UserLoginPage extends StatelessWidget {
  UserLoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  AppSizes.height10,
                  LoginButton(
                    text: "Login",
                    onPressed: () {
                      BlocProvider.of<UserLoginBloc>(context, listen: false)
                          .add(
                        UserLogin(
                          email: emailController.text.trim(),
                          passoword: passwordController.text.trim(),
                        ),
                      );

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
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
                              text: 'Don\'t have an account? ',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                            TextSpan(
                              text: 'Sign in',
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserSignupPage(),
                                  ));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
