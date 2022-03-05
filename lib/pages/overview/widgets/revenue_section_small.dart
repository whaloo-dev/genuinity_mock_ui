import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/pages/overview/widgets/chart.dart';
import 'package:dash_santos/pages/overview/widgets/revenue_info.dart';
import 'package:flutter/material.dart';

class RevenueSectionSmall extends StatelessWidget {
  const RevenueSectionSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 260,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Revenue Chart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kLightGreyColor,
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    height: 200,
                    child: revenueChartWithSampleData(),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 1,
              color: kLightGreyColor,
            ),
            SizedBox(
              height: 260,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: const [
                      RevenueInfo(
                        title: "Today's revenue",
                        amount: "23",
                      ),
                      RevenueInfo(
                        title: "Last 7 days",
                        amount: "145",
                      ),
                    ],
                  ),
                  SizedBox(height: kSpacing),
                  Row(
                    children: const [
                      RevenueInfo(
                        title: "Last 30 days",
                        amount: "1,203",
                      ),
                      RevenueInfo(
                        title: "Last 12 months ",
                        amount: "10,022",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
