import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    super.key,
    required this.controller,
    required this.icons,
    required this.labelText,
  });

  final TextEditingController controller;
  final IconData icons;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(25),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: const EdgeInsets.all(8),
          prefixIconColor: AppColors.black,
          prefixIcon: Icon(icons),
          suffixIconColor: AppColors.black,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
