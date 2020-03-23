import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class IntradayChart extends StatefulWidget {
  final List<dynamic> data;

  IntradayChart(this.data);

  @override
  _IntradayChartState createState() => _IntradayChartState();
}

class _IntradayChartState extends State<IntradayChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Intraday",
        data: widget.data,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            '2 günlük hareketler',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: charts.LineChart(
              series,
              animate: true,
              behaviors: [
                new charts.RangeAnnotation([
                  new charts.RangeAnnotationSegment(0, widget.data.length / 2,
                      charts.RangeAnnotationAxisType.domain,
                      color:
                          charts.ColorUtil.fromDartColor(Colors.grey.shade900)),
                ]),
              ],
              domainAxis: charts.NumericAxisSpec(
                renderSpec: charts.NoneRenderSpec(),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    zeroBound: false,
                    desiredTickCount: 10,
                    dataIsInWholeNumbers: false),
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
