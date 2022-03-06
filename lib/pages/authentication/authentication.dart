import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSurfaceColor,
      body: Center(
        child: Card(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 550,
            ),
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/icons/logo.png"),
                      Text(
                        "${globals.appName}\n${globals.appVersion}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          color: kDarkColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kSpacing),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: kSpacing),
                const TextField(
                  decoration: InputDecoration(
                    label: Text("Username"),
                  ),
                ),
                SizedBox(height: kSpacing),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Password"),
                  ),
                ),
                SizedBox(height: kSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(color: kActiveColor),
                        ),
                      ],
                    ),
                    Text(
                      "Forgot password",
                      style: TextStyle(color: kActiveColor),
                    ),
                  ],
                ),
                SizedBox(height: kSpacing),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(rootRoute);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: kSpacing),
                    child: const Text("Sign In"),
                  ),
                ),
                SizedBox(height: kSpacing),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: "Do not have admin credentials? "),
                      TextSpan(
                        text: "Request credentials",
                        style: TextStyle(color: kActiveColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
