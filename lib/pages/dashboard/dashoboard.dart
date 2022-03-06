import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/dashboard_cards_large.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/dashboard_cards_medium.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/dashboard_cards_small.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/revenue_section_large.dart';
import 'package:whaloo_genuinity/pages/dashboard/widgets/revenue_section_small.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: kSpacing),
        const ResponsiveWidget(
          largeWidget: DashboardCardsLarge(),
          mediumWidget: DashboardCardsMedium(),
          smallWidget: DashboardCardsSmall(),
        ),
        SizedBox(height: kSpacing),
        const ResponsiveWidget(
          largeWidget: RevenueSectionLarge(),
          smallWidget: RevenueSectionSmall(),
        ),
        SizedBox(height: kSpacing),
      ],
    );
  }
}
