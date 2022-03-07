/// Bar chart with example of a legend with customized position, justification,
/// desired max rows, padding, and entry text styles. These options are shown as
/// an example of how to use the customizations, they do not necessary have to
/// be used together in this way. Choosing [end] as the position does not
/// require the justification to also be [endDrawArea].
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

class ChartRevenue extends StatelessWidget {
  final List<charts.Series<OrdinalSales, String>> seriesList;
  final bool animate;

  // ignore: use_key_in_widget_constructors
  const ChartRevenue(this.seriesList, {this.animate = true});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      // Add the legend behavior to the chart to turn on legends.
      // This example shows how to change the position and justification of
      // the legend, in addition to altering the max rows and padding.
      behaviors: [
        charts.SeriesLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: Responsive.isScreenLarge(context)
              ? charts.BehaviorPosition.end
              : charts.BehaviorPosition.top,
          // For a legend that is positioned on the left or right of the chart,
          // setting the justification for [endDrawArea] is aligned to the
          // bottom of the chart draw area.
          outsideJustification: charts.OutsideJustification.endDrawArea,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // By setting this value to 2, the legend entries will grow up to two
          // rows before adding a new column.
          desiredMaxRows: 2,
          // This defines the padding around each legend entry.
          cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Render the legend entry text with custom styles.
          entryTextStyle: const charts.TextStyleSpec(
            //color: charts.Color(r: 127, g: 63, b: 191),
            // fontFamily: 'Georgia',
            fontSize: 11,
          ),
        )
      ],
    );
  }
}

Widget revenueChartWithSampleData() {
  return ChartRevenue(
    _createSampleData(),
    // Disable animations for image tests.
    animate: true,
  );
}

/// Create series list with multiple series
List<charts.Series<OrdinalSales, String>> _createSampleData() {
  final desktopSalesData = [
    OrdinalSales('2014', 5),
    OrdinalSales('2015', 25),
    OrdinalSales('2016', 100),
    OrdinalSales('2017', 75),
  ];

  final mobileSalesData = [
    OrdinalSales('2014', 10),
    OrdinalSales('2015', 15),
    OrdinalSales('2016', 50),
    OrdinalSales('2017', 45),
  ];

  final otherSalesData = [
    OrdinalSales('2014', 20),
    OrdinalSales('2015', 35),
    OrdinalSales('2016', 15),
    OrdinalSales('2017', 10),
  ];

  return [
    charts.Series<OrdinalSales, String>(
      id: 'Desktop',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: desktopSalesData,
    ),
    charts.Series<OrdinalSales, String>(
      id: 'Mobile',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: mobileSalesData,
    ),
    charts.Series<OrdinalSales, String>(
      id: 'Other',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: otherSalesData,
    ),
  ];
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
