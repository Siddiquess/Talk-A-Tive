import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.onTap,
  });
  final String leftText;
  final String rightText;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: RichText(
          text: TextSpan(
            children: [
               TextSpan(
                text: '$leftText have an account? ',
                style: const TextStyle(color: AppColors.black, fontSize: 15),
              ),
              TextSpan(
                text: rightText,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = onTap
              ),
            ],
          ),
        ),
      ),
    );
  }
}
