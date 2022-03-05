import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/drivers/widgets/drivers_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({Key? key}) : super(key: key);

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
                ElevatedButton(
                  onPressed: () {
                    Get.showSnackbar(const GetSnackBar(
                      message: "Action 1 Clicked",
                      duration: Duration(seconds: 5),
                    ));
                  },
                  child: const Text("Action 1"),
                ),
                SizedBox(width: kSpacing),
                ElevatedButton(
                  onPressed: () {
                    Get.showSnackbar(const GetSnackBar(
                      message: "Action 2 Clicked",
                      duration: Duration(seconds: 5),
                    ));
                  },
                  child: const Text("Action 2"),
                ),
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
        const Expanded(child: DriversTable()),
        SizedBox(height: kSpacing),
      ],
    );
  }
}
