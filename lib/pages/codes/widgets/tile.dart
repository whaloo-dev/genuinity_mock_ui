import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
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
          codeDetailController.open(code);
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
                      _creationDateWidget(),
                      code.exportDate != null
                          ? _exportDateWidget()
                          : const SizedBox(),
                      code.lastScanDate != null
                          ? _lastScanningDateWidget()
                          : const SizedBox(),
                      code.expirationDate != null
                          ? _expirationDateWidget()
                          : const SizedBox(),
                      code.scanCount > 0
                          ? _codeScanCountWidget()
                          : const SizedBox(),
                      code.scanErrorsCount > 0
                          ? _codeScanErrorCountWidget()
                          : const SizedBox(),
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
          "N° ${code.serial}",
          style: TextStyle(
            fontSize: isSmall ? 8 : 10,
          ),
        ),
        const SizedBox(height: kSpacing),
        Text(
          "Short : ${code.shortCode}",
          style: TextStyle(
            fontSize: isSmall ? 8 : 10,
          ),
        ),
      ],
    );
  }

  Widget _codeScanCountWidget() {
    return Container(
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
    );
  }

  Widget _codeScanErrorCountWidget() {
    return Container(
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

  Widget _creationDateWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.calendar_month_rounded,
            icon2: Icons.add_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Created : ${dateTimeFormat.format(code.creationDate)}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _exportDateWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.calendar_month_rounded,
            icon2: Icons.download_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "First Exported : ${dateTimeFormat.format(code.exportDate!)}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _lastScanningDateWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
            icon1: Icons.calendar_month_rounded,
            icon2: Icons.qr_code_scanner_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Last Scanned : ${dateTimeFormat.format(code.lastScanDate!)}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _expirationDateWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stackIcon(
              icon1: Icons.calendar_month_rounded,
              icon2: Icons.recycling_rounded),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Expires : ${dateFormat.format(code.expirationDate!)}",
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
