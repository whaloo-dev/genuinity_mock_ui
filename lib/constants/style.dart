import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whaloo_genuinity/constants/lib_color_schemes.g.dart';

const Color kWarningColor = Colors.orange;
final Color kErrorColor = Colors.red.shade200;

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

// Theme
// const colorScheme = lightColorScheme;
const colorScheme = darkColorScheme;
// final colorScheme =
//     ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);
// final colorScheme = ColorScheme.fromSwatch(
//     primarySwatch: Colors.brown, brightness: Brightness.dark);

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  inputDecorationTheme: _inputDecorationTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  cardTheme: _cardTheme,
  textTheme: _textTheme,
  pageTransitionsTheme: _pageTransitionsTheme,
  scrollbarTheme: _scrollbarThemeData,
);

final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  border: UnderlineInputBorder(
    borderRadius: kBorderRadius,
  ),
);

final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: MaterialStateProperty.all(kElevation),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: kBorderRadius,
      ),
    ),
  ),
);

final CardTheme _cardTheme = CardTheme(
  elevation: kElevation,
  shape: RoundedRectangleBorder(
    borderRadius: kBorderRadius,
  ),
);

final TextTheme _textTheme = GoogleFonts.robotoTextTheme().apply(
  bodyColor: colorScheme.onSurfaceVariant,
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
