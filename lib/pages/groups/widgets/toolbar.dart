import 'package:flutter/material.dart';
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
          DropdownButton<String>(
              borderRadius: kBorderRadius,
              value: "7 Days",
              style: TextStyle(fontSize: fontSize),
              items: const [
                DropdownMenuItem(
                  value: "7 Days",
                  child: Text("7 Days"),
                ),
                DropdownMenuItem(
                  value: "30 Days",
                  child: Text("30 Days"),
                ),
                DropdownMenuItem(
                  value: "3 Monthes",
                  child: Text("3 Monthes"),
                ),
                DropdownMenuItem(
                  value: "Show All",
                  child: Text("Show All"),
                ),
              ],
              onChanged: (selceted) {}),
        ],
      ),
    );
  }
}
