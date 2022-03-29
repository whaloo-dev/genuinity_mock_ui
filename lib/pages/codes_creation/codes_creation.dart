import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/codes_creation/widgets/codes_creation_form.dart';
import 'package:whaloo_genuinity/pages/codes_creation/widgets/codes_creation_header.dart';

class CodesCreationWizard extends StatelessWidget {
  const CodesCreationWizard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialogLayout(
      context,
      Card(
        child: Column(
          children: const [
            CodesCreationHeader(),
            Expanded(
              child: CodesCreationForm(),
            ),
          ],
        ),
      ),
    );
  }
}
