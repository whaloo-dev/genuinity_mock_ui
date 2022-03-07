import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_table.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    // storeController.loadDemoStoreData();
                  },
                  // child: const Text("Refresh Products"),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text("Refresh the products list"),
                ),
                SizedBox(width: kSpacing),
              ],
            ),
            DropdownButton<String>(
              borderRadius: kBorderRadius,
              elevation: kElevation.toInt(),
              hint: const Text("Pages"),
              items: const [
                DropdownMenuItem<String>(
                  value: "Page 1",
                  child: Text(
                    "1-99",
                    textAlign: TextAlign.center,
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "Page 2",
                  child: Text("100-199"),
                ),
              ],
              onChanged: (value) {
                Get.showSnackbar(GetSnackBar(
                  message: value,
                  duration: const Duration(seconds: 5),
                  overlayBlur: .5,
                ));
              },
            ),
          ],
        ),
        //  SizedBox(height: kSpacing),
        const Expanded(child: CodesTable()),
        SizedBox(height: kSpacing),
      ],
    );
  }
}
