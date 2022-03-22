import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/codes_creation_wizard/widgets/codes_creation_form.dart';
import 'package:whaloo_genuinity/pages/codes_creation_wizard/widgets/codes_creation_header.dart';

class CodesCreationWizard extends StatelessWidget {
  const CodesCreationWizard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: Responsiveness.isScreenSmall(context) ? 100 : 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              Expanded(
                child: Card(
                  child: Column(
                    children: const [
                      CodesCreationHeader(),
                      Expanded(
                        child: CodesCreationForm(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kSpacing),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
