import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/groups/widgets/group_tile.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

class GroupsTable extends StatelessWidget {
  const GroupsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(() {
        final visibleCount = groupsController.visibleCount();
        final groupsCount = groupsController.groupsCount();
        return Stack(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1, height: 1),
              itemCount: min(visibleCount + 1, groupsCount),
              itemBuilder: (context, index) {
                if (index == visibleCount) {
                  groupsController.showMore();
                  return ListTile(
                    hoverColor: Colors.transparent,
                    dense: true,
                    contentPadding: const EdgeInsets.only(
                      top: 20,
                      left: kSpacing,
                      right: kSpacing,
                    ),
                    title: Center(
                      child: Container(
                        padding: const EdgeInsets.all(kSpacing),
                        child: Container(
                          padding: const EdgeInsets.all(kSpacing),
                          child: const Text("Loading..."),
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    GroupTile(
                      group: groupsController.group(index),
                      onSelected: (selectedGroup) {
                        navigationController.navigateTo(
                          codesPageRoute,
                          arguments: selectedGroup.key,
                        );
                      },
                    ),
                    //added space for the floating action button
                    if (index + 1 == groupsCount)
                      const SizedBox(height: kSpacing * 11),
                  ],
                );
              },
            ),
            if (groupsController.groupsCount() != 0)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(kSpacing * 3),
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        codesCreationController.createNew();
                      },
                    ),
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}
