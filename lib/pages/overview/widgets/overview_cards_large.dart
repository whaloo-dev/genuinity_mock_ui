import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/overview/widgets/info_card.dart';
import 'package:flutter/material.dart';

class OverviewCardsLarge extends StatelessWidget {
  const OverviewCardsLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Row(
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
        SizedBox(width: kSpacing),
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
    );
  }
}
