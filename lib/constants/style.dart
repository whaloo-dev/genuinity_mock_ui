import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whaloo_genuinity/constants/lib_color_schemes.g.dart';

const Color kWarningColor = Colors.orange;
final Color kErrorColor = Colors.red.shade200;

BorderRadius kBorderRadius = const BorderRadius.all(Radius.circular(10));

const double kElevation = 3;

const double kSpacing = 8;

const double kSplashRadius = 25;

const Duration kAnimationDuration = Duration(milliseconds: 300);

const double kSmallImage = 50;
const double kLargeImage = 70;

// Theme
var colorScheme = lightColorScheme;
// var colorScheme = ColorScheme.fromSeed(
//     seedColor: Colors.transparent, brightness: Brightness.dark);

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  inputDecorationTheme: _inputDecorationTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  cardTheme: _cardTheme,
  textTheme: _textTheme,
  pageTransitionsTheme: _pageTransitionsTheme,
  scrollbarTheme: _scrollbarThemeData,
  floatingActionButtonTheme: _floatingActionButtonThemeData,
  listTileTheme: _listTileThemeData,
  checkboxTheme: _checkboxTheme,
);

final _checkboxTheme = CheckboxThemeData(
  checkColor: MaterialStateProperty.all(colorScheme.onPrimary),
  fillColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.6)),
  splashRadius: kSplashRadius,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

final _listTileThemeData = ListTileThemeData(
  selectedTileColor: colorScheme.primary.withOpacity(0.05),
  textColor: colorScheme.onBackground,
);

final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: kBorderRadius,
  ),
);

final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.all(kSpacing * 2)),
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
  bodyColor: colorScheme.onBackground,
);

const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  },
);

final _floatingActionButtonThemeData = FloatingActionButtonThemeData(
  elevation: kElevation,
  focusElevation: kElevation + 1,
  hoverElevation: kElevation + 1,
  shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
);

const ScrollbarThemeData _scrollbarThemeData = ScrollbarThemeData(
  isAlwaysShown: true,
);
