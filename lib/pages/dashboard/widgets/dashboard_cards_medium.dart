import 'package:whaloo_genuinity/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/info_card.dart';

class DashboardCardsMedium extends StatelessWidget {
  const DashboardCardsMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          InfoCard(
            title: "Rides in progress",
            value: "7",
            onTap: () {},
            topColor: Colors.orange,
          ),
          const SizedBox(width: kSpacing),
          InfoCard(
            title: "Packages delivered",
            value: "17",
            onTap: () {},
            topColor: Colors.lightGreen,
          ),
        ],
      ),
      const SizedBox(height: kSpacing),
      Row(
        children: [
          InfoCard(
            title: "Cancelled delivery",
            value: "3",
            onTap: () {},
            topColor: Colors.redAccent,
          ),
          const SizedBox(width: kSpacing),
          InfoCard(
            title: "Scheduled deliveries",
            value: "3",
            topColor: Colors.blue,
            onTap: () {},
          ),
        ],
      ),
    ]);
  }
}
