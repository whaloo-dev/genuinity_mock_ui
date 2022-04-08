import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';

extension RangeValuesText on RangeValues {
  String toText(int min, int max) {
    final s = numberFormat.format(start);
    final e = numberFormat.format(end);
    if (start == end) {
      return "= $s";
    }
    if (start == min) {
      if (end < max) {
        return "≤ $e";
      }
      return "";
    }
    if (end == max) {
      return "≥ $s";
    }
    return "between $s and $e";
  }
}
