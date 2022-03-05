import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/overview/widgets/info_card_small.dart';
import 'package:flutter/material.dart';

class OverviewCardsSmall extends StatelessWidget {
  const OverviewCardsSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      InfoCardSmall(
        title: "Rides in progress",
        value: "7",
        onTap: () {},
        topColor: Colors.orange,
      ),
      SizedBox(height: kSpacing),
      InfoCardSmall(
        title: "Packages delivered",
        value: "17",
        onTap: () {},
        topColor: Colors.lightGreen,
      ),
      SizedBox(height: kSpacing),
      InfoCardSmall(
        title: "Cancelled delivery",
        value: "3",
        onTap: () {},
        topColor: Colors.redAccent,
      ),
      SizedBox(height: kSpacing),
      InfoCardSmall(
        title: "Scheduled deliveries",
        value: "3",
        topColor: Colors.blue,
        onTap: () {},
      ),
    ]);
  }
}
