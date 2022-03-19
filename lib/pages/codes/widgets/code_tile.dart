import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/code_menu.dart';

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
    return ListTile(
      hoverColor: Colors.transparent,
      selected: code.isSelected,
      selectedTileColor: kSelectionColor,
      dense: true,
      title: _codeTileBody(context),
      trailing: codesMenu(context, code),
      onTap: () {
        final newValue = !code.isSelected;
        if (newValue) {
          codesController.select(code);
        } else {
          codesController.unselect(code);
        }
      },
    );
  }

  Widget _codeTileBody(BuildContext context) {
    return Column(
      children: [
        _selectionWidget(),
        Row(
          children: [
            _qrCodeWidget(context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      if (code.variant.product.variants.length > 1)
                        _variantWidget(),
                      _creationDateWidget(),
                      code.exportDate != null
                          ? _exportDateWidget()
                          : const SizedBox(),
                      code.lastScanDate != null
                          ? _lastScanningDateWidget()
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
          ],
        ),
        const SizedBox(height: kSpacing),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            _indexWidget(),
          ],
        ),
      ],
    );
  }

  Widget _selectionWidget() {
    return Row(
      children: [
        Column(
          children: [
            const SizedBox(height: kSpacing * 3),
            Checkbox(
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              splashRadius: kIconButtonSplashRadius,
              value: code.isSelected,
              onChanged: (newValue) {
                if (newValue!) {
                  codesController.select(code);
                } else {
                  codesController.unselect(code);
                }
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _qrCodeWidget(BuildContext context) {
    bool isSmall = Responsiveness.isScreenSmall(context);
    double size = isSmall ? 50 : 70;
    return Column(
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: size,
            height: size,
            child:
                Image.asset("assets/demo/images/qrcode${(index % 7) + 1}.png"),
          ),
        ),
        Text(
          "N° ${code.serial}",
          style: TextStyle(
            color: kDarkColor,
            fontSize: isSmall ? 8 : 12,
          ),
        ),
        const SizedBox(height: kSpacing),
        Text(
          "Short : ${code.shortCode}",
          style: TextStyle(
            color: kDarkColor,
            fontSize: isSmall ? 8 : 12,
          ),
        ),
      ],
    );
  }

  Widget _codeScanCountWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
            icon1: Icons.qr_code_scanner_rounded,
          ),
          const SizedBox(width: kSpacing),
          Text(
            "Scans : ${numberFormat.format(code.scanCount)}",
            style: TextStyle(
              color: kLightGreyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeScanErrorCountWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
            icon1: Icons.qr_code_scanner_rounded,
            icon2: FontAwesomeIcons.exclamationCircle,
            icon2Color: kErrorColor,
          ),
          const SizedBox(width: kSpacing),
          Text(
            "Scan Errors : ${numberFormat.format(code.scanErrorsCount)}",
            style: TextStyle(
              color: kLightGreyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _variantWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
            icon1: Icons.collections_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Variant : ${code.variant.title}",
              style: TextStyle(
                color: kLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _creationDateWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
            icon1: Icons.calendar_today_rounded,
            icon2: Icons.add_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Created : ${dateFormat.format(code.creationDate)}",
              style: TextStyle(
                color: kLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _exportDateWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
            icon1: Icons.calendar_today_rounded,
            icon2: Icons.download_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "First Exported : ${dateFormat.format(code.exportDate!)}",
              style: TextStyle(
                color: kLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lastScanningDateWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
            icon1: Icons.calendar_today_rounded,
            icon2: Icons.qr_code_scanner_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Last Scanned : ${dateFormat.format(code.lastScanDate!)}",
              style: TextStyle(
                color: kLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indexWidget() {
    return Text(
      "${numberFormat.format(index)} of ${numberFormat.format(totalCount)}",
      style: TextStyle(
        color: kLightGreyColor,
        fontSize: 12,
      ),
    );
  }

  Widget _stackIcon(
      {required IconData icon1, IconData? icon2, Color? icon2Color}) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7, right: 9),
          child: Icon(
            icon1,
            color: kLightGreyColor,
            size: 18,
          ),
        ),
        if (icon2 != null)
          Positioned(
            right: 0,
            child: Icon(
              icon2,
              color: icon2Color ?? kLightGreyColor,
              size: 12,
            ),
          )
      ],
    );
  }
}
