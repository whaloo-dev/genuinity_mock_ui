import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
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
            Card(
              margin: const EdgeInsets.only(right: kSpacing * 2),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.arrow_circle_left_rounded,
                color: colorScheme.primary.withOpacity(0.4),
              ),
            ),
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
        if (scansCount != 0) _codeScanCountWidget(scansCount),
        if (scanErrorsCount != 0) _codeScanErrorCountWidget(scanErrorsCount),
        const SizedBox(),
      ],
    );
  }

  Widget _codesCountWidget(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        stackIcon(
          icon1: Icons.qr_code_rounded,
          icon1Color: Get.theme.hintColor,
        ),
        Text(
          "${numberFormat.format(count)}"
          " code${count == 1 ? '' : 's'}",
          style: TextStyle(color: Get.theme.hintColor),
        ),
      ],
    );
  }

  Widget _codeScanCountWidget(int count) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.qr_code_scanner_rounded,
            icon1Color: Get.theme.hintColor,
          ),
          const SizedBox(width: kSpacing),
          Text(
            "Scans : ${numberFormat.format(count)}",
            style: TextStyle(color: Get.theme.hintColor),
          ),
        ],
      ),
    );
  }

  Widget _codeScanErrorCountWidget(int count) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.qr_code_scanner_rounded,
            icon1Color: Get.theme.hintColor,
            icon2: FontAwesomeIcons.exclamationCircle,
            icon2Color: kErrorColor,
          ),
          const SizedBox(width: kSpacing),
          Text(
            "Scan Errors : ${numberFormat.format(count)}",
            style: TextStyle(color: Get.theme.hintColor),
          ),
        ],
      ),
    );
  }
}
