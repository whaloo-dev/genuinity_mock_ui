import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/chart.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/revenue_info.dart';
import 'package:flutter/material.dart';

class RevenueSectionLarge extends StatelessWidget {
  const RevenueSectionLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              width: 1,
              height: 120,
              color: kLightGreyColor,
            ),
            Expanded(
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
