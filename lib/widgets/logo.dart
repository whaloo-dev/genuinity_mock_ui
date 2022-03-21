import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/constants/globals.dart';
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
            margin: const EdgeInsets.only(top: kSpacing),
            child: SizedBox(
              width: 40,
              child: Image.asset("assets/icons/logo-small.png"),
            ),
          ),
          const SizedBox(height: kSpacing),
          const Flexible(
            child: Text(
              appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
