import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whaloo_genuinity/constants/lib_color_schemes.g.dart';

const Color kWarningColor = Colors.orange;
final Color kErrorColor = Colors.red.shade200;

BorderRadius kBorderRadius = const BorderRadius.all(Radius.circular(10));

const double kElevation = 3;

const double kSpacing = 5;

const double kIconButtonSplashRadius = 25;

// Theme
var colorScheme = lightColorScheme;
final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  inputDecorationTheme: _inputDecorationTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  cardTheme: _cardTheme,
  textTheme: _textTheme,
  pageTransitionsTheme: _pageTransitionsTheme,
  scrollbarTheme: _scrollbarThemeData,
  floatingActionButtonTheme: _floatingActionButtonThemeData,
);

final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
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

final _floatingActionButtonThemeData = FloatingActionButtonThemeData(
  elevation: kElevation,
  focusElevation: kElevation,
  hoverElevation: kElevation + 1,
  shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
);

const ScrollbarThemeData _scrollbarThemeData = ScrollbarThemeData(
  isAlwaysShown: true,
);
