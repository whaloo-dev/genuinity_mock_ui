import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/creation/widgets/creation_form.dart';
import 'package:whaloo_genuinity/pages/creation/widgets/creation_header.dart';

class CodesCreationDialog extends StatelessWidget {
  const CodesCreationDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialogLayout(
      Card(
        child: Column(
          children: const [
            CreationHeader(),
            Expanded(
              child: CreationForm(),
            ),
          ],
        ),
      ),
    );
  }
}
