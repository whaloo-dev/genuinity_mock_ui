import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/widgets/notification.dart';
import 'package:whaloo_genuinity/widgets/profile.dart';

Widget topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    ListTile(
      leading: Responsiveness.isScreenSmall(context)
          ? IconButton(
              splashRadius: kSplashRadius,
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            )
          : null,
      title: Row(
        children: [
          Obx(
            () => Text(
              menuController.activeItem.value.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container()),
          const NotificationWidget(),
          const SizedBox(width: kSpacing),
          const ProfileWidget(),
        ],
      ),
    );
