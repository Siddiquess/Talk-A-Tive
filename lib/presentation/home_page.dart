import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_login/user_login_bloc.dart';
import 'package:talk_a_tive/core/sizes.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: Colors.amber,
            height: 100,
            width: 100,
            child: state.userLoginData!.status == Status.success?
            Center(child: Text(state.userLoginData!.data!.name!,)):AppSizes.height10)
        );
      },
    );
  }
}
