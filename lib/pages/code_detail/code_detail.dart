import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/code_detail/widgets/code_detail_body.dart';

class CodeDetail extends StatelessWidget {
  const CodeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialogLayout(
      Card(
        child: Stack(
          children: [
            CodeDetailBody(),
            Positioned(
              top: 0,
              right: 0,
              child: _closeWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _closeWidget() {
    return Padding(
      padding: const EdgeInsets.all(kSpacing),
      child: IconButton(
        splashRadius: kSplashRadius,
        icon: const Icon(Icons.close_rounded),
        onPressed: () {
          codeDetailController.close();
        },
      ),
    );
  }
}
