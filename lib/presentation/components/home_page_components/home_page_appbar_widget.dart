import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class HomePageAppbarWidget extends StatelessWidget {
  const HomePageAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Talkative",
              style: TextStyle(
                fontSize: 27,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.pink[50],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.pink,
                    size: 20,
                  ),
                  SizedBox(width: 2),
                  Text(
                    "Add New",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}