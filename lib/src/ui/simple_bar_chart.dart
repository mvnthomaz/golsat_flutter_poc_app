import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:share/share.dart';

class SimpleBarChart extends StatefulWidget {
  @override
  _SimpleBarChartPage createState() => _SimpleBarChartPage.withSampleData();
}

class _SimpleBarChartPage extends State<SimpleBarChart> {

  final List<charts.Series> seriesList;
  final bool animate;

  _SimpleBarChartPage(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory _SimpleBarChartPage.withSampleData() {
    return new _SimpleBarChartPage(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Simples chart'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(icon: Icon(Icons.share), onPressed: () async {
              Share.share('Exportar dados');
            }),
          ),
        ],

      ),
      body : new charts.BarChart(
        seriesList,
        animate: animate,
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 75),
      new OrdinalSales('2019', 75),
      new OrdinalSales('2020', 75),
      new OrdinalSales('2021', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}