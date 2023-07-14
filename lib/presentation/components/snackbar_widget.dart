import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  static flushbar({required BuildContext context,required String message}) {
    return Flushbar(
      message:message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: const Duration(seconds: 2),
      leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }
}
