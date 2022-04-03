import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSurfaceColor,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/notfound.png"),
              const SizedBox(height: kSpacing),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(rootRoute);
                },
                child: Container(
                  padding: const EdgeInsets.all(kSpacing),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back),
                      Expanded(
                        child: Text(
                          "Back",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
