import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whaloo_genuinity/backend/models.dart';
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
      title: _productTileBody(context),
      trailing: codesMenu(context, code),
      onTap: () {},
    );
  }

  Widget _productTileBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _selectionWidget(),
        // SizedBox(height: kSpacing),
        Row(
          children: [
            _qrCodeWidget(context),
            const SizedBox(width: kSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // _codeTitleWidget(),
                  // const SizedBox(height: kSpacing * 2),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    // spacing: kSpacing,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _variantWidget(),
                      _creationDateWidget(),
                      if (code.lastScanDate != null) _lastScanningDateWidget(),
                      if (code.scanCount > 0) _codeScanCountWidget(),
                      if (code.scanErrorsCount > 0) _codeScanErrorCountWidget(),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 2 * kSpacing),
        Row(
          children: [
            Expanded(child: Container()),
            _footerWidget(),
          ],
        ),
      ],
    );
  }

  Widget _selectionWidget() {
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          splashRadius: kIconButtonSplashRadius,
          value: code.isSelected,
          onChanged: (newValue) {},
        )
      ],
    );
  }

  Widget _qrCodeWidget(BuildContext context) {
    return SizedBox(
      width: Responsiveness.isScreenSmall(context) ? 75 : 150,
      height: Responsiveness.isScreenSmall(context) ? 75 : 150,
      child: const Icon(FontAwesomeIcons.qrcode),
    );
  }

  Widget _codeTitleWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            code.variant.title,
            style: TextStyle(color: kDarkColor.withOpacity(0.8)),
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
          Icon(
            Icons.qr_code_scanner_rounded,
            size: 18,
            color: kLightGreyColor,
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
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: kLightGreyColor,
                  size: 18,
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: kSurfaceColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    FontAwesomeIcons.exclamationCircle,
                    color: kErrorColor,
                    size: 12,
                  ),
                ),
              )
            ],
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
          Icon(
            Icons.collections_rounded,
            color: kLightGreyColor,
            size: 18,
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
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6, right: 6),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: kLightGreyColor,
                  size: 18,
                ),
              ),
              Positioned(
                right: 0,
                child: Icon(
                  Icons.add_rounded,
                  color: kLightGreyColor,
                  size: 12,
                ),
              )
            ],
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

  Widget _lastScanningDateWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: kLightGreyColor,
                  size: 18,
                ),
              ),
              Positioned(
                right: 0,
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: kLightGreyColor,
                  size: 12,
                ),
              )
            ],
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

  Widget _footerWidget() {
    return Text(
      "${numberFormat.format(index)} of ${numberFormat.format(totalCount)}",
      style: TextStyle(
        color: kLightGreyColor,
        fontSize: 12,
      ),
    );
  }
}
