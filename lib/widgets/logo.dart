import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: kSpacing),
            child: SizedBox(
              width: 25,
              child: Image.asset("assets/icons/logo-small.png"),
            ),
          ),
          SizedBox(height: kSpacing),
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
