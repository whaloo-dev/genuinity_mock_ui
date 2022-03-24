import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';

extension Tokenizer on String {
  List<String> tokenize() {
    final _tokens = <String>[];
    final _searchTextSplitted = toLowerCase()
        .split(RegExp(r"[\s|\#|\(|\)|\+|\-|\*|\!|\?|\.|\*|\=|\:|\.|\/]"));
    for (int i = 0; i < _searchTextSplitted.length; i++) {
      final keyword = _searchTextSplitted[i].trim();
      if (keyword.isNotEmpty) {
        _tokens.add(keyword);
      }
    }
    return _tokens;
  }
}

extension Search on List<String> {
  bool startsWithAll(List<String> other) {
    bool startsWithAll = true;
    for (var otherItem in other) {
      bool startsWithItem = false;
      for (var thisItem in this) {
        startsWithItem = startsWithItem || thisItem.startsWith(otherItem);
        if (startsWithItem) {
          break;
        }
      }
      startsWithAll = startsWithAll && startsWithItem;
      if (!startsWithAll) {
        break;
      }
    }
    return startsWithAll;
  }
}

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
