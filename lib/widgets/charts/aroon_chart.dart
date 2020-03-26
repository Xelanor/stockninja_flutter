import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AroonChart extends StatefulWidget {
  final List<dynamic> upperList;
  final List<dynamic> lowerList;
  final int graphPeriod;

  AroonChart(this.upperList, this.lowerList, this.graphPeriod);

  @override
  _AroonChartState createState() => _AroonChartState();
}

class _AroonChartState extends State<AroonChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Upper",
        data: widget.upperList.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
      ),
      charts.Series(
        id: "Lower",
        data: widget.lowerList.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Aroon Index',
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
                viewport: charts.NumericExtents(0.0, 100.0),
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
