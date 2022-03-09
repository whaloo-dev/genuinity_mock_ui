import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/widgets/notification.dart';
import 'package:whaloo_genuinity/widgets/profile.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      elevation: 0,
      leading: Responsiveness.isScreenSmall(context)
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
              menuController.activeItem.value.name,
              style: TextStyle(
                color: kDarkColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container()),
          const NotificationWidget(),
          SizedBox(width: kSpacing),
          const ProfileWidget(),
        ],
      ),
      iconTheme: IconThemeData(color: kDarkColor),
      backgroundColor: kLightColor,
    );
