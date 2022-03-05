import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurfaceColor,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/notfound.png"),
              SizedBox(height: kSpacing),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(rootRoute);
                },
                child: Container(
                  padding: EdgeInsets.all(kSpacing),
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
