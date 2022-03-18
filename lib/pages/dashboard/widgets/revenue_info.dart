import 'package:whaloo_genuinity/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RevenueInfo extends StatelessWidget {
  final String title;
  final String amount;

  const RevenueInfo({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title  \n\n",
              style: TextStyle(color: kLightGreyColor, fontSize: 16),
            ),
            TextSpan(
              text: "\$ $amount ",
              style: const TextStyle(
                color: kDarkColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
