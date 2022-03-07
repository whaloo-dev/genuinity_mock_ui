import 'package:flutter/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Dashboard Page..."));
    // return ListView(
    //   children: [
    //     SizedBox(height: kSpacing),
    //     const ResponsiveWidget(
    //       largeWidget: DashboardCardsLarge(),
    //       mediumWidget: DashboardCardsMedium(),
    //       smallWidget: DashboardCardsSmall(),
    //     ),
    //     SizedBox(height: kSpacing),
    //     const ResponsiveWidget(
    //       largeWidget: RevenueSectionLarge(),
    //       smallWidget: RevenueSectionSmall(),
    //     ),
    //     SizedBox(height: kSpacing),
    //   ],
    // );
  }
}
