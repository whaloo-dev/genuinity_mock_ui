import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const Color kSurfaceColor = Colors.white;
final Color kLightColor = Colors.grey.shade200;
final Color kLightGreyColor = Colors.grey.shade500;
const Color kDarkColor = Colors.black;
final Color kActiveColor = Colors.blue.shade500;
final Color kLogoColor = Colors.blueAccent.shade200;
const Color kWarningColor = Colors.orange;
final Color kErrorColor = Colors.red.shade200;
final Color kSelectionColor = Color.fromRGBO(
  kActiveColor.red + 10,
  kActiveColor.green + 10,
  kActiveColor.blue + 10,
  0.1,
);
final Color kHeaderColor = Color.fromRGBO(
  kLightColor.red + 10,
  kLightColor.red + 10,
  kLightColor.red + 10,
  1,
);

const double radius = 10;
BorderRadius kBorderRadius = const BorderRadius.only(
  topLeft: Radius.circular(radius),
  topRight: Radius.circular(radius),
  bottomLeft: Radius.circular(radius),
  bottomRight: Radius.circular(radius),
);

const double kElevation = 3;

const double kSpacing = 5;

const double kIconButtonSplashRadius = 25;

final NumberFormat numberFormat = NumberFormat("###,###", "en_US");
final NumberFormat compactNumberFormat = NumberFormat.compact(locale: "en_US");
final DateFormat dateFormat = DateFormat.yMEd("en_US").add_Hms();
final DateFormat compactDateFormat = DateFormat("yyyy-MM-dd", "en_US");

//blue light #93dbe9
//blue dark #689cc5

// Theme
final ThemeData themeData = ThemeData(
  inputDecorationTheme: _inputDecorationTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  cardTheme: _cardTheme,
  scaffoldBackgroundColor: kLightColor,
  textTheme: _textTheme,
  pageTransitionsTheme: _pageTransitionsTheme,
  scrollbarTheme: _scrollbarThemeData,
  unselectedWidgetColor: kDarkColor,
);

final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: kLightColor,
  border: UnderlineInputBorder(
    borderRadius: kBorderRadius,
  ),
);

final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
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

final CardTheme _cardTheme = CardTheme(
  shadowColor: kDarkColor,
  color: kSurfaceColor,
  elevation: kElevation,
  shape: RoundedRectangleBorder(
    borderRadius: kBorderRadius,
  ),
);

final TextTheme _textTheme = GoogleFonts.latoTextTheme().apply(
  bodyColor: kDarkColor,
);

const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  },
);

const ScrollbarThemeData _scrollbarThemeData = ScrollbarThemeData(
  isAlwaysShown: true,
);
