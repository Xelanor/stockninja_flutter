import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class WilliamsChart extends StatefulWidget {
  final List<dynamic> data;
  final int graphPeriod;

  WilliamsChart(this.data, this.graphPeriod);

  @override
  _WilliamsChartState createState() => _WilliamsChartState();
}

class _WilliamsChartState extends State<WilliamsChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Williams",
        data: widget.data.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
      // charts.Series(
      //   id: "Dummy1",
      //   data: List.generate(widget.graphPeriod, (i) => 80),
      //   domainFn: (point, i) => i,
      //   measureFn: (point, i) => point,
      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(
      //       Theme.of(context).colorScheme.onSecondary),
      // ),
      // charts.Series(
      //   id: "Dummy2",
      //   data: List.generate(widget.graphPeriod, (i) => 20),
      //   domainFn: (point, i) => i,
      //   measureFn: (point, i) => point,
      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(
      //       Theme.of(context).colorScheme.onSecondary),
      // ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Williams Index',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: charts.LineChart(
              series,
              animate: true,
              domainAxis: charts.NumericAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 12, // size in Pts.
                      color: charts.ColorUtil.fromDartColor(Colors.grey[400])),
                  lineStyle: charts.LineStyleSpec(
                      color: charts.ColorUtil.fromDartColor(Colors.grey)),
                ),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                viewport: charts.NumericExtents(-100.0, 0.0),
                tickProviderSpec:
                    charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
                renderSpec: charts.GridlineRendererSpec(
                  labelOffsetFromAxisPx: 15,
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 12, // size in Pts.
                      color: charts.ColorUtil.fromDartColor(Colors.grey[300])),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Color.fromRGBO(194, 79, 61, 0.4)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
