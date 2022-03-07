import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Color kSurfaceColor = Colors.white; //Color(0xFFF7F8FC);
Color kLightColor = Colors.grey.shade100; //Color(0xFFF7F8FC);
Color kLightGreyColor = Colors.grey.shade500; //Color(0xFFA4A6B3);
Color kDarkColor = Colors.black; //Color(0xFF363740);
Color kActiveColor = Colors.blue.shade500; //Color(0xFF3C19C0);
Color kLogoColor = Colors.blueAccent.shade200;

double radius = 10;
BorderRadius kBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(radius),
  topRight: Radius.circular(radius),
  bottomLeft: Radius.circular(radius),
  bottomRight: Radius.circular(radius),
);

double kElevation = 5;

double kSpacing = 10;

double kIconButtonSplashRadius = 25;

NumberFormat numberFormat = NumberFormat("###,###", "en_US");
DateFormat compactDateFormat = DateFormat("yyyy-MM-dd", "en_US");
DateFormat dateFormat = DateFormat.yMEd("en_US").add_Hms();

//blue light #93dbe9
//blue dark #689cc5

// Theme
ThemeData themeData = ThemeData(
  inputDecorationTheme: _inputDecorationTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  cardTheme: _cardTheme,
  scaffoldBackgroundColor: kLightColor,
  textTheme: _textTheme,
  pageTransitionsTheme: _pageTransitionsTheme,
  scrollbarTheme: _scrollbarThemeData,
);

InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: kLightColor,
  border: UnderlineInputBorder(
    borderRadius: kBorderRadius,
  ),
);

ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(kActiveColor),
    foregroundColor: MaterialStateProperty.all(kLightColor),
    elevation: MaterialStateProperty.all(kElevation),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: kBorderRadius,
      ),
    ),
  ),
);

CardTheme _cardTheme = CardTheme(
  shadowColor: kDarkColor,
  color: kSurfaceColor,
  elevation: kElevation,
  shape: RoundedRectangleBorder(
    borderRadius: kBorderRadius,
  ),
);

TextTheme _textTheme = GoogleFonts.latoTextTheme().apply(
  bodyColor: kDarkColor,
);

PageTransitionsTheme _pageTransitionsTheme = const PageTransitionsTheme(
  builders: {
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  },
);

ScrollbarThemeData _scrollbarThemeData = const ScrollbarThemeData(
  isAlwaysShown: true,
);
