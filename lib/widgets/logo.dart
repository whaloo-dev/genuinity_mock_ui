import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(
        direction: Responsive.isScreenCustom(context)
            ? Axis.vertical
            : Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: kSpacing),
          Container(
            margin: EdgeInsets.only(top: kSpacing),
            child: Image.asset("assets/icons/logo-small.png"),
          ),
          Flexible(
            child: Text(
              globals.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kDarkColor.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
