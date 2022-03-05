import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/pages/overview/widgets/info_card.dart';
import 'package:flutter/material.dart';

class OverviewCardsMedium extends StatelessWidget {
  const OverviewCardsMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          InfoCard(
            title: "Rides in progress",
            value: "7",
            onTap: () {},
            topColor: Colors.orange,
          ),
          SizedBox(width: kSpacing),
          InfoCard(
            title: "Packages delivered",
            value: "17",
            onTap: () {},
            topColor: Colors.lightGreen,
          ),
        ],
      ),
      SizedBox(height: kSpacing),
      Row(
        children: [
          InfoCard(
            title: "Cancelled delivery",
            value: "3",
            onTap: () {},
            topColor: Colors.redAccent,
          ),
          SizedBox(width: kSpacing),
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
