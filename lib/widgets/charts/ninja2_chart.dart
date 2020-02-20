import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Ninja2Chart extends StatefulWidget {
  List<dynamic> data;
  final int graphPeriod;

  Ninja2Chart(this.data, this.graphPeriod);

  @override
  _Ninja2ChartState createState() => _Ninja2ChartState();
}

class _Ninja2ChartState extends State<Ninja2Chart> {
  @override
  Widget build(BuildContext context) {
    widget.data = widget.data.map((d) => d * 100).toList();
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Ninja2",
        data: widget.data.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
      charts.Series(
        id: "Dummy2",
        data: widget.data.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(255, 255, 255, 1)),
      )..setAttribute(charts.rendererIdKey, 'customPoint'),
      charts.Series(
        id: "Dummy1",
        data: List.generate(widget.graphPeriod, (i) => 0),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.onSecondary),
        strokeWidthPxFn: (_, __) => 0.5,
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Ninja Index 2',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: charts.LineChart(
              series,
              animate: true,
              defaultRenderer: charts.LineRendererConfig(),
              customSeriesRenderers: [
                charts.PointRendererConfig(
                  customRendererId: 'customPoint',
                  strokeWidthPx: 0.01,
                  radiusPx: 2,
                )
              ],
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
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  dataIsInWholeNumbers: false,
                  zeroBound: false,
                ),
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
