import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/info_card_small.dart';
import 'package:flutter/material.dart';

class DashboardCardsSmall extends StatelessWidget {
  const DashboardCardsSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      InfoCardSmall(
        title: "Rides in progress",
        value: "7",
        onTap: () {},
        topColor: Colors.orange,
      ),
      const SizedBox(height: kSpacing),
      InfoCardSmall(
        title: "Packages delivered",
        value: "17",
        onTap: () {},
        topColor: Colors.lightGreen,
      ),
      const SizedBox(height: kSpacing),
      InfoCardSmall(
        title: "Cancelled delivery",
        value: "3",
        onTap: () {},
        topColor: Colors.redAccent,
      ),
      const SizedBox(height: kSpacing),
      InfoCardSmall(
        title: "Scheduled deliveries",
        value: "3",
        topColor: Colors.blue,
        onTap: () {},
      ),
    ]);
  }
}
