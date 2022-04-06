import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class GroupsToolbar extends StatelessWidget {
  const GroupsToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = 12;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          IconButton(
            splashRadius: kSplashRadius,
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {},
          ),
          Expanded(child: Container()),
          Obx(
            () => DropdownButton<TimeSpan>(
              borderRadius: kBorderRadius,
              value: codesFilteringController.timeSpan(),
              style: TextStyle(fontSize: fontSize),
              items: TimeSpan.values
                  .map(
                    (timeSpan) => DropdownMenuItem(
                      value: timeSpan,
                      child: Text(timeSpan.name()),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                codesFilteringController.changeTimeSpan(newValue!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
