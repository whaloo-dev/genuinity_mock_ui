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
                  if (!Responsiveness.isScreenSmall())
                    Row(
                      children: [
                        Container(
                          width: 1,
                          height: 22,
                          color: menuController.theme().colorScheme.outline,
                        ),
                        const SizedBox(width: kSpacing),
                        Text(
                          storeController.store!.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: kSpacing),
                      ],
                    ),
                  Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      icon: storeController.store!.imageUrl != null
                          ? Ink.image(
                              image: NetworkImage(
                                  storeController.store!.imageUrl!),
                            )
                          : const Icon(Icons.person),
                    ),
                  ),
                ],
              )
            : const Text("...");
      },
    );
  }
}
