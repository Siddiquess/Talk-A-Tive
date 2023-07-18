import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_login/user_login_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/core/sizes.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/components/snackbar_widget.dart';
import 'package:talk_a_tive/presentation/home_chat_list_page.dart';
import 'package:talk_a_tive/presentation/user_sign_up_page.dart';
import 'components/login_signup_components/login_button_widget.dart';
import 'components/login_signup_components/rich_text_widget.dart';
import 'components/login_signup_components/login_text_form_widget.dart';

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
        backgroundColor: AppColors.scaffoldColor,
        body: BlocListener<UserLoginBloc, UserLoginState>(
          listener: (context, state) {
            if (state.userLoginData?.status == Status.success) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  HomePage(),
                ),
              );
            }
            if (state.userLoginData?.status == Status.error) {
              SnackBarWidget.flushbar(
                context: context,
                message: state.userLoginData!.message!,
              );
            }
          },
          child: BlocBuilder<UserLoginBloc, UserLoginState>(
            builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Talkative_logo.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Column(
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
                            AppSizes.height30,
                            LoginButton(
                              isLoading:
                                  state.userLoginData?.status == Status.loading,
                              text: "Login",
                              onPressed: () {
                                BlocProvider.of<UserLoginBloc>(context).add(
                                  UserLogin(
                                    email: emailController.text.trim(),
                                    passoword: passwordController.text.trim(),
                                  ),
                                );
                              },
                            ),
                            AppSizes.height20,
                            RichTextWidget(
                              leftText: "Don't",
                              rightText: "Sign up",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserSignupPage(),
                                  ),
                                );
                                if (state.userLoginData?.status ==
                                    Status.success) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>  HomePage(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        AppSizes.height30,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
