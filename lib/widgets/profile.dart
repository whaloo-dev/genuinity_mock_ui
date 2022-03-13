import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return storeController.isDataLoaded.value
            ? Row(
                children: [
                  if (!Responsiveness.isScreenSmall(context))
                    Row(children: [
                      Container(
                        width: 1,
                        height: 22,
                        color: kLightGreyColor,
                      ),
                      SizedBox(width: kSpacing),
                      Text(
                        storeController.store!.name,
                        style: TextStyle(
                          color: kLightGreyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: kSpacing),
                    ]),
                  Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: kLightGreyColor.withOpacity(0.5),
                      child: IconButton(
                          onPressed: () {},
                          splashRadius: kIconButtonSplashRadius,
                          icon: storeController.store!.imageUrl != null
                              ? Image.network(storeController.store!.imageUrl!)
                              : const Icon(Icons.person)),
                    ),
                  ),
                ],
              )
            : Text(
                "...",
                style: TextStyle(color: kLightGreyColor),
              );
      },
    );
  }
}
