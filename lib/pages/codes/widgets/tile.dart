import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/tile_menu.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

class CodeTile extends StatelessWidget {
  final Code code;
  final int index;
  final int totalCount;

  const CodeTile({
    Key? key,
    required this.code,
    required this.index,
    required this.totalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        hoverColor: Colors.transparent,
        selected: codesController.isSelected(code),
        dense: true,
        title: _codeTileBody(),
        subtitle: // Footer
            Row(
          children: [
            Expanded(
              child: Container(),
            ),
            _indexWidget(),
          ],
        ),
        onTap: () {
          detailController.open(code);
        },
      ),
    );
  }

  Widget _codeTileBody() {
    return Column(
      children: [
        // Header
        if (Responsiveness.isScreenSmall())
          Column(
            children: [
              Row(
                children: [
                  _selectionWidget(),
                  Expanded(child: Container()),
                  codeTileMenu(code),
                ],
              )
            ],
          ),
        // Body
        Row(
          children: [
            if (!Responsiveness.isScreenSmall()) _selectionWidget(),
            const SizedBox(width: kSpacing),
            _qrCodeWidget(),
            const SizedBox(width: kSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      _variantWidget(),
                      _statusWidget(),
                      _lastModifiedDateWidget(),
                      _codeScanCountWidget(),
                      _codeScanErrorCountWidget(),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: kSpacing * 3),
            if (!Responsiveness.isScreenSmall()) codeTileMenu(code),
          ],
        ),
        const SizedBox(height: kSpacing),
      ],
    );
  }

  Widget _selectionWidget() {
    return Checkbox(
      value: codesController.isSelected(code),
      onChanged: (newValue) {
        if (newValue!) {
          codesController.select(code);
        } else {
          codesController.unselect(code);
        }
      },
    );
  }

  Widget _qrCodeWidget() {
    bool isSmall = Responsiveness.isScreenSmall();
    return Column(
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: photoWidget(code.image, fixedSize: kSmallImage),
        ),
        Text(
          "N° ${code.id.serial}",
          style: TextStyle(
            fontSize: isSmall ? 8 : 10,
          ),
        ),
        const SizedBox(height: kSpacing),
        Text(
          "Short : ${code.id.shortCode}",
          style: TextStyle(
            fontSize: isSmall ? 8 : 10,
          ),
        ),
      ],
    );
  }

  Widget _codeScanCountWidget() {
    return Visibility(
      visible: code.scanCount != 0,
      maintainAnimation: true,
      maintainInteractivity: false,
      maintainSemantics: false,
      maintainSize: true,
      maintainState: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            stackIcon(
              icon1: Icons.qr_code_scanner_rounded,
            ),
            const SizedBox(width: kSpacing),
            Text(
              "Scans : ${numberFormat.format(code.scanCount)}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _codeScanErrorCountWidget() {
    return Visibility(
      visible: code.scanErrorsCount != 0,
      maintainAnimation: true,
      maintainInteractivity: false,
      maintainSemantics: false,
      maintainSize: true,
      maintainState: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            stackIcon(
              icon1: Icons.qr_code_scanner_rounded,
              icon2: FontAwesomeIcons.exclamationCircle,
              icon2Color: kErrorColor,
            ),
            const SizedBox(width: kSpacing),
            Text(
              "Scan Errors : ${numberFormat.format(code.scanErrorsCount)}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _variantWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.subdirectory_arrow_right_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Variant : ${code.variant.title}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusWidget() {
    final status = code.status();
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Chip(
        backgroundColor: status.color(),
        label: Text(
          status.name(),
          style: TextStyle(
            color: status.onColor(),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _lastModifiedDateWidget() {
    final date = code.lastModified();
    final status = code.status();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.calendar_month_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              (status == CodeStatus.created ? "Created " : "Last Modified ") +
                  ":  ${compactDateTimeFormat.format(date)}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _indexWidget() {
    return Container(
      margin: const EdgeInsets.only(right: kSpacing * 2),
      child: Text(
        "${numberFormat.format(index)} of ${numberFormat.format(totalCount)}",
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
