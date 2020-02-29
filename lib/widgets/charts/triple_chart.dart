import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TripleChart extends StatefulWidget {
  final List<dynamic> closes;
  final List<dynamic> first_list;
  final List<dynamic> second_list;
  final List<dynamic> third_list;
  final int graphPeriod;

  TripleChart(this.closes, this.first_list, this.second_list, this.third_list,
      this.graphPeriod);

  @override
  _TripleChartState createState() => _TripleChartState();
}

class _TripleChartState extends State<TripleChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Closes",
        data: widget.closes.sublist(widget.closes.length - widget.graphPeriod),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
      charts.Series(
        id: "First",
        data: widget.first_list.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
      ),
      charts.Series(
        id: "Second",
        data: widget.second_list.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
      ),
      charts.Series(
        id: "Third",
        data: widget.third_list.sublist(90 - widget.graphPeriod, 90),
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
            'Triple Index',
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
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    dataIsInWholeNumbers: false,
                    zeroBound: false,
                    desiredTickCount: 10),
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
