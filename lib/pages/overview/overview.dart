import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/helpers/responsiveness.dart';
import 'package:dash_santos/pages/overview/widgets/available_drivers.dart';
import 'package:dash_santos/pages/overview/widgets/overview_cards_large.dart';
import 'package:dash_santos/pages/overview/widgets/overview_cards_medium.dart';
import 'package:dash_santos/pages/overview/widgets/overview_cards_small.dart';
import 'package:dash_santos/pages/overview/widgets/revenue_section_large.dart';
import 'package:dash_santos/pages/overview/widgets/revenue_section_small.dart';
import 'package:flutter/widgets.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: kSpacing),
        const ResponsiveWidget(
          largeWidget: OverviewCardsLarge(),
          mediumWidget: OverviewCardsMedium(),
          smallWidget: OverviewCardsSmall(),
        ),
        SizedBox(height: kSpacing),
        const ResponsiveWidget(
          largeWidget: RevenueSectionLarge(),
          smallWidget: RevenueSectionSmall(),
        ),
        SizedBox(height: kSpacing),
        const AvailableDrivers(),
        SizedBox(height: kSpacing),
      ],
    );
  }
}
