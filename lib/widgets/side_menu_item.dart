import 'package:dash_santos/helpers/responsiveness.dart';
import 'package:dash_santos/routes/routes.dart';
import 'package:dash_santos/widgets/horizontal_menu_item.dart';
import 'package:dash_santos/widgets/vertical_menu_item.dart';
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
