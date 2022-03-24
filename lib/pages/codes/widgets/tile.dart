import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/tile_menu.dart';

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
      dense: true,
      title: _codeTileBody(context),
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
        // Header
        Column(
          children: [
            const SizedBox(height: kSpacing * 3),
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
            const SizedBox(width: kSpacing),
            _qrCodeWidget(context),
            const SizedBox(width: kSpacing),
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
            const SizedBox(width: 30),
          ],
        ),
        const SizedBox(height: kSpacing),
        // Footer
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
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadius,
      ),
      splashRadius: kIconButtonSplashRadius,
      value: code.isSelected,
      onChanged: (newValue) {
        if (newValue!) {
          codesController.select(code);
        } else {
          codesController.unselect(code);
        }
      },
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
            icon1: Icons.calendar_month_rounded,
            icon2: Icons.add_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Created : ${dateFormat.format(code.creationDate)}",
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
            icon1: Icons.calendar_month_rounded,
            icon2: Icons.download_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "First Exported : ${dateFormat.format(code.exportDate!)}",
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
            icon1: Icons.calendar_month_rounded,
            icon2: Icons.qr_code_scanner_rounded,
          ),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Last Scanned : ${dateFormat.format(code.lastScanDate!)}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _expirationDateWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(
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

  Widget _stackIcon(
      {required IconData icon1, IconData? icon2, Color? icon2Color}) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(7),
          child: Center(
            child: Icon(
              icon1,
              size: 18,
            ),
          ),
        ),
        if (icon2 != null)
          Positioned(
            right: 0,
            child: Icon(
              icon2,
              size: 12,
            ),
          )
      ],
    );
  }
}
