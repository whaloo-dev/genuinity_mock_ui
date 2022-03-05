import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:whaloo_genuinity/widgets/horizontal_menu_item.dart';
import 'package:whaloo_genuinity/widgets/vertical_menu_item.dart';
import 'package:flutter/widgets.dart';

class SideMenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;
  final void Function()? onTap;

  const SideMenuItemWidget({Key? key, required this.menuItem, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      if (ResponsiveWidget.isScreenSmall(context)) {
        Navigator.of(context).pop();
      }
      if (onTap != null) {
        onTap!();
      }
    }

    if (ResponsiveWidget.isScreenCustom(context)) {
      return VerticalMenuItemWidget(
        menuItem: menuItem,
        onTap: _onTap,
      );
    }
    return HorziontalMenuItem(
      menuItem: menuItem,
      onTap: _onTap,
    );
  }
}
