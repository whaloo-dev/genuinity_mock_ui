import 'package:dash_santos/constants/style.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final void Function() onTap;

  const InfoCard(
      {Key? key,
      required this.title,
      required this.value,
      required this.topColor,
      this.isActive = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 136,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    color: topColor.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kBorderRadius.topLeft.x),
                      topRight: Radius.circular(kBorderRadius.topRight.x),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$title\n",
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    isActive ? kActiveColor : kLightGreyColor,
                              ),
                            ),
                            TextSpan(
                              text: value,
                              style: TextStyle(
                                fontSize: 40,
                                color: isActive ? kActiveColor : kDarkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
