import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/code_detail/widgets/code_detail_body.dart';

class CodeDetail extends StatelessWidget {
  const CodeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialogLayout(
      context,
      Card(
        child: Column(
          children: const [
            //CodeDetailHeader(),
            Expanded(
              child: CodeDetailBody(),
            ),
          ],
        ),
      ),
    );
  }
}
