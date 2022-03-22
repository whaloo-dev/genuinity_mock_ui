import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/codes_creation_wizard/widgets/codes_creation_form.dart';
import 'package:whaloo_genuinity/pages/product_selector/widgets/product_selector_header.dart';

class ProductSelector extends StatelessWidget {
  const ProductSelector({
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
                    children: [
                      const ProductSelectorHeader(),
                      const Expanded(
                        child: CodesCreationForm(),
                      ),
                      const SizedBox(height: kSpacing * 2),
                      const Divider(thickness: 1),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _cancelButton(),
                          const SizedBox(width: kSpacing),
                          _submitButton(),
                        ],
                      ),
                      const SizedBox(height: kSpacing * 2),
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

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        // newCodesController.submit();
      },
      child: const Text("Create"),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        // newCodesController.cancel();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          colorScheme.secondaryContainer,
        ),
      ),
      child: Text("Cancel",
          style: TextStyle(
            color: colorScheme.onSecondaryContainer,
          )),
    );
  }
}
