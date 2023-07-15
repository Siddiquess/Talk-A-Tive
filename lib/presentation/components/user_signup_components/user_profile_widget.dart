import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import '../../../bussiness_logic/user_sign_up/user_sign_up_bloc.dart';
import '../../../core/sizes.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
    required this.state
  });

  final UserSignUpState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade600,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<UserSignUpBloc>(context)
                  .add(PickUserProfileEvent(context: context, isCamera: false));
            },
            child: CircleAvatar(
                radius: 49,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: const AssetImage("assets/no_user.jpg"),
                child: state.userProfile != null &&
                        state.userProfile != "assets/no_user.jpg"
                    ? CircleAvatar(
                        radius: 49,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: NetworkImage(state.userProfile ?? ""),
                      )
                    : AppSizes.width10),
          ),
        ),
        Positioned(
          bottom: 7,
          right: 1,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<UserSignUpBloc>(context).add(
                PickUserProfileEvent(context: context, isCamera: true),
              );
            },
            child: const CircleAvatar(
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
    );
  }
}