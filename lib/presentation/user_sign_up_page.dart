import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_sign_up/user_sign_up_bloc.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/components/login_signup_components/rich_text_widget.dart';
import 'package:talk_a_tive/presentation/components/snackbar_widget.dart';
import 'package:talk_a_tive/presentation/user_login_page.dart';
import '../core/app_colors.dart';
import '../core/sizes.dart';
import 'components/login_signup_components/login_button_widget.dart';
import 'components/login_signup_components/login_text_form_widget.dart';

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
        body: BlocListener<UserSignUpBloc, UserSignUpState>(
          listener: (context, state) {
            if (state.userSignupData?.status == Status.error) {
              SnackBarWidget.flushbar(
                context: context,
                message: state.userSignupData!.message!,
              );
            }
          },
          child: BlocBuilder<UserSignUpBloc, UserSignUpState>(
            builder: (context1, state) {
              return SafeArea(
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
                              child: GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 49,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage:
                                      const AssetImage("assets/no_user.jpg"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Positioned(
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
                              onPressed: () {
                                BlocProvider.of<UserSignUpBloc>(context).add(
                                  UserSignUp(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    picture: "",
                                  ),
                                );
                              },
                            ),
                            AppSizes.height20,
                            RichTextWidget(
                              leftText: "Already",
                              rightText: "Login",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserLoginPage(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        AppSizes.height30
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
