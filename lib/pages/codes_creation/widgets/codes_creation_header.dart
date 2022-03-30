import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class CodesCreationHeader extends StatelessWidget {
  const CodesCreationHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        _closeWidget(),
      ],
    );
  }

  Widget _closeWidget() {
    return Padding(
      padding: const EdgeInsets.all(kSpacing),
      child: IconButton(
        splashRadius: kSplashRadius,
        icon: const Icon(Icons.close_rounded),
        onPressed: () {
          codesCreationController.cancel();
        },
      ),
    );
  }
}
