import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/pages/groups/widgets/groups_table.dart';
import 'package:whaloo_genuinity/pages/groups/widgets/groups_table_empty.dart';
import 'package:whaloo_genuinity/pages/groups/widgets/toolbar.dart';

final controller = groupsController;

class GroupsPage extends StatelessWidget {
  GroupsPage({Key? key}) : super(key: key) {
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          GroupsToolbar(),
          (controller.groupsCount() == 0)
              ? const Expanded(child: GroupsTableEmptyWidget())
              : const Expanded(child: GroupsTable()),
        ],
      ),
    );
  }
}
