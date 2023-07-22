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
        padding: const EdgeInsets.only(left: 16, right: 5, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Talkative",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 27,
                    color: AppColors.white,
                  ),
                ),
                popup()
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget popup() {
  return PopupMenuButton<int>(
    itemBuilder: (context) => [
      const PopupMenuItem(
        value: 1,
        child: Text("Profile"),
      ),
      const PopupMenuItem(
        value: 2,
        child: Text("Add group"),
      )
    ],
    color: AppColors.white,
    elevation: 2,
    onSelected: (value) {
      if (value == 1) {
      } else if (value == 2) {}
    },
  );
}
