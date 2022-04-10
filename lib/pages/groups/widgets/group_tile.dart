import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

class GroupTile extends StatelessWidget {
  final Group group;
  final void Function(Group product) onSelected;

  const GroupTile({
    Key? key,
    required this.onSelected,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      hoverColor: Colors.transparent,
      title: _tileBody(),
      contentPadding: const EdgeInsets.symmetric(horizontal: kSpacing),
      onTap: () {
        onSelected(group);
      },
    );
  }

  Widget _tileBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: kSpacing),
        Row(
          children: [
            photoWidget(group.key.image),
            const SizedBox(width: kSpacing),
            Expanded(child: _productTitleWidget()),
          ],
        ),
      ],
    );
  }

  Widget _productTitleWidget() {
    int codesCount = group.codesCount();
    int scansCount = group.scanCount();
    int scanErrorsCount = group.scanErrorsCount();
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                group.key.title,
              ),
            ),
          ],
        ),
        _codesCountWidget(codesCount),
        _updateDateWidget(group.lastModified()),
        _codeScanCountWidget(scansCount),
        _codeScanErrorCountWidget(scanErrorsCount),
        const SizedBox(),
      ],
    );
  }

  Widget _codesCountWidget(int count) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            stackIcon(
              icon1: Icons.qr_code_rounded,
              icon1Color: menuController.theme().hintColor,
            ),
            Text(
              "Codes : ${numberFormat.format(count)}",
              style: TextStyle(color: menuController.theme().hintColor),
            ),
          ],
        ));
  }

  Widget _codeScanCountWidget(int count) {
    return Visibility(
      visible: count != 0,
      maintainAnimation: true,
      maintainInteractivity: false,
      maintainSemantics: false,
      maintainState: true,
      maintainSize: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                stackIcon(
                  icon1: Icons.qr_code_scanner_rounded,
                  icon1Color: menuController.theme().hintColor,
                ),
                const SizedBox(width: kSpacing),
                Text(
                  "Total Scans : ${numberFormat.format(count)}",
                  style: TextStyle(color: menuController.theme().hintColor),
                ),
              ],
            )),
      ),
    );
  }

  Widget _codeScanErrorCountWidget(int count) {
    return Visibility(
      visible: count != 0,
      maintainAnimation: true,
      maintainInteractivity: false,
      maintainSemantics: false,
      maintainState: true,
      maintainSize: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                stackIcon(
                  icon1: Icons.qr_code_scanner_rounded,
                  icon1Color: menuController.theme().hintColor,
                  icon2: FontAwesomeIcons.exclamationCircle,
                  icon2Color: kErrorColor,
                ),
                const SizedBox(width: kSpacing),
                Text(
                  "Total Scan Errors : ${numberFormat.format(count)}",
                  style: TextStyle(color: menuController.theme().hintColor),
                ),
              ],
            )),
      ),
    );
  }

  Widget _updateDateWidget(DateTime modificationDate) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              stackIcon(
                icon1: Icons.calendar_month_rounded,
                icon1Color: menuController.theme().hintColor,
              ),
              const SizedBox(width: kSpacing),
              Flexible(
                child: Text(
                  "Last Modified : ${compactDateTimeFormat.format(modificationDate)}",
                  style: TextStyle(color: menuController.theme().hintColor),
                ),
              ),
            ],
          )),
    );
  }
}
