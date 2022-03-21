import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/new_codes/widgets/new_codes_form.dart';
import 'package:whaloo_genuinity/pages/new_codes/widgets/new_codes_header.dart';

class NewCodesPage extends StatelessWidget {
  final Product product;
  const NewCodesPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Card(
            child: Column(
              children: [
                NewCodesHeader(product: product),
                Expanded(
                  child: NewCodesForm(product: product),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kSpacing),
      ],
    );
  }
}
