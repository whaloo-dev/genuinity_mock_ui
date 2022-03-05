import 'package:badges/badges.dart';
import 'package:dash_santos/constants/controllers.dart';
import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/helpers/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      elevation: 0,
      leading: ResponsiveWidget.isScreenSmall(context)
          ? IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: kDarkColor.withOpacity(.7)),
            )
          : null,
      title: Row(
        children: [
          Obx(
            () => Text(
              menuController.activeItem.value,
              style: TextStyle(
                color: kDarkColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: kDarkColor.withOpacity(.7)),
          ),
          Badge(
            toAnimate: true,
            shape: BadgeShape.square,
            borderRadius: BorderRadius.circular(10),
            badgeContent: Text(
              "52",
              style: TextStyle(
                color: kLightColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            badgeColor: kActiveColor.withOpacity(.7),
            position: const BadgePosition(
              isCenter: false,
              end: 0,
              top: -1,
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications,
                    color: kDarkColor.withOpacity(.7))),
          ),
          if (!ResponsiveWidget.isScreenSmall(context))
            Row(children: [
              SizedBox(width: kSpacing),
              Container(
                width: 1,
                height: 22,
                color: kLightGreyColor,
              ),
              SizedBox(width: kSpacing),
              Text("Whaloo LLC", style: TextStyle(color: kLightGreyColor)),
              SizedBox(width: kSpacing),
            ]),
          Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: kLightColor,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person_outline,
                  color: kDarkColor,
                ),
              ),
            ),
          )
        ],
      ),
      iconTheme: IconThemeData(color: kDarkColor),
      backgroundColor: kLightColor,
    );
