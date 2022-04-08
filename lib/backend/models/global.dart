enum TimeSpan {
  oneHour,
  oneDay,
  sevenDays,
  thirtyDays,
  threeMonthes,
  twelveMonthes,
  all,
}

extension TimeSpanExt on TimeSpan {
  String name() {
    switch (this) {
      case TimeSpan.oneHour:
        return "Show the last hour";
      case TimeSpan.oneDay:
        return "Show the last 24 hours";
      case TimeSpan.sevenDays:
        return "Show the last 7 days";
      case TimeSpan.thirtyDays:
        return "Show the last 30 days";
      case TimeSpan.threeMonthes:
        return "Show the last 3 monthes";
      case TimeSpan.twelveMonthes:
        return "Show the last 12 monthes";
      case TimeSpan.all:
        return "Show all";
    }
  }

  Duration? duration() {
    switch (this) {
      case TimeSpan.oneHour:
        return const Duration(hours: 1);
      case TimeSpan.oneDay:
        return const Duration(hours: 24);
      case TimeSpan.sevenDays:
        return const Duration(days: 7);
      case TimeSpan.thirtyDays:
        return const Duration(days: 30);
      case TimeSpan.threeMonthes:
        return const Duration(days: 90);
      case TimeSpan.twelveMonthes:
        return const Duration(days: 365);
      case TimeSpan.all:
        return null;
    }
  }
}

enum Sorting {
  dateAsc,
  dateDesc,
  scansAsc,
  scansDesc,
  scanErrorsAsc,
  scanErrorsDesc,
}

extension SortingExt on Sorting {
  String name() {
    switch (this) {
      case Sorting.dateAsc:
      case Sorting.dateDesc:
        return "Date";
      case Sorting.scansAsc:
      case Sorting.scansDesc:
        return "Scans";
      case Sorting.scanErrorsAsc:
      case Sorting.scanErrorsDesc:
        return "Scan Errors";
    }
  }

  String nameExtension() {
    switch (this) {
      case Sorting.dateAsc:
        return "most old first";
      case Sorting.dateDesc:
        return "most recent first";
      case Sorting.scansAsc:
        return "ascending";
      case Sorting.scansDesc:
        return "descending";
      case Sorting.scanErrorsAsc:
        return "ascending";
      case Sorting.scanErrorsDesc:
        return "descending";
    }
  }
}
