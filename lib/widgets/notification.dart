import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      elevation: kElevation,
      toAnimate: true,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(10),
      badgeContent: Text(
        "10",
        style: TextStyle(
          color: kLightColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      badgeColor: kActiveColor,
      position: const BadgePosition(
        isCenter: false,
        end: 0,
        top: -1,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notifications,
          color: kDarkColor.withOpacity(.7),
        ),
      ),
    );
  }
}
