import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_login/user_login_bloc.dart';
import 'package:talk_a_tive/core/sizes.dart';
import 'package:talk_a_tive/presentation/home_page.dart';
import 'components/login_text_form_widget.dart';

class UserLoginPage extends StatelessWidget {
  UserLoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<UserLoginBloc>(context, listen: false).add(
                      UserLogin(
                        email: emailController.text.trim(),
                        passoword: passwordController.text.trim(),
                      ),
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(elevation: 0),
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
